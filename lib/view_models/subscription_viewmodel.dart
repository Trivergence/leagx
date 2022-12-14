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
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
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

  Future<void> getSubscriptionPlans({bool showToast = true}) async {
    try {
      List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.baseUrl,
          url: AppUrl.getPlan,
          headers: {
            "apitoken": preferenceHelper.authToken,
          },
          modelName: ApiModels.getPlans,
          showToast: showToast);
      _listOfPlan = tempList.cast<SubscriptionPlan>();
    } on Exception catch (e) {
      debugPrint(e.toString());
      setBusy(false);
    }
  }

  Future<void> loadData(BuildContext context) async {
    DashBoardViewModel dashBoardViewModel = context.read<DashBoardViewModel>();
    setBusy(true);
    try {
      await dashBoardViewModel.getSubscribedLeagues();
      await dashBoardViewModel.getSubscribedMatches();
      await dashBoardViewModel.getUserSummary();
      setBusy(false);
      await dashBoardViewModel.getAllNews();
      dashBoardViewModel.notify();
    } on Exception catch (_) {
      setBusy(false);
    }
  }

  subscribeLeagueByCard(
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
        "league": {
          "title": leagueTitle,
          "logo": leagueImg,
          "external_league_id": int.parse(leagueId)
        }
      };
      bool success = await ApiService.postWoResponce(
          url: AppUrl.subscribeLeague, body: body);
      if (success) {
        Loader.hideLoader();
        FancyDialog.showSuccess(
          context: context,
          title: loc.choosePlanDialogSuccessTitle,
          description: loc.choosePlanDialogSuccessDesc,
          onOkPressed: () async {
            Navigator.of(context).popUntil((route) {
              return route.settings.name == Routes.chooseLeague;
            });
            await loadData(context);
          },
        );
      } else {
        Loader.hideLoader();
      }
    } else {
      Loader.hideLoader();
    }
  }

  upgradeLeagueByCard(
      {required BuildContext context,
      required int planId,
      required String leagueId,
      required String leagueTitle,
      required String leagueImg,
      required String price}) async {
    Loader.showLoader();
    WalletViewModel walletModel = context.read<WalletViewModel>();
    bool isPurchased = await purchaseModel(walletModel, price);
    if (isPurchased == true) {
      User? user = locator<SharedPreferenceHelper>().getUser();
      int? internalLeagueId = context
          .read<DashBoardViewModel>()
          .getLeagueInternalId(leagueId.toString());
      if (user != null && internalLeagueId != null) {
        bool isUnsubscribed = await unsubscribeLeague(
            context: context, leagueId: internalLeagueId);
        if (isUnsubscribed == true) {
          Map<String, dynamic> body = {
            "user_id": user.id,
            "plan_id": planId,
            "league": {
              "title": leagueTitle,
              "logo": leagueImg,
              "external_league_id": int.parse(leagueId)
            }
          };
          bool success = await ApiService.postWoResponce(
              url: AppUrl.subscribeLeague, body: body);
          if (success) {
            Loader.hideLoader();
            FancyDialog.showSuccess(
              context: context,
              title: loc.choosePlanDialogUpgradeSuccessTitle,
              description: loc.choosePlanDialogUpgradeSuccessDesc,
              onOkPressed: () async {
                Navigator.of(context).popUntil((route) {
                  return route.settings.name == Routes.chooseLeague;
                });
                await loadData(context);
              },
            );
          } else {
            Loader.hideLoader();
          }
        } else {
          ToastMessage.show(loc.somethingWentWrong, TOAST_TYPE.error);
        }
      } else {
        ToastMessage.show(loc.somethingWentWrong, TOAST_TYPE.error);
      }
    } else {
      Loader.hideLoader();
    }
  }

  subscribeLeagueByCoin(
      {required BuildContext context,
      required int planId,
      required String leagueId,
      required String leagueTitle,
      required String leagueImg,
      required String price}) async {
    Loader.showLoader();
    User? user = locator<SharedPreferenceHelper>().getUser();
    if (user != null) {
      Map<String, dynamic> body = {
        "user_id": user.id,
        "plan_id": planId,
        "pay_by_wallet": true,
        "league": {
          "title": leagueTitle,
          "logo": leagueImg,
          "external_league_id": int.parse(leagueId)
        }
      };
      bool success = await ApiService.postWoResponce(
          url: AppUrl.subscribeLeague, body: body);
      if (success == true) {
        Loader.hideLoader();
        FancyDialog.showSuccess(
          context: context,
          title: loc.choosePlanDialogSuccessTitle,
          description: loc.choosePlanDialogSuccessDesc,
          onOkPressed: () {
            loadData(context);
            Navigator.of(context).popUntil((route) {
              return route.settings.name == Routes.chooseLeague;
            });
          },
        );
      } else {
        Loader.hideLoader();
      }
    } else {
      Loader.hideLoader();
    }
  }

  upgradeLeagueByCoin(
      {required BuildContext context,
      required int planId,
      required String leagueId,
      required String leagueTitle,
      required String leagueImg,
      required String price}) async {
    Loader.showLoader();
    User? user = locator<SharedPreferenceHelper>().getUser();
    if (user != null) {
      int? internalLeagueId = context
          .read<DashBoardViewModel>()
          .getLeagueInternalId(leagueId.toString());
      if (internalLeagueId != null) {
        bool isUnsubscribed = await unsubscribeLeague(
            context: context, leagueId: internalLeagueId);
        if (isUnsubscribed == true) {
          Map<String, dynamic> body = {
            "user_id": user.id,
            "plan_id": planId,
            "pay_by_wallet": true,
            "league": {
              "title": leagueTitle,
              "logo": leagueImg,
              "external_league_id": int.parse(leagueId)
            }
          };
          bool success = await ApiService.postWoResponce(
              url: AppUrl.subscribeLeague, body: body);
          if (success == true) {
            Loader.hideLoader();
            FancyDialog.showSuccess(
              context: context,
              title: loc.choosePlanDialogUpgradeSuccessTitle,
              description: loc.choosePlanDialogUpgradeSuccessDesc,
              onOkPressed: () {
                loadData(context);
                Navigator.of(context).popUntil((route) {
                  return route.settings.name == Routes.chooseLeague;
                });
              },
            );
          } else {
            Loader.hideLoader();
          }
        } else {
          ToastMessage.show(loc.somethingWentWrong, TOAST_TYPE.error);
        }
      } else {
        ToastMessage.show(loc.somethingWentWrong, TOAST_TYPE.error);
      }
    } else {
      Loader.hideLoader();
    }
  }

  // void showUnsubscribeDialog({required  BuildContext context, required int leagueId}) {
  //   ConfirmationDialog.show(context: context,
  //   title: loc.chooseLeagueDialogTitle,
  //   body: loc.chooseLeagueDialogbody,
  //   negativeBtnTitle: loc.chooseLeagueDialogBtnCancel,
  //   positiveBtnTitle: loc.chooseLeagueDialogBtnConfirm,
  //   onPositiveBtnPressed: (dialogContext) async {
  //     bool isConnnected = await InternetInfo.isConnected();
  //     if (isConnnected == true) {
  //       Navigator.of(dialogContext).pop();
  //       await unsubscribeLeague(context: context, leagueId: leagueId);
  //     }
  //   });
  // }

  Future<bool> unsubscribeLeague({
    required BuildContext context,
    required int leagueId,
  }) async {
    bool success = false;
    Loader.showLoader();
    User? user = locator<SharedPreferenceHelper>().getUser();
    if (user != null) {
      success = await ApiService.callPutApiWoResponce(
          body: {"league_id": leagueId, "user_id": user.id},
          url: AppUrl.unsubscribeLeague);
    } else {
      ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.error);
      success = false;
    }
    return success;
  }

  Future<void> getLeagues({bool showToast = true}) async {
    try {
      List<dynamic> tempList = await ApiService.getListRequest(
          baseUrl: AppUrl.baseUrl + AppUrl.getLeaguesList,
          modelName: ApiModels.getLeagues,
          showToast: showToast);
      _leagues = tempList.cast<League>();
    } on Exception catch (_) {
      setBusy(false);
    }
  }

  List<League> searchLeague(String value) {
    return _leagues
        .where((league) =>
            league.leagueName.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  Future<bool> purchaseModel(WalletViewModel walletModel, String price) async {
    bool success = false;
    if (walletModel.getPayementMethods.isEmpty) {
      success =
          await walletModel.purchaseIndirectly(amount: price, currency: "usd");
    } else {
      success =
          await walletModel.purchaseDirectly(amount: price, currency: "usd");
    }
    return success;
  }
}
