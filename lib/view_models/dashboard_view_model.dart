import 'package:flutter/material.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/dashboard/events.dart';
import 'package:leagx/models/subscribed_league.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/utility/date_utility.dart';

import '../core/network/app_url.dart';
import '../models/user/user.dart';

class DashBoardViewModel extends BaseModel {

  List<Events> _upcomingMatches = [];
  List<SubscribedLeague> _subscribedLeagues = [];
  List<Events> get upcomingMatches => _upcomingMatches;
  List<SubscribedLeague> get subscribedLeagues => _subscribedLeagues;
  Future<void> getData() async {
    await getUpcomingMatches();
    await getUserLeagues();
  }

  Future<void> getUpcomingMatches() async {
     DateTime now = DateTime.now();
     _upcomingMatches = await ApiService.getMatches(
      parameters: {
        "action": "get_events",
        "timezone": "Asia/Karachi",
        "from": DateUtility.getApiFormat(now),
        "to": DateUtility.getApiFormat(now),
      },
    );
    _upcomingMatches = upcomingMatches.where((match) => isUpcoming(match, now)).toList();
    notifyListeners();
  }

  Future<void> getUserLeagues() async {
    User? user = locator<SharedPreferenceHelper>().getUser();
    String completeUrl = AppUrl.getUser + "${user!.id}" + "/subscribed_leagues";
    _subscribedLeagues = await ApiService.getUserLeagues(url: completeUrl);
  }

  bool isUpcoming(Events match, DateTime now) {
    DateTime today = DateTime(now.year, now.month, now.day);
    return today == match.matchDate;
  }

  List<Events> searchMatches(String value) {
    return _upcomingMatches
        .where((match) =>
            match.leagueName.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }
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
        //TODO: Add localized message
        ToastMessage.show("News added successfully", TOAST_TYPE.success);
        Navigator.of(context).pop();
      } else {
        //TODO: Add localized message
        print("failure");
      }
    }
  }
}