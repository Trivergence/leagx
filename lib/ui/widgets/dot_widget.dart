import 'package:leagx/constants/colors.dart';
import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final double size;
  final bool isLive;
  const DotWidget({Key? key, this.size = 12.0, this.isLive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.fiber_manual_record_rounded,
      size: size,
      color: isLive ? AppColors.colorGreen : AppColors.colorGrey,
    );
  }
}
