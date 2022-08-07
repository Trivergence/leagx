import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:flutter/material.dart';
class IconWidget extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final double? size;
  const IconWidget({Key? key,required this.iconData, this.color=AppColors.colorWhite,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: color,
      size: size,
    );
  }
}
