import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/constants/font_family.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class GradientBorderWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;
  final double? textSize;
  final VoidCallback? onPressed;
  final bool isCircular;
  final Gradient gradient;
  final IconData? iconData;
  final double? iconSize;
  final String? imageUrl;
  final String? imageAsset;
  final String? placeHolderImg;
  final EdgeInsetsGeometry? padding;
  const GradientBorderWidget({
    Key? key,
    this.width,
    this.height,
    this.text,
    this.textSize,
    this.onPressed,
    this.isCircular = false,
    this.gradient = AppColors.pinkishGradient,
    this.iconData,
    this.iconSize,
    this.imageUrl,
    this.imageAsset,
    this.padding, this.placeHolderImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? SizeConfig.width * 100,
        height: height ?? 48.0,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            gradient: gradient,
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircular
                ? null
                : const BorderRadius.all(Radius.circular(5.0))),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.colorBackground,
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: iconData != null
              ? IconWidget(
                  iconData: iconData!,
                  size: iconSize,
                )
              : imageUrl != null
                  ? ImageWidget(
                      imageUrl: imageUrl!,
                      placeholder: placeHolderImg ?? ''
                    )
                  : text != null
                      ? Center(
                          child: TextWidget(
                            text: text!,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.raleway,
                            textSize: textSize ?? Dimens.textRegular,
                          ),
                        )
                      : imageAsset != null
                          ? Image.asset(imageAsset!)
                          : const SizedBox(),
        ),
      ),
    );
  }
}
