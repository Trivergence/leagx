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
}