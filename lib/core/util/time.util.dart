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

  static String getTimeAgo(String milliseconds) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(milliseconds),
    );
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
