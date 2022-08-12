import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final Color color;
  final double size;
  const DotWidget({Key? key, this.color = AppColors.colorGreen,this.size=12.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.fiber_manual_record_rounded,size: size,color: color, );
  }
}
