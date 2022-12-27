import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/font_family.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme(String fontFamily) {
    return ThemeData(
        brightness: Brightness.light,
        primarySwatch:
            MaterialColor(AppColors.blue[500]!.value, AppColors.blue),
        primaryColor: AppColors.colorBackground,
        fontFamily: fontFamily,
        unselectedWidgetColor: AppColors.colorWhite,
        scaffoldBackgroundColor: AppColors.colorBackground,
        appBarTheme: const AppBarTheme(color: AppColors.colorBackground),
        iconTheme: const IconThemeData(
          color: AppColors.colorWhite,
        ));
  }
}

final ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.colorBackground,
  fontFamily: FontFamily.gilroy,
);
