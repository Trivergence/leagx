import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  const ShimmerWidget({
    Key? key,
    required this.height, 
    this.horizontalPadding = 8.0, 
    this.verticalPadding = 8.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      child: Shimmer.fromColors(
          period: const Duration(milliseconds: 500),
          child: Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: AppColors.blackishGradient,
                borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          ),
          baseColor: AppColors.colorDarkGrey,
          highlightColor: AppColors.textFieldColor),
    );
  }
}
