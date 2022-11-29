import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final Gradient gradient;
  const MainButton({
    Key? key,
    this.width,
    this.height,
    required this.text,
    required this.onPressed,
    this.fontSize = Dimens.buttonTextSizeMedium,
    this.fontWeight = FontWeight.w600,
    this.gradient = AppColors.pinkishGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? SizeConfig.width * 70,
      height: height ?? 48.0,
      decoration: BoxDecoration(
          color: AppColors.colorPink,
          borderRadius: BorderRadius.circular(100)
        ),
      child: ElevatedButton(
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: AppColors.colorWhite,
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: 1
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0.0,
          padding: const EdgeInsets.symmetric(horizontal: 3)
        ),
        onPressed: onPressed,
      ),
    );
  }
}
