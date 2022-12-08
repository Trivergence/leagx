import 'dart:io';
import 'dart:ui';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:leagx/constants/enums.dart';
import 'package:leagx/constants/font_family.dart';
import 'package:leagx/core/sharedpref/sharedpref.dart';
import 'package:leagx/providers/localization_provider.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/strings.dart';
import '../ui/util/locale/localization.dart';

class Utility {
  static bool isMatchOver(String status) {
    if (status == MatchStatus.finished.value ||
        status == MatchStatus.afterExTime.value ||
        status == MatchStatus.afterPanalty.value ||
        status == MatchStatus.postponed.value ||
        status == MatchStatus.delayed.value ||
        status == MatchStatus.cancelled.value ||
        status == MatchStatus.awarded.value) {
      return true;
    } else {
      return false;
    }
  }

  static bool isTimeValid(String matchStatus) {
    if (matchStatus == MatchStatus.halfTime.value) {
      return false;
    } else if (matchStatus.contains("+")) {
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
      timeZone = await FlutterNativeTimezone.getLocalTimezone();
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
          ToastMessage.show(loc.errorInvalidUrl, TOAST_TYPE.error);
        }
      } on PlatformException catch (_) {
      } catch (_) {
        ToastMessage.show(loc.errorInvalidUrl, TOAST_TYPE.error);
      }
    } else {
      ToastMessage.show(loc.errorInvalidUrl, TOAST_TYPE.error);
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
    if (localizationProvider.locale ==
        const Locale(
          Strings.english,
        )) {
      return FontFamily.gilroy;
    } else {
      return FontFamily.cairo;
    }
  }

  static bool isPredictionPending(String? status) {
    if (status == MatchStatus.finished.value ||
        status == MatchStatus.afterExTime.value ||
        status == MatchStatus.afterPanalty.value) {
      return false;
    } else {
      return true;
    }
  }

  static bool isRTL(String text) {
    return Bidi.detectRtlDirectionality(text);
  }
}
