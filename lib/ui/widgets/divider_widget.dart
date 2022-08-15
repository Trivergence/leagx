import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    Key? key, this.height = 1,
  }) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return Divider(
    color: AppColors.colorWhite.withOpacity(0.3),
    height: height,);
  }
}