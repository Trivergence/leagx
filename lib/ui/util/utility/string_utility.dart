class StringUtility {
  static String getShortName(String fullName) {
    if (fullName.length > 3) {
      fullName = fullName.substring(0,3);
    }
    return fullName.toUpperCase();
  }
}