import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/constants/font_family.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/utility/string_utility.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_widget.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/settings_tile.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/update_profile_args.dart';
import '../../../models/user/user.dart';

class ProfileSettingsScreen extends StatefulWidget {
  ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  late String userName;

  late String imagUrl;

  late String userEmail;

  late String phone;

  late String gender;

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Scaffold(
      appBar: AppBarWidget(
        title: loc.profileProfileSettingsTxtProfileSettings,
        trailing: IconButton(
          icon: const IconWidget(
            iconData: Icons.border_color_outlined,
          ),
          onPressed: () async {
            Navigator.pushNamed(context, Routes.profileInfoUpdate,
            arguments: UpdateProfileArgs(imgUrl: imagUrl,
            userName: userName, 
            userEmail: userEmail,
            phone: phone, 
            gender: gender)).then((_) {
              setState(() {
              });
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: SizeConfig.width * 100,
          height: SizeConfig.height * 100,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(
                  Assets.homeBackground,
                ),
                fit: BoxFit.fill),
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            gradient: AppColors.blackishGradient,
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: SizeConfig.width * 100,
                    margin: const EdgeInsets.only(top: 40.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      gradient: AppColors.blackishGradient,
                    ),
                    child: Column(
                      children: [
                        UIHelper.verticalSpace(50.0),
                        TextWidget(
                          text: userName,
                          fontWeight: FontWeight.w600,
                          textSize: 18.0,
                          fontFamily: FontFamily.raleway,
                        ),
                        UIHelper.verticalSpace(
                          35.0,
                        ),
                        GradientBorderWidget(
                          onPressed: () {},
                          gradient: AppColors.pinkishGradient,
                          text: '930',
                          height: 60.0,
                          width: 60.0,
                          isCircular: true,
                        ),
                        UIHelper.verticalSpaceSmall,
                        TextWidget(
                          text: loc.profileProfileSettingsTxtCoins,
                          textSize: Dimens.textSmall,
                          color: AppColors.colorWhite.withOpacity(0.6),
                        ),
                        UIHelper.verticalSpace(16.0),
                        MainButton(
                          width: 110.0,
                          height: 26.0,
                          text: loc.profileProfileSettingsTxtWithdraw,
                          fontSize: 14.0,
                          onPressed: () {},
                        ),
                        UIHelper.verticalSpace(22.0),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    child: GradientBorderWidget(
                      onPressed: () {},
                      gradient: AppColors.orangishGradient,
                      imageUrl: imagUrl,
                      height: 80.0,
                      width: 80.0,
                      isCircular: true,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(30.0),
              SettingsTile(
                text: userName,
                iconData: Icons.account_circle_outlined,
                onTap: () {},
              ),
              UIHelper.verticalSpace(15.0),
              SettingsTile(
                text: userEmail,
                iconData: Icons.drafts_outlined,
                onTap: () {},
              ),
              UIHelper.verticalSpace(15.0),
              if(phone.isNotEmpty) SettingsTile(
                text: phone,
                iconData: Icons.smartphone,
                onTap: () {},
              ),
              UIHelper.verticalSpace(15.0),
              if(gender.isNotEmpty) SettingsTile(
                text: StringUtility.capitalizeFirstLetter(gender),
                iconData: Icons.perm_contact_cal,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getUserData() {
    User? user = locator<SharedPreferenceHelper>().getUser();
    userName = user!.firstName!;
    imagUrl = user.profileImg!;
    userEmail = user.email;
    phone = user.phone ?? '';
    gender = user.gender ?? '';
  }
}
