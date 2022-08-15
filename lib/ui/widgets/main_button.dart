import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/constants/font_family.dart';
import 'package:bailbooks_defendant/ui/util/size/size_config.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  const MainButton({
    Key? key,
    this.width,
    this.height,
    required this.text,
    required this.onPressed, this.fontSize = Dimens.buttonTextSizeMedium, this.fontWeight = FontWeight.w600,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?? SizeConfig.width * 100,
      height: height ?? 48.0,
      decoration: const BoxDecoration(
          gradient: AppColors.pinkishGradient,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: ElevatedButton(
        child: Text(
          text,
          style:  TextStyle(
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
    );
  }
}
