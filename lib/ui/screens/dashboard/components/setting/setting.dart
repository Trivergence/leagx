import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/settings_tile.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelper.verticalSpace(30.0),
          SettingsTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.profileInfoUpdate);
            },
            text: 'Profile',
            iconData: Icons.account_circle_outlined,
          ),
          UIHelper.verticalSpace(15.0),
          const TextWidget(
            text: 'GENERAL',
            textSize: 14.0,
            color: AppColors.colorGrey,
          ),
          UIHelper.verticalSpace(15.0),
          SettingsTile(
            onTap: () {},
            text: 'Notification',
            imageAsset: Assets.icNotification,
            trailing: Switch(
              value: _switchValue,
              activeThumbImage: AssetImage(Assets.icSwitch,),
              inactiveThumbImage: AssetImage(Assets.icSwitch,),
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
          ),
          UIHelper.verticalSpace(15.0),
          SettingsTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.resetPassword);
            },
            text: 'Password',
            iconData: Icons.lock_outline,
          ),
          UIHelper.verticalSpace(15.0),
          SettingsTile(
            onTap: () {},
            text: 'Language',
            iconData: Icons.language,
          ),
          UIHelper.verticalSpace(15.0),
          SettingsTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.admin);
            },
            text: 'Admin',
            imageAsset: Assets.icDrawerAdmin,
          ),
        ],
      ),
    );
  }
}
