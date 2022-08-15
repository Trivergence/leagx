import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/text_widget.dart';

class MatchPredictionTile extends StatelessWidget {
  const MatchPredictionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textFieldColor,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextWidget(text: "Your Predictions"),
          Column(children: const [
            TextWidget(text: "UFC - 3", color: AppColors.colorCyan,
            fontWeight: FontWeight.w600,),
            TextWidget(text: "ARS - 2",
            color: AppColors.colorYellow,
            fontWeight: FontWeight.w600),
          ],)
        ],
      ),
      );
  }
}
