import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'text_widget.dart';

class PlaceHolderTile extends StatelessWidget {
  final double height;
  final String msgText;
  const PlaceHolderTile({
    Key? key,
    required this.height,
    required this.msgText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          gradient: AppColors.blackishGradient,
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Center(
          child: TextWidget(
        text: msgText,
      )),
    );
  }
}
