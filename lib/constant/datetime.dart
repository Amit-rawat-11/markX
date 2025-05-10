import 'package:intl/intl.dart';


class TimeUtils {
  static String get formattedDate {
    final now = DateTime.now();
    return DateFormat('d MMMM y').format(now); // e.g., 2 May 2025
  }

  static String get formattedTime {
    final now = DateTime.now();
    return DateFormat('h:mm a').format(now); // e.g., 5:20 PM
  }
}
