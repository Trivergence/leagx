import 'dart:io';
import 'dart:ui';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:leagx/constants/font_family.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/providers/localization_provider.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/strings.dart';
import '../ui/util/locale/localization.dart';

class Utility{
  static bool isMatchOver(String status) {
      if (status == "Finished" ||
          status == "After ET" ||
          status == "After Pen." ||
          status == "Postponed" ||
          status == "Delayed" ||
          status == "Cancelled" ||
          status == "Awarded"
          ) {
        return true;
      } else {
        return false;
      }
  }

  static bool isTimeValid(String matchStatus) {
    if(matchStatus == "Half Time") {
      return false;
    } else if(matchStatus.contains("+")) {
      return false;
    } else if (matchStatus.isEmpty) {
      return false;
    }
    return true;
  }

  String getCurrency() {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    return format.currencySymbol;
  }

  static String? getCountryCode() {
    final Locale? deviceLocale = CountryCodes.getDeviceLocale();
    return deviceLocale!.countryCode;
  }

   static Future<String> getTzName() async {
    String timeZone;
    try {
      timeZone =
              await FlutterNativeTimezone.getLocalTimezone();
    } on Exception catch (_) {
      timeZone = "Asia/Riyadh";
    }
    return timeZone;
  }

    static Future<void> openUrl({required String url}) async {
    Uri? parsedUrl = Uri.tryParse(url);
    if (parsedUrl != null) {
      try {
        if (!await launchUrl(
          parsedUrl,
          mode: LaunchMode.inAppWebView,
        )) {
          ToastMessage.show(
              loc.errorInvalidUrl, TOAST_TYPE.error);
        }
      } on PlatformException catch (_) {
      } catch (_) {
        ToastMessage.show(
              loc.errorInvalidUrl, TOAST_TYPE.error);
      }
    } else {
      ToastMessage.show(
              loc.errorInvalidUrl, TOAST_TYPE.error);
    }
  }

  static bool isArabic() {
    String? currentLanguage = preferenceHelper.currentLanguage;
    if (currentLanguage == "en") {
      return false;
    }
    return true;
  }
  static String getFont(LocalizationProvider localizationProvider) {
    if(localizationProvider.locale ==  const Locale(
        Strings.english,
      )) {
        return FontFamily.gilroy;
    } else {
      return FontFamily.cairo;
    }
  }
}