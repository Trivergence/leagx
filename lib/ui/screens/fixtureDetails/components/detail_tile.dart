import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/text_widget.dart';

class DetailTile extends StatelessWidget {
  const DetailTile({
    Key? key,required this.title, required this.leftValue, required this.rightValue,required this.tileColor,
  }) : super(key: key);
  final String title;
  final String leftValue;
  final String rightValue;
  final Color tileColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tileColor,
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(text: leftValue, color: AppColors.colorYellow,),
          TextWidget(text: title),
          TextWidget(text: rightValue,
            color: AppColors.colorRed,
            textAlign: TextAlign.end,
          ),
      ],),
    );
  }
}