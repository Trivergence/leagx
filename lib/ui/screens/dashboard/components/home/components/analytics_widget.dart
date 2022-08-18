import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/util/size/size_config.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_border_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AnalyticsWidget extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  final String thirdLabel;
  final String firstValue;
  final String secondValue;
  final String thirdValue;

  const AnalyticsWidget({
    Key? key, required this.firstLabel, required this.secondLabel, required this.thirdLabel, required this.firstValue, required this.secondValue, required this.thirdValue,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.verticalPadding),
      padding: const EdgeInsets.symmetric( vertical: 20.0),
      decoration: BoxDecoration(
          gradient: AppColors.blackishGradient,
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Column(
        children: [
          const TextWidget(
            text: 'Analytics',
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
                    height: 60.0,
                    width: 60.0,
                    isCircular: true,
                  ),
                  UIHelper.verticalSpaceSmall,
                  TextWidget(
                      text: firstLabel,
                      textSize: SizeConfig.width*3.5,
                      color: AppColors.colorWhite.withOpacity(0.6)),
                ],
              ),
              Column(
                children: [
                  GradientBorderWidget(
                    onPressed: () {},
                    gradient: AppColors.pinkishGradient,
                    text: secondValue,
                    height: 60.0,
                    width: 60.0,
                    isCircular: true,
                  ),
                  UIHelper.verticalSpaceSmall,
                  TextWidget(
                      text: secondLabel,
                      textSize: SizeConfig.width*3.5,
                      color: AppColors.colorWhite.withOpacity(0.6)),
                ],
              ),
              Column(
                children: [
                  GradientBorderWidget(
                    onPressed: () {},
                    gradient: AppColors.orangishGradient,
                    text: thirdValue,
                    height: 60.0,
                    width: 60.0,
                    isCircular: true,
                  ),
                  UIHelper.verticalSpaceSmall,
                  TextWidget(
                      text: thirdLabel,
                      textSize: SizeConfig.width*3.5,
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
