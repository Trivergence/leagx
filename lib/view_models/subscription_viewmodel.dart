import 'package:flutter/material.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/subscription_plan.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/loader/loader.dart';

import '../constants/app_constants.dart';
import '../core/sharedpref/sharedpref.dart';
import '../models/dashboard/league.dart';
import '../models/user/user.dart';

class SubscriptionViewModel extends BaseModel {
  List<SubscriptionPlan> _listOfPlan = [];
  List<League> _leagues = [];
  // Remove them later
  List<String> saudiLeagueIds = ["278","605","277","604","536"];
  List<League> get leagues => _leagues;
  List<SubscriptionPlan> get getPlans => _listOfPlan;

  Future<void> getSubscriptionPlans() async {
    try {
      List<dynamic> tempList = await ApiService.getListRequest(
        baseUrl: AppUrl.baseUrl,
        url: AppUrl.getPlan,
        headers: {
          "apitoken": preferenceHelper.authToken,
        },
        modelName: ApiModels.getPlans
      );  
      _listOfPlan = tempList.cast<SubscriptionPlan>();
    } on Exception catch (e) {
      setBusy(false);
    }
  }
  subscribeLeague({required BuildContext context, required int planId, required String leagueId, required String leagueTitle, required String leagueImg}) async {
    Loader.showLoader();
    User? user = locator<SharedPreferenceHelper>().getUser();
    Map<String,dynamic> body = {
      "user_id": user!.id,
      "plan_id": planId,
      "league": {
        "title": leagueTitle,
        "logo": leagueImg,
        "external_league_id": leagueId
      }
    };
    bool success = await ApiService.postWoResponce(
      url: AppUrl.subscribeLeague,
      body: body);
    if(success) {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.dashboard, (route) => false);
      Loader.hideLoader();
    } else {
      Loader.hideLoader();
    }
  }
  Future<void> getLeagues() async {
    try {
      List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.footballBaseUrl,
          parameters: {
            "action": "get_leagues",
            "APIkey": AppConstants.footballApiKey
          },
          modelName: ApiModels.getLeagues);
      _leagues = tempList.cast<League>();
      // Remove this later
      _leagues = leagues.where((league) => saudiLeagueIds.contains(league.leagueId)).toList();
    } on Exception catch (e) {
      setBusy(false);
    }
  }

  List<League> searchLeague(String value) {
    return _leagues
        .where((league) =>
            league.leagueName.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }
}