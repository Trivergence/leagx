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
}