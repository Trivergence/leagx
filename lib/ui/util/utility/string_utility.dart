class StringUtility {
  static String getShortName(String fullName) {
    if (fullName.length > 3) {
      fullName = fullName.substring(1,4);
    }
    return fullName.toUpperCase();
  }
}