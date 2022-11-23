import 'package:flutter_svg/svg.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants/assets.dart';

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
          fontWeight: FontWeight.w700,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.only(bottom: 30.0, top: 40),
          decoration: BoxDecoration(
              gradient: AppColors.blackishGradient,
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      textSize: SizeConfig.width * 3.5,
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
                        gradient: AppColors.blueishTopBottomGradient,
                        text: secondValue,
                        height: 80.0,
                        width: 80.0,
                        isCircular: true,
                      ),
                      Positioned(
                        top: -15,
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFA7E6D7),
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
                      textSize: SizeConfig.width * 3.5,
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
                      textSize: SizeConfig.width * 3.5,
                      color: AppColors.colorWhite.withOpacity(0.6)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
