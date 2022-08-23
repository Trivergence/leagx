import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/constants/font_family.dart';
import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:bailbooks_defendant/ui/util/size/size_config.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_border_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/settings_tile.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Profile Settings",
        trailing: IconButton(
          icon: const IconWidget(
            iconData:Icons.border_color_outlined,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.profileInfoUpdate);
          },
        ),
      ),
      body: Container(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: SizeConfig.width * 100,
                    margin:const  EdgeInsets.only(top: 40.0),
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
                          text: 'Dylan Dybala',
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
                          text: 'Coins',
                          textSize: Dimens.textSmall,
                          color: AppColors.colorWhite.withOpacity(0.6),
                        ),
                        UIHelper.verticalSpace(16.0),
                        MainButton(
                          width: 90.0,
                          height: 26.0,
                          text: 'Withraw',
                          fontSize: 14.0,
                          onPressed: () {},
                        ),
                        UIHelper.verticalSpace(22.0),
                      ],
                    ),
                  ),
                  // Center(
                  //   child: Positioned(
                  //     top: 0.0,
                  //     child: GradientBorderWidget(
                  //       onPressed: () {},
                  //       gradient: AppColors.orangishGradient,
                  //       imageUrl: "https://pravatar.cc/",
                  //       height: 80.0,
                  //       width: 80.0,
                  //       isCircular: true,
                        
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              UIHelper.verticalSpace(30.0),
              SettingsTile(
                text: 'John Smith',
                iconData: Icons.account_circle_outlined,
                onTap: (){},
              ),
              UIHelper.verticalSpace(15.0),
              SettingsTile(
                text: 'abc@xyz.com',
                iconData: Icons.drafts_outlined,
                onTap: (){},
              ),
              UIHelper.verticalSpace(15.0),
              SettingsTile(
                text: '+1234567890',
                iconData: Icons.smartphone,
                onTap: (){},
              ),
              UIHelper.verticalSpace(15.0),
              SettingsTile(
                text: 'Male',
                iconData: Icons.perm_contact_cal,
                onTap: (){},
              ),

            ],
          ),
        ),
      ),
    );
  }
}
