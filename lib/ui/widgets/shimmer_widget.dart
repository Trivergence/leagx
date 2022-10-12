import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  const ShimmerWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
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
