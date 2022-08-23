import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:bailbooks_defendant/ui/screens/drawer/components/drawer_tile.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                const TextWidget(
                  text: 'John Aly',
                  fontWeight: FontWeight.w700,
                  textSize: 18,
                ),
                UIHelper.verticalSpaceSmall,
                const TextWidget(
                  text: '@Johne39',
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(60.0),
          DrawerTile(
            icon: Icons.account_circle_outlined,
            title: 'Profile',
            onTap: () {
              Navigator.pushNamed(context, Routes.profileSettings);
            },
          ),
          DrawerTile(
            imageAsset: Assets.icDrawerPredictions,
            title: 'My Predictions',
            onTap: () {
              Navigator.pushNamed(context, Routes.predictions);
            },
          ),
          DrawerTile(
            icon: Icons.help_outline,
            title: 'FAQs',
            onTap: () {
              Navigator.pushNamed(context, Routes.faqs);
            },
          ),
          DrawerTile(
            icon: Icons.gpp_good_outlined,
            title: 'Privacy Policy',
            onTap: () {
              Navigator.pushNamed(context, Routes.privacyPolicy);
            },
          ),
          DrawerTile(
            imageAsset: Assets.icDrawerTermsAndService,
            title: 'Terms of Services',
            onTap: () {
              Navigator.pushNamed(context, Routes.termsService);
            },
          ),
          DrawerTile(
            imageAsset: Assets.icDrawerAdmin,
            title: 'Admin',
            onTap: () {
              Navigator.pushNamed(context, Routes.admin);
            },
          ),
          UIHelper.verticalSpaceXL,
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const GradientWidget(
                    child: Icon(Icons.logout),
                  ),
                  UIHelper.horizontalSpace(26.0),
                  const GradientWidget(
                    child: TextWidget(
                      text: 'Logout',
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
}
