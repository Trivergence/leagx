class ValidationUtils {
  static bool isValid(Object? o) => !(o == null || false == o || "" == o);

  static String? text(String text, String error) {
    return text.isEmpty ? error : null;
  }

  static String? number(String text, String error) {
    return (isValid(double.tryParse(text)) && double.parse(text) >= 0)
        ? null
        : error;
  }

  static String? email(String text, String error) {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(text) ? null : error;
  }
}
