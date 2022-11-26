import 'package:flutter_svg/svg.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:payments/payments.dart';
import 'package:provider/provider.dart';

import '../../../../../../constants/assets.dart';
import '../../../../../../core/network/internet_info.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../view_models/dashboard_view_model.dart';
import '../../../../../../view_models/wallet_view_model.dart';
import '../../../../../util/toast/toast.dart';
import '../../../../../widgets/main_button.dart';

class AnalyticsWidget extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  final String thirdLabel;
  final String firstValue;
  final String secondValue;
  final String thirdValue;

  const AnalyticsWidget({
    Key? key,
    required this.firstLabel,
    required this.secondLabel,
    required this.thirdLabel,
    required this.firstValue,
    required this.secondValue,
    required this.thirdValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UIHelper.verticalSpaceSmall,
        TextWidget(
          text: loc.dashboardHomeTxtAnalytics,
          fontWeight: FontWeight.bold,
          letterSpace: 4,
          textSize: Dimens.textSM,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.only(bottom: 30.0, top: 40),
          decoration: BoxDecoration(
              gradient: AppColors.blackishGradient,
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      GradientBorderWidget(
                        onPressed: () {},
                        gradient: AppColors.pinkishGradient,
                        text: firstValue,
                        height: 80.0,
                        width: 80.0,
                        isCircular: true,
                      ),
                      Positioned(
                        top: -15,
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFF67599),
                          radius: 15,
                          child: SvgPicture.asset(
                            Assets.icBullsEye, 
                            color: AppColors.colorBlack,),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceSmall,
                  TextWidget(
                      text: firstLabel,
                      textSize: 11,
                      color: AppColors.colorWhite.withOpacity(0.6),
                      fontWeight: FontWeight.bold,),
                  UIHelper.verticalSpace(5),
                  MainButton(
                    width: 80.0,
                    height: 22.0,
                    text: loc.profileProfileSettingsTxtAddPredictions,
                    fontSize: 8.0,
                    onPressed: () async {
                      bool isConnected = await InternetInfo.isConnected();
                      if (isConnected == true) {
                        Navigator.pushNamed(context, Routes.chooseLeague,
                            arguments: false);
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      GradientBorderWidget(
                        onPressed: () {},
                        gradient: AppColors.blueishTopBottomGradient,
                        text: secondValue + "%",
                        height: 80.0,
                        width: 80.0,
                        isCircular: true,
                      ),
                      Positioned(
                        top: -15,
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF71DBD4),
                          radius: 15,
                          child: SvgPicture.asset(
                            Assets.icBlackCrown,
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceSmall,
                  TextWidget(
                      text: secondLabel,
                      textSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorWhite.withOpacity(0.6)),
                ],
              ),
              Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      GradientBorderWidget(
                        onPressed: () {},
                        gradient: AppColors.orangishGradient,
                        text: thirdValue,
                        height: 80.0,
                        width: 80.0,
                        isCircular: true,
                      ),
                      Positioned(
                        top: -15,
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFFFC56E),
                          radius: 15,
                          child: SvgPicture.asset(
                            Assets.icCoin,
                            color: AppColors.colorBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceSmall,
                  TextWidget(
                      text: thirdLabel,
                      textSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorWhite.withOpacity(0.6)),
                  UIHelper.verticalSpace(5),
                  MainButton(
                    width: 80.0,
                    height: 22.0,
                    text: loc.profileProfileSettingsTxtWithdraw,
                    fontSize: 8.0,
                    onPressed: () async {
                      bool isConnected = await InternetInfo.isConnected();
                      if(isConnected == true) {
                        if (StripeConfig()
                              .getSecretKey
                              .isNotEmpty) {
                            if (context
                                  .read<DashBoardViewModel>()
                                  .isInitialized ==
                              true) {
                            Navigator.pushNamed(context, Routes.payout);
                          } else {
                            ToastMessage.show(
                                loc.msgPleaseWait, TOAST_TYPE.msg);
                          }
                            
                          } else {
                            ToastMessage.show(
                                loc.errorTryAgain, TOAST_TYPE.msg);
                            context
                                .read<WalletViewModel>()
                                .setupStripeCredentials();
                          }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
