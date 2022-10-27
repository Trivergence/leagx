import 'package:leagx/models/choose_plan_args.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/subscription_viewmodel.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:payments/payments.dart';
import 'package:provider/provider.dart';

import '../../../constants/assets.dart';
import '../../../core/network/internet_info.dart';
import '../../util/app_dialogs/confirmation_dialog.dart';
import '../../widgets/bar/app_bar_widget.dart';
import 'components/plan_listing.dart';

class ChoosePlanScreen extends StatelessWidget {
  final ChoosePlanArgs leagueData;
  const ChoosePlanScreen({Key? key, required this.leagueData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: loc.choosePlanTxtChooseAPlan),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              ImageWidget(
                imageUrl: leagueData.leagueImg,
                placeholder: Assets.icPlayerAvatar
                ),
              UIHelper.verticalSpace(8),
              TextWidget(text: leagueData.leagueTitle),
              UIHelper.verticalSpace(70),
              PlanListing(
                isAdmin: true,
                onItemPressed: (planId, price) {
                  ConfirmationDialog.show(context: context,
                   title: loc.subscribeConfirmTitle, 
                   body: loc.subscribeConfirmBody + "\$$price",
                   negativeBtnTitle: loc.subscribeConfirmCancel, 
                   positiveBtnTitle: loc.subscribeConfirmSubscribe, 
                   onPositiveBtnPressed: (dialogContext) => _subscribe(context,planId, price, dialogContext));
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _subscribe(BuildContext context, int planId, String price, BuildContext dialogContext) async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected) {
      if (StripeConfig().getSecretKey.isNotEmpty) {
          Navigator.of(dialogContext).pop();
          context.read<SubscriptionViewModel>().subscribeLeague(
          context: context,
          planId: planId,
          leagueId: leagueData.leagueId,
          leagueImg: leagueData.leagueImg,
          leagueTitle: leagueData.leagueTitle,
          price: price
        );
      } else {
        ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.msg);
        context.read<WalletViewModel>().setupStripeCredentials();
      }
    }
  }
}
