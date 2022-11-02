import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class FancyDialog {
  static void showSuccess({
    required BuildContext context, 
    required String title,
    required String description,
    VoidCallback? onOkPressed
    }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: title,
      desc: description,
      btnOkOnPress: onOkPressed,
    ).show();
  }
}