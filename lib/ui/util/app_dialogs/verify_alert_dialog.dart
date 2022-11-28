import 'package:flutter/material.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/utility/date_utility.dart';

import '../../../constants/colors.dart';
import '../../widgets/text_widget.dart';

class VerificationAlertDialog {
  static void show(
      {required BuildContext context,
      required String title,
      required List<String> listOfRequirements,
      required String negativeBtnTitle,
      required String positiveBtnTitle,
      required ValueChanged onPositiveBtnPressed}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: TextWidget(
              text: title,
              fontWeight: FontWeight.w700,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: listOfRequirements
              .map((requirements) => Column(
                children: [
                  TextWidget(text: UIHelper.bullet + "  " + requirements),
                  TextWidget(text: "Due Data :" + DateUtility.getDateFronStamp(timeStamp: 123344).toString())
                ],
              )).toList(),
            ),
            backgroundColor: AppColors.colorBackground,
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(negativeBtnTitle),
              ),
              TextButton(
                onPressed: () => onPositiveBtnPressed(ctx),
                child: Text(positiveBtnTitle),
              ),
            ],
          );
        });
  }
}