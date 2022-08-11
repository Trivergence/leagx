import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/gradient_border_button.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_widget.dart';
import 'check_box_widget.dart';
import 'score_picker.dart';

class PredictionSheetWidget extends StatefulWidget {
  const PredictionSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PredictionSheetWidget> createState() => _PredictionSheetWidgetState();
}

class _PredictionSheetWidgetState extends State<PredictionSheetWidget> {
  bool firstSelected = false;
  bool secondSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0,right: 30.0,bottom: 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 26, top: 22),
            width: 30,
            height: 3, 
            color: AppColors.colorWhite.withOpacity(0.4),),
          const GradientWidget(child: TextWidget(text: "Predict Match Result",),),
          UIHelper.verticalSpace(34),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
            const TextWidget(text: "Chelsea", fontWeight: FontWeight.w600,),
            ScorePicker(
              initialScore: 1,
              isSelected: firstSelected,
              onChanged: (score) {
                setState(() {
                  secondSelected = false;
                  firstSelected = true;
                });
            },)
          ],),
          UIHelper.verticalSpace(22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const TextWidget(text: "Leicester C", fontWeight: FontWeight.w600,),
            ScorePicker(
              initialScore: 2,
              isSelected: secondSelected,
              onChanged: (score) {
                setState(() {
                  secondSelected = true;
                  firstSelected = false;
                });
              print(score);
            },)
          ],),
          UIHelper.verticalSpace(48),
          Row(
            children: [
            CheckBoxWidget(onPressed: (value) {
              print(value);
            },),
            UIHelper.horizontalSpace(13),
            const TextWidget(text: "Make my prediction public")
          ],),
          UIHelper.verticalSpace(30),
          MainButton(text: "SUBMIT", onPressed: (){}),
          UIHelper.verticalSpace(20),
          GradientBorderButton(text: "Expert Advise", onPressed: (){})
        ],
        
      ),
    );
  }
}



