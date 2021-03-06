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

  static String getFormattedDateWithDateTime(DateTime dt) {
    String dayOfMonthSuffix = getDayOfMonthSuffix(dt.day);
    return DateFormat('h:mma').format(dt) + ' ' + dt.day.toString() + dayOfMonthSuffix + ' ' + DateFormat('MMMM yyyy').format(dt);
  }

  static String getDateTimeDiff(DateTime dt1, DateTime dt2) {
    if (dt1.difference(dt2).inDays > 0) {
      return dt1.difference(dt2).inDays.toString() + 'd ago';
    } else if (dt1.difference(dt2).inHours > 0) {
      return dt1.difference(dt2).inHours.toString() + 'h ago';
    } else if (dt1.difference(dt2).inMinutes > 0) {
      return dt1.difference(dt2).inMinutes.toString() + 'm ago';
    } else if (dt1.difference(dt2).inSeconds > 0) {
      return dt1.difference(dt2).inSeconds.toString() + 's ago';
    } else {
      if (dt2.difference(dt1).inDays > 0) {
        return dt2.difference(dt1).inDays.toString() + 'd left';
      } else if (dt2.difference(dt1).inHours > 0) {
        return dt2.difference(dt1).inHours.toString() + 'h left';
      } else if (dt2.difference(dt1).inMinutes > 0) {
        return dt2.difference(dt1).inMinutes.toString() + 'm left';
      } else if (dt2.difference(dt1).inSeconds > 0) {
        return dt2.difference(dt1).inSeconds.toString() + 's left';
      } else {
        return '0s left';
      }
    }
  }
}