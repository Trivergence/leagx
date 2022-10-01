import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:leagx/constants/strings.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateUtility {
  static String getApiFormat(DateTime dateTime) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
  static String getUiFormat(DateTime dateTime) {
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }
  static String getRemainingTime(DateTime dateTime , Locale locale) {
    String tempLocale = "en";
    if(locale == const Locale(Strings.arabic)) {
      timeago.setLocaleMessages("ar", timeago.ArMessages());
      tempLocale = "ar";
    } else {
      tempLocale = "en";
    }
    if (dateTime.isUtc) {
      return timeago.format(dateTime.toLocal(), locale: tempLocale) ;
    }
    else {
      return timeago.format(dateTime, locale: tempLocale);
    }
  }
  static bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    return date == today;
  }
}