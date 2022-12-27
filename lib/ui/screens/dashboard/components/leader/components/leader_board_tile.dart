import 'package:leagx/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/utility/image_utitlity.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';

class LeaderBoardTile extends StatelessWidget {
  final int number;
  final String imageUrl;
  final String title;
  final int numberOfPrediciton;
  final String successRate;

  const LeaderBoardTile({
    Key? key,
    required this.number,
    required this.imageUrl,
    required this.title,
    required this.numberOfPrediciton,
    required this.successRate,
  }) : super(key: key);

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
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.colorPink, width: 2),
                shape: BoxShape.circle),
            child: Center(
              child: TextWidget(
                text: number.toString(),
                textSize: Dimens.textXS,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // GradientBorderWidget(
          //   width: 25.0,
          //   height: 25.0,
          //   isCircular: true,
          //   gradient: AppColors.grayishGradient,
          //   text: widget.number.toString(),
          //   textSize: 12.0,
          //   onPressed: () {},
          //   isBorderSolid: true,
          // ),
          UIHelper.horizontalSpace(15.0),
          GradientBorderWidget(
            width: 44.0,
            height: 44.0,
            isCircular: true,
            imageUrl: imageUrl,
            placeHolderImg: ImageUtitlity.getRandomProfileAvatar(),
            onPressed: () {},
            gradient: AppColors.orangishGradient,
            isBorderSolid: true,
          ),
          UIHelper.horizontalSpace(15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: title,
                      fontWeight: FontWeight.w500,
                    ),
                    TextWidget(
                        text: '$successRate%',
                        color: AppColors.colorGreen,
                        textSize: Dimens.textXM,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                UIHelper.verticalSpace(5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                        text:
                            '$numberOfPrediciton ${loc.dashboardLeaderTxtPredictions}',
                        textSize: Dimens.textXS,
                        color: AppColors.colorWhite.withOpacity(0.5),
                        fontWeight: FontWeight.w400),
                    TextWidget(
                        text: loc.dashboardLeaderTxtSuccess,
                        textSize: Dimens.textXS,
                        fontWeight: FontWeight.w400),
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
