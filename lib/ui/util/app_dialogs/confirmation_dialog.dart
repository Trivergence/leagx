import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../widgets/text_widget.dart';

class ConfirmationDialog {
  static void show(
      {required BuildContext context,
      required String title,
      required String body,
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
            content: TextWidget(text: body),
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
