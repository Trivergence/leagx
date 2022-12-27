import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../locale/localization.dart';

class PickerUtility {
  static void showDatePicker(
      {required BuildContext context,
      required Function(Country) onCountrySelect}) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        searchTextStyle: const TextStyle(color: AppColors.colorWhite),
        flagSize: 25,
        backgroundColor: AppColors.colorBackground,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 500,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        inputDecoration: InputDecoration(
          hintText: loc.profileProfileInfoUpdatePickerSearch,
          hintStyle: TextStyle(color: AppColors.colorWhite.withOpacity(0.3)),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.colorWhite,
          ),
          fillColor: AppColors.textFieldColor,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
      onSelect: onCountrySelect,
    );
  }
}
