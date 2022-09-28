class StringUtility {
  static String getShortName(String fullName) {
    if (fullName.length > 3) {
      fullName = fullName.substring(0,3);
    }
    return fullName.toUpperCase();
  }
  static String capitalizeFirstLetter(String word) {
    return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
  }
}