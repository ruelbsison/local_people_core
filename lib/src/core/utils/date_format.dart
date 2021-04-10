import 'package:intl/intl.dart';

class DateFormatUtil {
  static String getDayOfMonthSuffix(final int n) {
    //assert(n >= 1 && n <= 31, "illegal day of month: " + n);
    if (n >= 11 && n <= 13) {
      return "th";
    }
    switch (n % 10) {
      case 1:  return "st";
      case 2:  return "nd";
      case 3:  return "rd";
      default: return "th";
    }
  }

  static String getFormattedDate() {
    String dayOfMonthSuffix = getDayOfMonthSuffix(DateTime.now().day);
    return DateTime.now().day.toString() + dayOfMonthSuffix + ' ' + DateFormat('MMMM yyyy').format(DateTime.now());
  }
}