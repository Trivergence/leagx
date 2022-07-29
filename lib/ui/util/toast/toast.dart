import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum TOAST_TYPE { success, error, msg }

class ToastMessage {
  static void show(
    String text,
    dynamic type, {
    dynamic toastLength = Toast.LENGTH_LONG,
  }) {
    Color color = AppColors.colorPrimary;
    if (type == TOAST_TYPE.success) {
      color = Colors.green;
    }

    if (type == TOAST_TYPE.error) {
      color = Colors.red;
    }

    Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
