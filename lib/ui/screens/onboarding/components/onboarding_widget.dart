import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class OnBoardingWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  const OnBoardingWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imageAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Image.asset(
            imageAsset,
            fit: BoxFit.cover,
            width: SizeConfig.width * 100,
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 30.0),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.colorBackground,
                blurRadius: 35.0,
                spreadRadius: 35.0,
                offset: Offset(
                  -20,
                  0,
                ),
              ),
            ],
          ),
          child: Column(
            children: [
              TextWidget(
                text: title,
                textSize: Dimens.textLarge,
                fontWeight: FontWeight.w700,
              ),
              UIHelper.verticalSpaceMedium,
              TextWidget(
                text: subtitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
