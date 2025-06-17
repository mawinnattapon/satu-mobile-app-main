import 'package:intl/intl.dart';
import 'package:satu/constants/date.dart';

class DateUtil {
  static String toJson(DateTime datetime) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(datetime); //2022-01-06T14:31:56
  }

  // static String dateView(String? datetime) {
  //   if (datetime == null || datetime.isEmpty) return "";
  //   DateTime nd = DateTime.parse(datetime);
  //   return DateFormat("dd/MM/yyyy HH:mm:ss").formatThai(nd);
  // }

  static String dateDay(String? datetime) {
    if (datetime == null || datetime.isEmpty) return "";
    DateTime nd = DateTime.parse(datetime);
    return DateFormat('EEEE, MMM d, yyyy').format(nd);
  }

  static String date(String datetime) {
    DateTime nd = DateTime.parse(datetime);
    return DateFormat("dd/MM/yyyy").formatThai(nd);
  }

  static String dateViewMonth(String? datetime) {
    if (datetime == null || datetime.isEmpty) return "";
    DateTime nd = DateTime.parse(datetime);
    return DateFormat("d MMMM yyyy").formatThai(nd);
  }

  static String dayDateViewMonth(String? datetime) {
    if (datetime == null || datetime.isEmpty) return "";
    DateTime nd = DateTime.parse(datetime);
    return DateFormat("EEEE d MMMM yyyy").formatThai(nd);
  }

  static String dateTimeViewMonth(String? datetime) {
    if (datetime == null || datetime.isEmpty) return "";
    DateTime nd = DateTime.parse(datetime);
    return DateFormat("dd MMMM yyyy HH:mm").formatThai(nd);
  }

  static String dateMonthYear(DateTime datetime) {
    return DateFormat("MMMM yyyy").formatThai(datetime);
  }

  static String timeStartEnd(String start, String end) {
    if (start.isEmpty && end.isEmpty) return "";
    if (start.isNotEmpty && end.isEmpty) return "${start.substring(0, 5)} น.";
    if (start.isEmpty && end.isNotEmpty) return "${end.substring(0, 5)} น.";
    return "${start.substring(0, 5)}-${end.substring(0, 5)} น.";
  }

  static int diffSeconds(DateTime start, DateTime end) {
    return (end.difference(start).inSeconds).round();
  }

  static int diffMinute(DateTime start, DateTime end) {
    return (end.difference(start).inMinutes).round();
  }

  static String engYear(String txt) {
    List<String> ls = txt.split("/");
    int year = int.parse(ls.elementAt(2));
    if (year > 2400) year = year - 543;
    return "${ls.elementAt(0)}/${ls.elementAt(1)}/$year";
  }
}
