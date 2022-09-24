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
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../models/user/user.dart';

class ChoosePlanViewModel extends BaseModel {
  List<SubscriptionPlan> _listOfPlan = [];
  List<SubscriptionPlan> get getPlans => _listOfPlan;

  Future<void> getSubscriptionPlans() async {
    _listOfPlan = await ApiService.getPlans(url: AppUrl.getPlan);
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
}