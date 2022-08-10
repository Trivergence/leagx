import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final Color color;
  final double size;
  const DotWidget({Key? key, this.color = AppColors.colorGreen,this.size=30.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextWidget(
      text: '•',
      color: color,
      textSize: size,
    );
  }
}
