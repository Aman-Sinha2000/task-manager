import 'package:intl/intl.dart';

class CFormatter {
  CFormatter._();
  static DateTime parseDate(String date) {
    return DateFormat('dd-MM-yyyy').parse(date);
  }
}
