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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.verticalPadding),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
          gradient: AppColors.blackishGradient,
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Column(
        children: [
           TextWidget(
            text: loc.dashboardHomeTxtAnalytics,
            fontWeight: FontWeight.w700,
          ),
          UIHelper.verticalSpace(35.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  GradientBorderWidget(
                    onPressed: () {},
                    gradient: AppColors.blueishGradient,
                    text: firstValue,
                    height: 80.0,
                    width: 80.0,
                    isCircular: true,
                    textWithIcon: true,
                    imageAsset: Assets.icBullsEye,
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
                  GradientBorderWidget(
                    onPressed: () {},
                    gradient: AppColors.pinkishGradient,
                    text: secondValue,
                    height: 80.0,
                    width: 80.0,
                    isCircular: true,
                    imageAsset: Assets.icYellowCrown,
                    textWithIcon: true,
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
                  GradientBorderWidget(
                    onPressed: () {},
                    gradient: AppColors.orangishGradient,
                    text: thirdValue,
                    height: 80.0,
                    width: 80.0,
                    isCircular: true,
                    imageAsset: Assets.icCoin,
                    textWithIcon: true,
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
        ],
      ),
    );
  }
}
