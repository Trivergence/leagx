import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';

class ValidationHelper {
 static String? validatePassword(String? text) {
  if(text == null || text.isEmpty) {
    return loc.errorRequired;
  } else if(text.length  < 8) {
    return loc.errorPasswordLength;
  }
  return null;
 }
 static String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return loc.errorRequired;
    } else if (!ValidationUtils.isEmailValid(text)) {
      return loc.errorInvalidEmail;
    }
    return null;
  }
  static String? validatePhone(String? text) {
    if (text == null || text.isEmpty) {
      return loc.errorRequired;
    } else if (text.length < 11 || text.length > 13) {
      return loc.errorInvalidPhone;
    }
    return null;
  }
  static String? validateField(String? text) {
    if (text == null || text.isEmpty) {
      return loc.errorRequired;
    }
    return null;
  }
}