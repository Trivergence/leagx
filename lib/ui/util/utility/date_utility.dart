import 'package:intl/intl.dart';

class DateUtility {
  static String getApiFormat(DateTime dateTime) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}