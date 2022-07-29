import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double? textSize;

  const ButtonWidget({
    Key? key,
    required this.buttonText,
    this.buttonColor = AppColors.colorPrimary,
    this.textColor = Colors.white,
    required this.onPressed,
    this.width = Dimens.buttonWidth,
    this.height = Dimens.buttonHeight,
    this.textSize = Dimens.textSmall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          primary: Colors.white,
          backgroundColor: buttonColor,
          onSurface: Colors.grey,
        ),
        onPressed: onPressed,
        child: TextWidget(
          text: buttonText,
          color: textColor,
        ),
      ),
    );
  }
}
