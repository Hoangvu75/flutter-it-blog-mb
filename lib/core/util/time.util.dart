import 'package:intl/intl.dart';

class TimeUtil {
  TimeUtil._();

  static String getFormattedTime(
      {required String milliseconds, required String format}) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(milliseconds),
    );
    final formattedDate = DateFormat(format).format(dateTime);
    return formattedDate;
  }
}
