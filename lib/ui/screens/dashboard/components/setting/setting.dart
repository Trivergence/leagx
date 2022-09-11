
import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/strings.dart';
import 'package:leagx/providers/localization_provider.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/settings_tile.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              Navigator.pushNamed(context, Routes.profileSettings);
            },
            text: loc.settingTxtProfile,
            iconData: Icons.account_circle_outlined,
          ),
          UIHelper.verticalSpace(15.0),
           TextWidget(
            text: loc.settingTxtGeneral,
            textSize: 14.0,
            color: AppColors.colorGrey,
          ),
          UIHelper.verticalSpace(15.0),
          SettingsTile(
            onTap: () {},
            text: loc.settingTxtNotification,
            imageAsset: Assets.icNotification,
            trailing: Switch(
              value: _switchValue,
              activeThumbImage: const AssetImage(
                Assets.icSwitch,
              ),
              inactiveThumbImage: const AssetImage(
                Assets.icSwitch,
              ),
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
            text: loc.settingTxtPassword,
            iconData: Icons.lock_outline,
          ),
          UIHelper.verticalSpace(15.0),
          SettingsTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.chooseLanguage);
            },
            text: loc.settingTxtLanguage,
            iconData: Icons.language,
          ),
          UIHelper.verticalSpace(15.0),
          SettingsTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.admin);
            },
            text: loc.settingTxtAdmin,
            imageAsset: Assets.icDrawerAdmin,
          ),
        ],
      ),
    );
  }
}
