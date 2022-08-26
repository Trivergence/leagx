import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_border_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';

class ChooseAnExpertTile extends StatelessWidget {
  final int number;
  final String imageUrl;
  final String title;
  final int numberOfPrediciton;
  final String successRate;

  const ChooseAnExpertTile(
      {Key? key,
      required this.number,
      required this.imageUrl,
      required this.title,
      required this.numberOfPrediciton,
      required this.successRate,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24.0),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        gradient: AppColors.blackishGradient,
      ),
      child: Row(
        children: [
          GradientBorderWidget(
            width: 20.0,
            height: 20.0,
            isCircular: true,
            gradient: AppColors.grayishGradient,
            text: number.toString(),
            textSize: 12.0,
            onPressed: () {},
          ),
          UIHelper.horizontalSpace(15.0),
          GradientBorderWidget(
            width: 44.0,
            height: 44.0,
            isCircular: true,
            imageUrl: imageUrl,
            onPressed: () {},
            gradient: AppColors.orangishGradient,
          ),
          UIHelper.horizontalSpace(15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    TextWidget(text: title),
                    TextWidget(
                      text: '$successRate%',
                      color: AppColors.colorGreen,
                      textSize: Dimens.textXM,
                    ),
                  ],
                ),
                UIHelper.verticalSpace(5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: '$numberOfPrediciton predictions',
                      textSize: Dimens.textSmall,
                      color: AppColors.colorWhite.withOpacity(0.5),
                    ),
                    const TextWidget(
                      text: 'Success',
                      textSize: Dimens.textSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
