import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/dimens.dart';
import 'package:leagx/constants/font_family.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/icon_widget.dart';

class LeagueAvatarWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;
  final double? textSize;
  final VoidCallback onPressed;
  final String? imageUrl;
  final String? imageAsset;
  final String? placeHolderImg;
  final EdgeInsetsGeometry? padding;
  final bool isSelected;
  final IconData? iconData;
  final double? iconSize;
  const LeagueAvatarWidget({
    Key? key,
    this.width,
    this.height,
    this.text,
    this.textSize,
    required this.onPressed,
    this.imageUrl,
    this.imageAsset,
    this.padding,
    this.placeHolderImg, 
    this.isSelected = false, 
    this.iconData,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Opacity(
        opacity: isSelected == true ? 1 : 0.7,
        child: Container(
          width: width ?? SizeConfig.width * 100,
          height: height ?? 48.0,
          padding: padding,
          decoration: BoxDecoration(
            color: isSelected == true ? AppColors.colorPink.withOpacity(0.2) : AppColors.colorBackground,
            shape: BoxShape.circle,
            border: Border.all(color: isSelected == true
              ? AppColors.colorPink
              : AppColors.colorWhite,
              width: 1.7)
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
                    placeholder: placeHolderImg ?? '')
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
                        : const SizedBox()
        ),
      ),
    );
  }
}
