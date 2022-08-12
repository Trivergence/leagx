import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_border_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AnalyticsWidget extends StatelessWidget {
  final double prediction;
  final double winnigRatio;
  final int earnedCoin;


  const AnalyticsWidget({Key? key,required this.prediction, required this.winnigRatio, required this.earnedCoin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.verticalPadding),
      padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 20.0),
      decoration: BoxDecoration(
        gradient: AppColors.blackishGradient,
        borderRadius:const  BorderRadius.all(Radius.circular(8.0))
      ),
      child: Column(
        children: [
          const TextWidget(
            text: 'Analytics',
            fontWeight: FontWeight.w700,
          ),
          UIHelper.verticalSpace(35.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GradientBorderWidget(
                    onPressed: () {},
                    gradient: AppColors.blueishGradient,
                    text: prediction.toString(),
                    height: 60.0,
                    width: 60.0,
                    isCircular: true,
                  ),
                  UIHelper.verticalSpaceSmall,
                   TextWidget(
                      text: 'Predictions', textSize: Dimens.textSmall,color:AppColors.colorWhite.withOpacity(0.6)),
                ],
              ),
              Column(
                children: [
                  GradientBorderWidget(
                    onPressed: () {},
                    gradient: AppColors.pinkishGradient,
                    text: '$winnigRatio%',
                    height: 60.0,
                    width: 60.0,
                    isCircular: true,
                  ),
                  UIHelper.verticalSpaceSmall,
                   TextWidget(
                      text: 'Winning Ratio', textSize: Dimens.textSmall,color:AppColors.colorWhite.withOpacity(0.6)),
                ],
              ),
              Column(
                children: [
                  GradientBorderWidget(
                    onPressed: () {},
                    gradient: AppColors.orangishGradient,
                    text: earnedCoin.toString(),
                    height: 60.0,
                    width: 60.0,
                    isCircular: true,
                  ),
                  UIHelper.verticalSpaceSmall,
                   TextWidget(
                      text: 'Coin Earned', textSize: Dimens.textSmall,color:AppColors.colorWhite.withOpacity(0.6)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
