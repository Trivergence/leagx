import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final IconData? iconData;
  final String? imageAsset;
  final Color color;
  final double? size;
  const IconWidget(
      {Key? key,
      this.iconData,
      this.color = AppColors.colorWhite,
      this.size,
      this.imageAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return iconData != null
        ? Icon(
            iconData,
            color: color,
            size: size,
          )
        : imageAsset != null
            ? Image.asset(
                imageAsset!,
                color: color,
              )
            : const SizedBox();
  }
}
