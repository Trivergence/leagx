import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/text_widget.dart';

class ScoreChip extends StatelessWidget {
  const ScoreChip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    child: Container(height: 25,
    width: 80,
    color: AppColors.colorDarkGrey,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
      TextWidget(text: "1", fontWeight: FontWeight.w600,),
      TextWidget(text: "-", fontWeight: FontWeight.w600),
      TextWidget(text: "4", fontWeight: FontWeight.w600)
    ],),
    ));
  }
}