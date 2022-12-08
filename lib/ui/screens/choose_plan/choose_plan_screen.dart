import 'package:leagx/models/choose_plan_args.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/ui/util/app_dialogs/payment_method_dialog.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:leagx/view_models/subscription_viewmodel.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:payments/payments.dart';
import 'package:provider/provider.dart';

import '../../../constants/assets.dart';
import '../../../constants/enums.dart';
import '../../../core/network/internet_info.dart';
import '../../util/app_dialogs/confirmation_dialog.dart';
import '../../widgets/bar/app_bar_widget.dart';
import 'components/plan_listing.dart';

// ignore: must_be_immutable
class ChoosePlanScreen extends StatelessWidget {
  final ChoosePlanArgs leagueData;
  ChoosePlanScreen({Key? key, required this.leagueData}) : super(key: key);

  UserSummary? _userSummary;
  late BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    _userSummary = context.read<DashBoardViewModel>().userSummary;
    return Scaffold(
      appBar: AppBarWidget(title: loc.choosePlanTxtChooseAPlan),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              ImageWidget(
                  imageUrl: leagueData.leagueImg,
                  placeholder: Assets.icPlayerAvatar),
              UIHelper.verticalSpace(8),
              TextWidget(text: leagueData.leagueTitle),
              UIHelper.verticalSpace(70),
              PlanListing(
                isAdmin: true,
                onItemPressed: (planId, price) {
                  if (_userSummary != null &&
                      _userSummary!.coinEarned!.round() >= int.parse(price)) {
                    if (leagueData.isRedeeming == true) {
                      if (leagueData.isUpgrading == true) {
                        showUpgradeSubscriptionDialog(
                            type: PaymentType.wallet,
                            price: price,
                            planId: planId);
                      } else {
                        showConfirmSubscriptionDialog(
                            type: PaymentType.wallet,
                            price: price,
                            planId: planId);
                      }
                    } else {
                      PaymentMethodDialog.show(
                          context: context,
                          title: loc.choosePlanDialogSelectPayment,
                          negativeBtnTitle: loc.choosePlanDialogBtnNegative,
                          positiveBtnTitle: loc.choosePlanDialogBtnPositive,
                          onPositiveBtnPressed: (ctx, paymentType) {
                            Navigator.of(context).pop();
                            switch (paymentType) {
                              case PaymentType.wallet:
                                if (leagueData.isUpgrading == true) {
                                  showUpgradeSubscriptionDialog(
                                      type: PaymentType.wallet,
                                      price: price,
                                      planId: planId);
                                } else {
                                  showConfirmSubscriptionDialog(
                                      type: PaymentType.wallet,
                                      price: price,
                                      planId: planId);
                                }
                                break;
                              case PaymentType.card:
                                if (leagueData.isUpgrading == true) {
                                  showUpgradeSubscriptionDialog(
                                      type: PaymentType.card,
                                      price: price,
                                      planId: planId);
                                } else {
                                  showConfirmSubscriptionDialog(
                                      type: PaymentType.card,
                                      price: price,
                                      planId: planId);
                                }
                                break;
                            }
                          });
                    }
                  } else {
                    if (leagueData.isRedeeming == false) {
                      if (leagueData.isUpgrading == true) {
                        showUpgradeSubscriptionDialog(
                            type: PaymentType.card,
                            price: price,
                            planId: planId);
                      } else {
                        showConfirmSubscriptionDialog(
                            type: PaymentType.card,
                            price: price,
                            planId: planId);
                      }
                    } else {
                      ToastMessage.show(
                          loc.choosePlanTxtLessCoins, TOAST_TYPE.msg);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _subscribeByCard(BuildContext context, int planId, String price,
      BuildContext dialogContext) async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected == true) {
      if (StripeConfig().getSecretKey.isNotEmpty) {
        Navigator.of(dialogContext).pop();
        context.read<SubscriptionViewModel>().subscribeLeagueByCard(
            context: _context,
            planId: planId,
            leagueId: leagueData.leagueId,
            leagueImg: leagueData.leagueImg,
            leagueTitle: leagueData.leagueTitle,
            price: price);
      } else {
        ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.msg);
        context.read<WalletViewModel>().setupStripeCredentials();
      }
    }
  }

  _upgradeByCard(BuildContext context, int planId, String price,
      BuildContext dialogContext) async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected == true) {
      if (StripeConfig().getSecretKey.isNotEmpty) {
        Navigator.of(dialogContext).pop();
        context.read<SubscriptionViewModel>().upgradeLeagueByCard(
            context: _context,
            planId: planId,
            leagueId: leagueData.leagueId,
            leagueImg: leagueData.leagueImg,
            leagueTitle: leagueData.leagueTitle,
            price: price);
      } else {
        ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.msg);
        context.read<WalletViewModel>().setupStripeCredentials();
      }
    }
  }

  _subscribeByCoin(BuildContext context, int planId, String price,
      BuildContext dialogContext) async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected == true) {
      if (StripeConfig().getSecretKey.isNotEmpty) {
        Navigator.of(dialogContext).pop();
        context.read<SubscriptionViewModel>().subscribeLeagueByCoin(
            context: _context,
            planId: planId,
            leagueId: leagueData.leagueId,
            leagueImg: leagueData.leagueImg,
            leagueTitle: leagueData.leagueTitle,
            price: price);
      } else {
        ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.msg);
        context.read<WalletViewModel>().setupStripeCredentials();
      }
    }
  }

  _upgradeByCoin(BuildContext context, int planId, String price,
      BuildContext dialogContext) async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected == true) {
      if (StripeConfig().getSecretKey.isNotEmpty) {
        Navigator.of(dialogContext).pop();
        context.read<SubscriptionViewModel>().upgradeLeagueByCoin(
            context: _context,
            planId: planId,
            leagueId: leagueData.leagueId,
            leagueImg: leagueData.leagueImg,
            leagueTitle: leagueData.leagueTitle,
            price: price);
      } else {
        ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.msg);
        context.read<WalletViewModel>().setupStripeCredentials();
      }
    }
  }

  void showConfirmSubscriptionDialog(
      {required PaymentType type, required int planId, required String price}) {
    ConfirmationDialog.show(
        context: _context,
        title: loc.subscribeConfirmTitle,
        body: loc.subscribeConfirmBody + "\$$price",
        negativeBtnTitle: loc.subscribeConfirmCancel,
        positiveBtnTitle: loc.subscribeConfirmSubscribe,
        onPositiveBtnPressed: (dialogContext) {
          switch (type) {
            case PaymentType.wallet:
              _subscribeByCoin(_context, planId, price, dialogContext);
              break;
            case PaymentType.card:
              _subscribeByCard(_context, planId, price, dialogContext);
              break;
          }
        });
  }

  void showUpgradeSubscriptionDialog(
      {required PaymentType type, required int planId, required String price}) {
    ConfirmationDialog.show(
        context: _context,
        title: loc.upgradeConfirmTitle,
        body: loc.upgradeConfirmBody + "\$$price",
        negativeBtnTitle: loc.upgradeConfirmCancel,
        positiveBtnTitle: loc.upgradeConfirmUpgrade,
        onPositiveBtnPressed: (dialogContext) {
          switch (type) {
            case PaymentType.wallet:
              _upgradeByCoin(_context, planId, price, dialogContext);
              break;
            case PaymentType.card:
              _upgradeByCard(_context, planId, price, dialogContext);
              break;
          }
        });
  }
}
