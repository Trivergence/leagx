import 'package:flutter_svg/svg.dart';
import 'package:leagx/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/utility/image_utitlity.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/dimens.dart';
import '../../../../../widgets/gradient/gradient_border_widget.dart';
import '../../../../../widgets/text_widget.dart';

class ExpandedLeaderTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int numberOfPrediciton;
  final String successRate;
  const ExpandedLeaderTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.numberOfPrediciton,
    required this.successRate,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: AppColors.blackishGradient,
      ),
      child: Center(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    top: -10,
                    child: SvgPicture.asset(
                      Assets.icBlackCrown,
                      color: AppColors.colorPink,
                    )
                  ),
                GradientBorderWidget(
                  width: 60.0,
                  height: 60.0,
                  isCircular: true,
                  imageUrl: imageUrl,
                  onPressed: () {},
                  placeHolderImg: ImageUtitlity.getRandomProfileAvatar(),
                  gradient: AppColors.orangishGradient,
                  isBorderSolid: true,
                ),
              ],
            ),
            UIHelper.verticalSpace(4),
            TextWidget(
              text: title,
              fontWeight: FontWeight.w500,
            ),
            TextWidget(
              text: "$numberOfPrediciton ${loc.dashboardLeaderTxtPredictions}",
              textSize: Dimens.textXS,
              color: AppColors.colorWhite.withOpacity(0.5),
              fontWeight: FontWeight.w400,
            ),
            TextWidget(
                text: "${loc.dashboardLeaderTxtWin} $successRate%",
                color: AppColors.colorGreen,
                fontWeight: FontWeight.w400,
                textSize: Dimens.textXS),
          ],
        ),
      ),
    );
  }
}
