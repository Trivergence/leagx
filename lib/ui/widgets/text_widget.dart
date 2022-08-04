import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double textSize;
  final TextAlign textAlign;
  final bool isRich;
  final TextOverflow? overflow;

  const TextWidget({
    Key? key,
    required this.text,
    this.textSize = Dimens.textRegular,
    this.color = AppColors.colorWhite,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.isRich = false,
    this.overflow = TextOverflow.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isRich
        ? Flexible(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: StrutStyle(fontSize: textSize),
              text: TextSpan(
                style: TextStyle(
                  color: color,
                  fontWeight: fontWeight,
                  fontSize: textSize,
                ),
                text: text,
              ),
              textAlign: textAlign,
            ),
          )
        : Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: textSize,
              fontWeight: fontWeight
            ),
            textAlign: textAlign,
            overflow: overflow,
          );
  }
}
