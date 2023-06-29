import 'package:intl/intl.dart';

class DateService {
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static String formatRelativeDate(DateTime date) {
    final DateFormat formatter;

    if (date.year == DateTime.now().year && date.month == DateTime.now().month) {
      if (date.day == DateTime.now().day) {
        return 'Today';
      } else if (date.day == DateTime.now().day - 1) {
        return 'Yesterday';
      }
    }

    if (date.year == DateTime.now().year) {
      formatter = DateFormat('EEE, MMMM d');
    } else {
      formatter = DateFormat('EEE, MMMM d, yyyy');
    }

    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static DateTime parseDate(String date) {
    return DateTime.parse(date);
  }
}
