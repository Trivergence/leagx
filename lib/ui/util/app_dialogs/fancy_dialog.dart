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

  static void showInfo(
      {required BuildContext context,
      required String title,
      String? description,
      required String okTitle,
      required String cancelTitle,
      required VoidCallback onOkPressed}) {
    AwesomeDialog(
      context: context,
      animType: AnimType.rightSlide,
      title: title,
      desc: description,
      btnOkOnPress: onOkPressed,
      btnOkText: okTitle,
      btnCancelText: cancelTitle,
      btnCancelOnPress: () {},
    ).show();
  }
}