import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:flutter/material.dart';

final ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  primarySwatch: MaterialColor(AppColors.blue[500]!.value, AppColors.blue),
  primaryColor: AppColors.colorPrimary,
);

final ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.colorPrimary,
);
