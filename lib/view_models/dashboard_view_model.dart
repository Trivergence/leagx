import 'package:flutter/material.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/dashboard/fixture.dart';
import 'package:leagx/models/subscribed_league.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/utility/date_utility.dart';

import '../constants/app_constants.dart';
import '../core/network/app_url.dart';
import '../core/sharedpref/sharedpref.dart';
import '../models/dashboard/news.dart';
import '../models/leader.dart';
import '../models/user/user.dart';

class DashBoardViewModel extends BaseModel {

  //List<Fixture> _upcomingMatches = [];
  List<Fixture> _subscribedMatches = [];
  List<SubscribedLeague> _subscribedLeagues = [];
  List<News> _news = [];
  List<Leader> _leaders = [];
  List<int> _subscribedLeagueIds = [];
  //List<Fixture> get upcomingMatches => _upcomingMatches;
  List<SubscribedLeague> get subscribedLeagues => _subscribedLeagues;
  List<Fixture> get subscribedMatches => _subscribedMatches;
  List<int> get subscribedLeagueIds => _subscribedLeagueIds;
  List<News> get getNews => _news;
  List<Leader> get getLeaders => _leaders;
  Future<void> getData() async {
    setBusy(true);
    try {
      await getSubscribedLeagues();
      //await getUpcomingMatches();
      await getAllLeaders();
      if(subscribedLeagues.isNotEmpty) {
        await getAllNews();
        await getSubscribedMatches();
      }
    } on Exception catch (_) {
      setBusy(false);
    }
    setBusy(false);
  }

  // Future<void> getUpcomingMatches() async {
  //    DateTime now = DateTime.now();
  //    //TODO make dynamic timezone
  //    List<dynamic> tempList = await ApiService.getListRequest(
  //     baseUrl: AppUrl.footballBaseUrl,
  //     modelName: ApiModels.upcomingMatches,
  //     parameters: {
  //       "APIkey": AppConstants.footballApiKey,
  //       "action": "get_events",
  //       "timezone": "Asia/Riyadh",
  //       "from": DateUtility.getApiFormat(now),
  //       "to": DateUtility.getApiFormat(now),
  //     },
  //   );
  //   _upcomingMatches = tempList.cast<Fixture>();
  //   _upcomingMatches = upcomingMatches.where((match) => isUpcoming(match, now)).toList();
  //   notifyListeners();
  // }
    Future<void> getSubscribedMatches() async {
    if (subscribedLeagueIds.isNotEmpty) {
      DateTime now = DateTime.now();
      print(DateUtility.getApiFormat(now));
      print(DateUtility.getApiFormat(now.add(const Duration(days: 20))));
      //TODO make dynamic timezone
      List<dynamic> tempList = await ApiService.getListRequest(
        baseUrl: AppUrl.footballBaseUrl,
        modelName: ApiModels.upcomingMatches,
        parameters: {
          "APIkey": AppConstants.footballApiKey,
          "action": "get_events",
          "timezone": "Asia/Riyadh",
          "league_id": subscribedLeagueIds.join(","),
          "from": DateUtility.getApiFormat(now),
          "to": DateUtility.getApiFormat(now.add(const Duration(days: 3))),
        },
      );
      _subscribedMatches = tempList.cast<Fixture>();
      _subscribedMatches =
          _subscribedMatches.where((match) => isValid(match, now)).toList();
    } else {
      _subscribedMatches = [];
    }
    notifyListeners();
  }

  Future<void> getSubscribedLeagues() async {
    User? user = locator<SharedPreferenceHelper>().getUser();
    String completeUrl = AppUrl.getUser + "${user!.id}" + "/subscribed_leagues";
    List<dynamic> tempList = await ApiService.getListRequest(
      baseUrl: AppUrl.baseUrl,
      url: completeUrl,
      headers: {
        "apitoken": preferenceHelper.authToken,
      },
      modelName: ApiModels.getSubscribedLeagues
      ) as List<SubscribedLeague>;
      _subscribedLeagues = tempList.cast<SubscribedLeague>();
    _subscribedLeagueIds = getSubscribedIds();
    print(_subscribedLeagueIds);
  }

  List<int> getSubscribedIds() {
    return _subscribedLeagues
        .map((league) => league.externalLeagueId)
        .toList();
  }

  bool isValid(Fixture match, DateTime now) {
    String matchStatus = match.matchStatus!;
    if(matchStatus == "Fisnished" ||
     matchStatus == "After ET" ||
     matchStatus == "After Pen." ||
     matchStatus == "Cancelled" || 
     matchStatus == "Awarded" 
     //match.matchDate.isBefore(now)
     ) {
      return false;
    }
    return true;
  }

  // List<Fixture> searchMatches(String value) {
  //   return _upcomingMatches
  //       .where((match) =>
  //           match.leagueName.toLowerCase().contains(value.toLowerCase()))
  //       .toList();
  // }
  int? getLeagueInternalId (String externalId) {
    List<SubscribedLeague> listOfLeague = _subscribedLeagues
    .where((league) => league.externalLeagueId.toString() == externalId)
    .toList();
    if(listOfLeague.isNotEmpty) {
      return listOfLeague.first.id;
    } else {
      return null;
    }
 
  }
  Future<void> addNews({
    required BuildContext context,
    required String title,
    required String desc,
    required String matchId,
    required String leagueId}) async {
    User? user = locator<SharedPreferenceHelper>().getUser();
    int? internalLeagueId = getLeagueInternalId(leagueId);
    if (user != null && internalLeagueId != null) {
      Loader.showLoader();
      Map<String,dynamic> requestBody = {
        "news":{
            "title": title,
            "description": desc,
            "user_id": user.id,
            "league_id": internalLeagueId,
            "match_id": int.parse(matchId)
          }
        };
      bool success = await ApiService.postWoResponce(url: AppUrl.addNews,
        body: requestBody
      );
      if(success) {
        Loader.hideLoader();
        //TODO: Add localized message
        ToastMessage.show("News added successfully", TOAST_TYPE.success);
        Navigator.of(context).pop();
        await getAllNews();
        notifyListeners();
      } else {
        //TODO: Add localized message
        print("failure");
      }
    }
  }
  Future<void> getAllNews() async {
    User? user = locator<SharedPreferenceHelper>().getUser();
    if(user != null) {
      String completeUrl = AppUrl.getUser + user.id.toString() + AppUrl.subscribedNews;
      _news = await ApiService.getListRequest(
        baseUrl: AppUrl.baseUrl,
        url: completeUrl,
        headers: {
          "apitoken": preferenceHelper.authToken,
        },
        modelName: ApiModels.getNews
      );
    }
  }
    Future<void> getAllLeaders() async {
      String completeUrl =
          AppUrl.getUser + AppUrl.getLeaders;
      _leaders = await ApiService.getListRequest(
        baseUrl: AppUrl.baseUrl,
        url: completeUrl,
        modelName: ApiModels.getLeaders,
        headers: {
        "apitoken": preferenceHelper.authToken,
      },
    );
  }

  List<News> getNewsbyLeague(String externalId) {
    int? id = getLeagueInternalId(externalId);
    if(id == null) {
      return [];
    } else {
    return _news
          .where(
              (newsItems) => newsItems.leagueId == id)
          .toList();
    }
  }
  clearData() {
    //_upcomingMatches = [];
    _subscribedMatches = [];
    _subscribedLeagues = [];
    _news = [];
    _subscribedLeagueIds = [];
  }
}