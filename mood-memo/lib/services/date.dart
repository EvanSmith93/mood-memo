import 'package:intl/intl.dart';

// TODO: Have this class extend the DateTime class
class DateService {
  /// Formats a date into a string, e.g. "2021-03-15"
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  /// Formats a date into a relative date string, e.g. "Yesterday", "June 7", "March 15, 2021"
  static String formatRelativeDate(DateTime date) {
    final DateFormat formatter;

    // Use the difference method to get the duration between date and now
    Duration diff = date.difference(DateTime.now());
    // Convert the duration to days and round it to the nearest integer
    int days = diff.inDays.round();
    // Check the value of days and return the appropriate string
    if (days == 0) {
      return 'Today';
    } else if (days == -1) {
      return 'Yesterday';
    }

    if (date.year == DateTime.now().year) {
      formatter = DateFormat('EEE, MMMM d');
    } else {
      formatter = DateFormat('EEE, MMMM d, yyyy');
    }

    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  /// Checks if two dates are the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Parses a date string into a DateTime object
  static DateTime parseDate(String date) {
    return DateTime.parse(date);
  }
}
