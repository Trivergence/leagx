import 'package:flutter/cupertino.dart';
import 'package:leagx/constants/strings.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  SharedPreferences preferences;
  late Locale _locale;
  LocalizationProvider({required this.preferences});

  Locale get getLocale => _locale;

  init() async {
    if (ValidationUtils.isValid(
        SharedPreferenceHelper(preferences).currentLanguage)) {
      _locale = Locale(
        SharedPreferenceHelper(preferences).currentLanguage!,
      );
    } else {
      _locale = const Locale(
        Strings.english,
      );
    }
  }

  Locale get locale => _locale;

  void changeLanguage(String value) {
    SharedPreferenceHelper(preferences).changeLanguage(value);
    _locale = Locale(value);
    notifyListeners();
  }
}
