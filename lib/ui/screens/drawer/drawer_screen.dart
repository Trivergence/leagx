import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/service/payment_service/payment_config.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/screens/drawer/components/drawer_tile.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/gradient/gradient_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:leagx/view_models/payout_view_model.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:payments/payments.dart';
import 'package:provider/provider.dart';

import '../../../core/network/internet_info.dart';
import '../../../models/user/user.dart';
import '../../util/app_dialogs/confirmation_dialog.dart';
import '../../util/utility/image_utitlity.dart';
import '../../widgets/gradient/gradient_border_widget.dart';

// ignore: must_be_immutable
class DrawerScreen extends StatelessWidget {
  DrawerScreen({Key? key}) : super(key: key);

  String userName = '';
  String userImage = '';

  @override
  Widget build(BuildContext context) {
    getUserName();
    return Drawer(
      backgroundColor: AppColors.colorBackground,
      child: Padding(
        padding: const EdgeInsets.only(bottom:10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
              UIHelper.verticalSpaceXL,
                Center(
                  child: Column(
                    children: [
                      GradientBorderWidget(
                        onPressed: () {},
                        gradient: AppColors.orangishGradient,
                        imageUrl: userImage,
                        height: 80.0,
                        width: 80.0,
                        isCircular: true,
                        placeHolderImg: ImageUtitlity.getRandomProfileAvatar(),
                        isBorderSolid: true,
                      ),
                      UIHelper.verticalSpaceSmall,
                      TextWidget(
                        text: userName,
                        fontWeight: FontWeight.w100,
                        textSize: 18,
                      ),
                      UIHelper.verticalSpaceSmall,
                      const TextWidget(
                        text: '',
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(60.0),
                DrawerTile(
                  icon: Icons.help_outline,
                  title: loc.drawerBtnFaqs,
                  onTap: () {
                    Navigator.popAndPushNamed(context, Routes.faqs);
                  },
                ),
                DrawerTile(
                  icon: Icons.gpp_good_outlined,
                  title: loc.drawerBtnPrivacyPolicy,
                  onTap: () {
                    Navigator.popAndPushNamed(context, Routes.privacyPolicy);
                  },
                ),
                DrawerTile(
                  imageAsset: Assets.icDrawerTermsAndService,
                  title: loc.drawerBtnTermsOfServices,
                  onTap: () {
                    Navigator.popAndPushNamed(context, Routes.termsService);
                  },
                ),
                DrawerTile(
                  imageAsset: Assets.icDrawerAdmin,
                  title: loc.drawerBtnAdmin,
                  onTap: () {
                    Navigator.popAndPushNamed(context, Routes.admin);
                  },
                ),
            ],),
            GestureDetector(
              onTap: () async {
                ConfirmationDialog.show(context: context,
                 title: loc.logoutConfirmTitle,
                 positiveBtnTitle: loc.logoutConfirmYes,
                 negativeBtnTitle: loc.logoutConfirmNo,
                 body:loc.logoutConfirmBody, 
                 onPositiveBtnPressed: (_) => logout(context));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    const Icon(Icons.logout, color: AppColors.colorPink,),
                    UIHelper.horizontalSpace(26.0),
                     TextWidget(
                       text: loc.drawerBtnLogout,
                       color: AppColors.colorPink,
                     ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getUserName() {
    User? user = locator<SharedPreferenceHelper>().getUser();
    if(user != null) {
      userName = user.firstName!;
      userImage = user.profileImg!;
    }
  }

  logout(BuildContext context) async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected == true) {
      await preferenceHelper.removeAuthToken();
      await preferenceHelper.removeUser();
      context.read<DashBoardViewModel>().clearData();
      context.read<WalletViewModel>().clearData();
      context.read<PayoutViewModel>().clearData();
      locator<PaymentConfig>().setCustomerCred = null;
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.signin, (_) => false);
    }
  }
}
