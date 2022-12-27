import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/validation/validation_utils.dart';

class ValidationHelper {
  static String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return loc.errorRequired;
    } else if (text.length < 8) {
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
    String pattern = r'(^(?:[+0]9)?[0-9]{4,15}$)';
    RegExp regExp = RegExp(pattern);
    if (text != null && text.isNotEmpty && !regExp.hasMatch(text)) {
      return loc.errorInvalidPhone;
    }
    return null;
  }

  static String? validateAmount(String? text) {
    if (text == null || text.isEmpty) {
      return loc.errorRequired;
    } else if (int.parse(text) < 50) {
      return loc.errorWithdrawLimit;
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
