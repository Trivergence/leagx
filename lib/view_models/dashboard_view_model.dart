
import 'package:flutter/material.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/dashboard/fixture.dart';
import 'package:leagx/models/subscribed_league.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/service/payment_service/payment_config.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../core/network/app_url.dart';
import '../core/sharedpref/sharedpref.dart';
import '../models/customer_cred.dart';
import '../models/dashboard/news.dart';
import '../models/leader.dart';
import '../models/user/user.dart';

class DashBoardViewModel extends BaseModel {

  UserSummary? _userSummary;
  List<Fixture> _subscribedMatches = [];
  List<SubscribedLeague> _subscribedLeagues = [];
  List<News> _news = [];
  List<Leader> _leaders = [];
  List<int> _subscribedLeagueIds = [];
  List<SubscribedLeague> get subscribedLeagues => _subscribedLeagues;
  List<Fixture> get subscribedMatches => _subscribedMatches;
  List<int> get subscribedLeagueIds => _subscribedLeagueIds;
  List<News> get getNews => _news;
  List<Leader> get getLeaders => _leaders;
  UserSummary? get userSummary => _userSummary; 
  Future<void> getData(BuildContext context) async {
    setBusy(true);
    try {
      await getSubscribedLeagues();
      await getAllLeaders();
      await getUserSummary();
      await getSubscribedMatches();
      setBusy(false);
      if(subscribedLeagues.isNotEmpty) {
        await getAllNews();
      }
      getPaymentCredentials(context);
    } on Exception catch (_) {
      setBusy(false);
    }
    
  }
    Future<void> getSubscribedMatches() async {
      // "from": DateUtility.getApiFormat(now),
      //       "to": DateUtility.getApiFormat(now.add(const Duration(days: 3))),
    if (subscribedLeagueIds.isNotEmpty) {
      try {
        DateTime now = DateTime.now();
        //TODO make dynamic timezone
        List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.footballBaseUrl,
          modelName: ApiModels.upcomingMatches,
          parameters: {
            "APIkey": AppConstants.footballApiKey,
            "action": "get_events",
            "timezone": "Asia/Riyadh",
            "league_id": subscribedLeagueIds.join(","),
            "from": "2021-01-01",
            "to": "2022-12-30",
          },
        );
        _subscribedMatches = tempList.cast<Fixture>();
        // _subscribedMatches =
        //     _subscribedMatches.where((match) => isValid(match, now)).toList();
      } on Exception catch (e) {
        setBusy(false);
      }
    } else {
      _subscribedMatches = [];
    }
    notifyListeners();
  }

  Future<void> getSubscribedLeagues() async {
    try {
      User? user = locator<SharedPreferenceHelper>().getUser();
      String completeUrl = AppUrl.getUser + "${user!.id}" + "/subscribed_leagues";
      List<dynamic> tempList = await ApiService.getListRequest(
        baseUrl: AppUrl.baseUrl,
        url: completeUrl,
        headers: {
          "apitoken": preferenceHelper.authToken,
        },
        modelName: ApiModels.getSubscribedLeagues
        );
        _subscribedLeagues = tempList.cast<SubscribedLeague>();
      _subscribedLeagueIds = getSubscribedIds();
    } on Exception catch (_) {
      setBusy(false);
    }
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
  int? getLeagueInternalId (String externalId) {
    try {
      List<SubscribedLeague> listOfLeague = _subscribedLeagues
      .where((league) => league.externalLeagueId.toString() == externalId)
      .toList();
      if(listOfLeague.isNotEmpty) {
        return listOfLeague.first.id;
      } else {
        return null;
      }
    } on Exception catch (_) {
      setBusy(false);
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
      try {
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
          ToastMessage.show(loc.dashboardNewsAddNewsTxtSuccess, TOAST_TYPE.success);
          Navigator.of(context).pop();
          await getAllNews();
          notifyListeners();
        } else {
          ToastMessage.show(
              loc.errorTryAgain, TOAST_TYPE.error);
        }
      } on Exception catch (e) {
        setBusy(false);
      }
    }
  }
  Future<void> getAllNews() async {
    User? user = locator<SharedPreferenceHelper>().getUser();
    if(user != null) {
      try {
        String completeUrl = AppUrl.getUser + user.id.toString() + AppUrl.subscribedNews;
        List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.baseUrl,
          url: completeUrl,
          headers: {
            "apitoken": preferenceHelper.authToken,
          },
          modelName: ApiModels.getNews
        );
        _news = tempList.cast<News>();
      } on Exception catch (e) {
        setBusy(false);
      }
    }
  }
    Future<void> getAllLeaders() async {
      try {
        String completeUrl =
            AppUrl.getUser + AppUrl.getLeaders;
        List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.baseUrl,
          url: completeUrl,
          modelName: ApiModels.getLeaders,
          headers: {
          "apitoken": preferenceHelper.authToken,
        },
            );
            _leaders = tempList.cast<Leader>();
      } on Exception catch (e) {
        setBusy(false);
      }
  }
  notify() {
    notifyListeners();
  }

  List<News> getNewsbyLeague(String externalId) {
    try {
      int? id = getLeagueInternalId(externalId);
      if(id == null) {
        return [];
      } else {
      return _news
            .where(
                (newsItems) => newsItems.leagueId == id)
            .toList();
      }
    } on Exception catch (e) {
      setBusy(false);
      return [];
    }
  }
  getUserSummary() async {
    User? user = preferenceHelper.getUser();
    if(user != null) {
      String completeUrl = AppUrl.getUser + user.id.toString();
      _userSummary = await  ApiService.callGetApi(url: completeUrl, modelName: ApiModels.userSummary);
    }
  }
  void getPaymentCredentials(BuildContext context) async {
    User? user = preferenceHelper.getUser();
    if(user != null && locator<PaymentConfig>().getCustomerCred == null) {
      List<dynamic> tempList= await ApiService.getListRequest(
        baseUrl: AppUrl.baseUrl,
        url: AppUrl.getPaymentAccounts,
        modelName: ApiModels.paymentAccounts,
      );
      List<CustomerCred> listOfCred = tempList.cast<CustomerCred>().where((userCred) => userCred.userId == user.id).toList();
      if(listOfCred.isNotEmpty) {
        locator<PaymentConfig>().setCustomerCred = listOfCred.where((userCred) => userCred.userId == user.id).toList().first;
      } else {
        context.read<WalletViewModel>().createCustomer(userData: user);
      }
    }
  }

  clearData() {
    _subscribedMatches = [];
    _subscribedLeagues = [];
    _news = [];
    _subscribedLeagueIds = [];
  }
}