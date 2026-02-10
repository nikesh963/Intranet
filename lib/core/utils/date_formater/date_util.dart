import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateUtil {
  static final DateFormat pickerInFormat =
      DateFormat("yyyy-MM-dd HH:mm:ss.SSS");

  static final DateFormat pickerOutFormat = DateFormat("yyyy-MM-dd HH:mm");

  static final DateFormat requestFormat =
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  static final DateFormat staffTaskListFormat =
      DateFormat("dd MMM yyyy");

  static final DateFormat editTaskTimeFormat =
  DateFormat("hh:mm a");
  static final DateFormat editTaskDateFormat =
  DateFormat("EEE, dd MMM yyyy");

  static final DateFormat ticketListFormat = DateFormat("dd MMM yy");
  static final DateFormat ddMMyyyyFormat = DateFormat("dd-MM-yyyy");

  static final DateFormat hourInFormat = DateFormat("hh:mm:ss");
  static final DateFormat hourOutFormat = DateFormat("hh:mm a");
  static final DateFormat leaveInFormat = DateFormat("yyyy-MM-dd");

  static String getRequestDateNow() {
    return requestFormat.format(DateTime.now());
  }

  static String todayWeekday() {
    return DateFormat('EEEE').format(DateTime.now());
  }

  static String getTodayyyyyMMddDate() {
    return leaveInFormat.format(DateTime.now());
  }
  static String getyyyyMMddDate(String inputDate) {
    return leaveInFormat.format(DateTime.parse(inputDate).toLocal());
  }

  static String getOrderDate(String inputDate) {
    return staffTaskListFormat.format(DateTime.parse(inputDate).toLocal());
  }

  static String getddMMyyyyDate(String inputDate) {
    if (inputDate.isEmpty) inputDate = getRequestDateNow();
    return ddMMyyyyFormat.format(DateTime.parse(inputDate).toLocal());
  }

  static String getTicketListDate(String inputDate) {
    return ticketListFormat.format(DateTime.parse(inputDate));
  }

  static String taskListToUpsert(String inputDate) {
    return requestFormat.format(DateTime.parse(inputDate).toLocal());
  }

  static String datePickerInFormat(String inputDate) {
    return pickerInFormat.format(DateTime.parse(inputDate).toLocal());
  }
  static String getEditTaskTime(String inputDate) {
    return editTaskTimeFormat.format(DateTime.parse(inputDate).toLocal());
  }

  static String getEditTaskDate(String inputDate) {
    return editTaskDateFormat.format(DateTime.parse(inputDate).toLocal());
  }
  static String datePickerOutFormatRequestFormat(String inputDate) {
    return requestFormat.format(pickerOutFormat.parse(inputDate).toLocal());
  }

  static String datePickerOutFormat(String inputDate) {
    return pickerOutFormat.format(DateTime.parse(inputDate));
  }

  static String leaveDifference(String leavesStartDate,String leavesEndDate) {
    DateTime startDate = DateTime.parse(leavesStartDate);
    DateTime endDate = DateTime.parse(leavesEndDate);
    Duration difference = endDate.difference(startDate);
    return "${difference.inDays + 1}";
  }

  static String getTimeIn12Hour(String inputDate) {
    return hourOutFormat.format(hourInFormat.parse(inputDate).toLocal());
  }

  static String staffLeaveDate(String inputDate) {
    return ddMMyyyyFormat.format(leaveInFormat.parse(inputDate).toLocal());
  }

  static String timeAgo(String inputDate) {
    return timeago.format(DateTime.parse(inputDate).toLocal(),
        locale: 'en_short');
  }

  static String chatConversationTime(String inputDate) {
    return hourOutFormat.format(DateTime.parse(inputDate).toLocal());
    // if (inputDate.isEmpty) {
    //   return timeago.format(DateTime.now(), locale: 'en');
    // } else {
    //   return timeago.format(DateTime.parse(inputDate), locale: 'en');
    // }
  }
}
