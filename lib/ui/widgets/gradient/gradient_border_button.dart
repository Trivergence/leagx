import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/constants/font_family.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:flutter/material.dart';

class GradientBorderButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  const GradientBorderButton({
    Key? key,
    this.width,
    this.height,
    required this.text,
    required this.onPressed,
    this.fontSize = Dimens.buttonTextSizeMedium,
    this.fontWeight = FontWeight.w600,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? SizeConfig.width * 100,
      height: height ?? 48.0,
      padding: const EdgeInsets.all(2.0),
      decoration: const BoxDecoration(
          gradient: AppColors.pinkishGradient,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Container(
        color: AppColors.colorBackground,
        child: ElevatedButton(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.colorWhite,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: FontFamily.raleway,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0.0,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
