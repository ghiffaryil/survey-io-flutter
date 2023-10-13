import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat('d MMM y', 'en_US');
    return formatter.format(this).toUpperCase();
  }

  String formatDateId() {
    initializeDateFormatting('id', null);
    final formatter = DateFormat('d MMMM y', 'id');
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
