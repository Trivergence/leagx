import 'dart:io';
import 'dart:ui';

import 'package:country_codes/country_codes.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';

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
}