import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:leagx/core/network/api/api_models.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/models/subscription_plan.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/app_dialogs/fancy_dialog.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../core/sharedpref/sharedpref.dart';
import '../models/dashboard/league.dart';
import '../models/user/user.dart';
import '../ui/util/locale/localization.dart';

class SubscriptionViewModel extends BaseModel {
  List<SubscriptionPlan> _listOfPlan = [];
  List<League> _leagues = [];
  // Remove them later
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
          modelName: ApiModels.getPlans);
      _listOfPlan = tempList.cast<SubscriptionPlan>();
    } on Exception catch (_) {
      setBusy(false);
    }
  }

  subscribeLeague(
      {required BuildContext context,
      required int planId,
      required String leagueId,
      required String leagueTitle,
      required String leagueImg,
      required String price}) async {
    Loader.showLoader();
    WalletViewModel walletModel = context.read<WalletViewModel>();
    bool isPurchased = await purchaseModel(walletModel, price);
    if (isPurchased) {
      User? user = locator<SharedPreferenceHelper>().getUser();
      Map<String, dynamic> body = {
        "user_id": user!.id,
        "plan_id": planId,
        "league": {"title": leagueTitle, "logo": leagueImg, "external_league_id": int.parse(leagueId)}
      };
      bool success = await ApiService.postWoResponce(url: AppUrl.subscribeLeague, body: body);
      if (success) {
        Loader.hideLoader();
        FancyDialog.showSuccess(
          context: context,
          title: loc.choosePlanDialogSuccessTitle,
          description: loc.choosePlanDialogSuccessDesc,
          onOkPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(Routes.dashboard, (route) => false),
        );
      } else {
        Loader.hideLoader();
      }
    } else {
      Loader.hideLoader();
    }
  }

  Future<void> getLeagues() async {
    try {
      List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.footballBaseUrl,
          parameters: {"action": "get_leagues", "APIkey": AppConstants.footballApiKey},
          modelName: ApiModels.getLeagues);
      _leagues = tempList.cast<League>();
    } on Exception catch (_) {
      setBusy(false);
    }
  }

  List<League> searchLeague(String value) {
    return _leagues.where((league) => league.leagueName.toLowerCase().contains(value.toLowerCase())).toList();
  }

  Future<bool> purchaseModel(WalletViewModel walletModel, String price) async {
    bool success = false;
    if (walletModel.getPayementMethods.isEmpty) {
      success = await walletModel.purchaseIndirectly(amount: price, currency: "usd");
    } else {
      success = await walletModel.purchaseDirectly(amount: price, currency: "usd");
    }
    return success;
  }
}
