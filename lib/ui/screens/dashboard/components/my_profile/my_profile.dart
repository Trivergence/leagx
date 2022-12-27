import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/my_profile_tile.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/sharedpref/shared_preference_helper.dart';
import '../../../../../models/update_profile_args.dart';
import '../../../../../models/user/user.dart';
import '../../../../../models/user_summary.dart';
import '../../../../../service/service_locator.dart';
import '../../../../../view_models/dashboard_view_model.dart';
import '../../../../util/utility/image_utitlity.dart';
import '../../../../widgets/gradient/gradient_border_widget.dart';
import 'components/analytics_widget.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool _switchValue = false;
  UserSummary? _userSummary;

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
    _userSummary = context.select<DashBoardViewModel, UserSummary?>(
        (dasboardModel) => dasboardModel.userSummary);
    getUserData();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelper.verticalSpace(10.0),
          Center(
            child: GradientBorderWidget(
              onPressed: () {},
              gradient: AppColors.orangishGradient,
              imageUrl: imagUrl,
              height: 80.0,
              width: 80.0,
              isCircular: true,
              placeHolderImg: ImageUtitlity.getRandomProfileAvatar(),
              isBorderSolid: true,
            ),
          ),
          if (_userSummary != null)
            AnalyticsWidget(
              firstLabel: loc.myProfileTxtPredictions,
              firstValue: _userSummary!.remainingPredictions.toString(),
              secondLabel: loc.myProfileTxtWiningRatio(
                  _userSummary!.totalPredictions.toString()),
              secondValue:
                  _userSummary!.predictionSuccessRate.toString() != "100.0"
                      ? _userSummary!.predictionSuccessRate!.toStringAsFixed(1)
                      : _userSummary!.predictionSuccessRate!.toStringAsFixed(0),
              thirdLabel: loc.myProfileTxtEarnedCoid,
              thirdValue: _userSummary!.coinEarned!.round().toString(),
            ),
          UIHelper.verticalSpace(15.0),
          MyProfileTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.predictions);
            },
            text: loc.myProfileTxtMyPredictions,
            imageAsset: Assets.icDrawerPredictions,
          ),
          UIHelper.verticalSpace(15.0),
          TextWidget(
            text: loc.myProfileTxtProfileInfo,
            textSize: 14.0,
            color: AppColors.colorGrey,
            fontWeight: FontWeight.w500,
          ),
          UIHelper.verticalSpace(15.0),
          MyProfileTile(
            text: userName,
            iconData: Icons.account_circle_outlined,
            onTap: _goToProfileInfoUpdate,
          ),
          UIHelper.verticalSpace(15.0),
          MyProfileTile(
            text: userEmail,
            iconData: Icons.drafts_outlined,
            onTap: _goToProfileInfoUpdate,
          ),
          UIHelper.verticalSpace(15.0),
          if (phone.isNotEmpty)
            MyProfileTile(
              text: "+" + phone,
              iconData: Icons.smartphone,
              onTap: _goToProfileInfoUpdate,
            ),
          UIHelper.verticalSpace(15.0),
          if (gender.isNotEmpty)
            MyProfileTile(
              text: genders[gender]!,
              iconData: Icons.perm_contact_cal,
              onTap: _goToProfileInfoUpdate,
            ),
          UIHelper.verticalSpace(10.0),
          TextWidget(
            text: loc.myProfileTxtGeneral,
            textSize: 14.0,
            color: AppColors.colorGrey,
            fontWeight: FontWeight.w500,
          ),
          UIHelper.verticalSpace(15.0),
          MyProfileTile(
            onTap: () {},
            text: loc.myProfileTxtNotification,
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
          MyProfileTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.resetPassword);
            },
            text: loc.myProfileTxtPassword,
            iconData: Icons.lock_outline,
          ),
          UIHelper.verticalSpace(15.0),
          MyProfileTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.chooseLanguage);
            },
            text: loc.myProfileTxtLanguage,
            iconData: Icons.language,
          ),
          UIHelper.verticalSpace(15.0),
          // SettingsTile(
          //   onTap: () {
          //     Navigator.pushNamed(context, Routes.admin);
          //   },
          //   text: loc.myProfileTxtAdmin,
          //   imageAsset: Assets.icDrawerAdmin,
          // ),
          // UIHelper.verticalSpace(15.0),
        ],
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

  void _goToProfileInfoUpdate() {
    Navigator.pushNamed(context, Routes.profileInfoUpdate,
            arguments: UpdateProfileArgs(
                imgUrl: imagUrl,
                userName: userName,
                userEmail: userEmail,
                phone: phone,
                gender: gender))
        .then((_) {
      setState(() {});
    });
  }
}
