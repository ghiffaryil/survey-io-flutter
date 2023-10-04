import 'package:intl/intl.dart';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat('d MMM y', 'en_US');
    return formatter.format(this).toUpperCase();
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
