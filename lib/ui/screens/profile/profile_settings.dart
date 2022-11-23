import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/font_family.dart';
import 'package:leagx/core/network/internet_info.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/utility/image_utitlity.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_widget.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/settings_tile.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:payments/payments.dart';
import 'package:provider/provider.dart';

import '../../../models/update_profile_args.dart';
import '../../../models/user/user.dart';
import '../../../view_models/wallet_view_model.dart';
import '../../util/toast/toast.dart';
import 'components/profile_detail_widget.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  late String userName;

  late String imagUrl;

  late String userEmail;

  late String phone;

  late String gender;
  late Map<String, String> genders;

  @override
  void initState() {
    genders = {
      "male": loc.profileProfileInfoMale,
      "female": loc.profileProfileInfoFemale,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserSummary? userSummary = context.read<DashBoardViewModel>().userSummary;
    getUserData();
    return Scaffold(
      appBar: AppBarWidget(
        title: loc.profileProfileSettingsTxtProfileSettings,
        trailing: [IconButton(
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
        )],
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
                        ),
                        UIHelper.verticalSpace(
                          35.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProfileDetailWidget(
                              assetIcon: Assets.icCoin,
                              value: userSummary != null ? userSummary.coinEarned!.round().toString() : "0",
                              title: loc.profileProfileSettingsTxtCoins,
                              buttonTitle: loc.profileProfileSettingsTxtWithdraw,
                              onBtnPressed: () async {
                                bool isConnected = await InternetInfo.isConnected();
                                if(isConnected == true) {
                                  if (StripeConfig()
                                        .getSecretKey
                                        .isNotEmpty) {
                                      Navigator.popAndPushNamed(
                                          context, Routes.wallet);
                                    } else {
                                      ToastMessage.show(
                                          loc.errorTryAgain, TOAST_TYPE.msg);
                                      context
                                          .read<WalletViewModel>()
                                          .setupStripeCredentials();
                                    }
                                }
                              } 
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              height: 100,
                              width: 0.3,
                              color: AppColors.colorGrey,
                            ),
                            ProfileDetailWidget(
                              assetIcon: Assets.icBullsEye,
                              value: userSummary != null ? userSummary.remainingPredictions!.toString() : "0",
                              title: loc.profileProfileSettingsTxtPrediction,
                              buttonTitle: loc.profileProfileSettingsTxtAddPredictions,
                              onBtnPressed: () async {
                                bool isConnected = await InternetInfo.isConnected();
                                if(isConnected == true) {
                                  Navigator.pushNamed(context, Routes.chooseLeague, arguments: false);
                                }
                              },
                            ),
                          ],
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
                      placeHolderImg: ImageUtitlity.getRandomProfileAvatar(),
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
                text: genders[gender]!,
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