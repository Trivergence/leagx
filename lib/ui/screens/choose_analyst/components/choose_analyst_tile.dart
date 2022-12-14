import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';

class ConsultAnalystTile extends StatelessWidget {
  final int number;
  final String? imageUrl;
  final String title;
  final int numberOfPrediciton;
  final String successRate;
  final VoidCallback onTileTap;

  const ConsultAnalystTile({
    Key? key,
    required this.number,
    required this.imageUrl,
    required this.title,
    required this.numberOfPrediciton,
    required this.successRate,
    required this.onTileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTileTap,
      child: Container(
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
              isBorderSolid: true,
            ),
            UIHelper.horizontalSpace(15.0),
            GradientBorderWidget(
              width: 44.0,
              height: 44.0,
              isCircular: true,
              imageUrl: imageUrl,
              onPressed: () {},
              placeHolderImg: Assets.icPlayerAvatar,
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
                        text:
                            '$numberOfPrediciton ${loc.chooseAnExpertTxtPredictions}',
                        textSize: Dimens.textSmall,
                        color: AppColors.colorWhite.withOpacity(0.5),
                      ),
                      TextWidget(
                        text: loc.chooseAnExpertTxtSuccess,
                        textSize: Dimens.textSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
