import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/screens/drawer/components/drawer_tile.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/gradient/gradient_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../models/user/user.dart';
import '../../util/app_dialogs/confirmation_dialog.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userName = getUserName();
    return Drawer(
      backgroundColor: AppColors.colorBackground,
      child: ListView(
        children: [
          UIHelper.verticalSpaceXL,
          Center(
            child: Column(
              children: [
                Container(
                  height: 85.0,
                  width: 85.0,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(Assets.appLogo),
                ),
                UIHelper.verticalSpaceSmall,
                TextWidget(
                  text: userName,
                  fontWeight: FontWeight.w700,
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
            icon: Icons.account_circle_outlined,
            title: loc.drawerBtnProfile,
            onTap: () => Navigator.popAndPushNamed(context, Routes.profileSettings),
          ),
          DrawerTile(
            imageAsset: Assets.icDrawerPredictions,
            title: loc.drawerBtnMyPredictions,
            onTap: () {
              Navigator.pushNamed(context, Routes.predictions);
            },
          ),
          DrawerTile(
            icon: Icons.help_outline,
            title: loc.drawerBtnFaqs,
            onTap: () {
              Navigator.pushNamed(context, Routes.faqs);
            },
          ),
          DrawerTile(
            icon: Icons.gpp_good_outlined,
            title: loc.drawerBtnPrivacyPolicy,
            onTap: () {
              Navigator.pushNamed(context, Routes.privacyPolicy);
            },
          ),
          DrawerTile(
            imageAsset: Assets.icDrawerTermsAndService,
            title: loc.drawerBtnTermsOfServices,
            onTap: () {
              Navigator.pushNamed(context, Routes.termsService);
            },
          ),
          DrawerTile(
            imageAsset: Assets.icDrawerAdmin,
            title: loc.drawerBtnAdmin,
            onTap: () {
              Navigator.pushNamed(context, Routes.admin);
            },
          ),
          UIHelper.verticalSpaceXL,
          GestureDetector(
            onTap: () async{
              ConfirmationDialog.show(context: context,
               title: loc.logoutConfirmTitle,
               positiveBtnTitle: loc.logoutConfirmYes,
               negativeBtnTitle: loc.logoutConfirmNo,
               body:loc.logoutConfirmBody, 
               onPositiveBtnPressed: () => logout(context));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const GradientWidget(
                    child: Icon(Icons.logout),
                  ),
                  UIHelper.horizontalSpace(26.0),
                   GradientWidget(
                    child: TextWidget(
                      text: loc.drawerBtnLogout,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getUserName() {
    User? user = locator<SharedPreferenceHelper>().getUser();
    if(user != null) {
      return user.firstName! + user.lastName!;
    } else {
      return "";
    }
  }

  logout(BuildContext context) async {
    await preferenceHelper.removeAuthToken();
    await preferenceHelper.removeUser();
    context.read<DashBoardViewModel>().clearData();
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.signin, (route) => false);
  }
}
