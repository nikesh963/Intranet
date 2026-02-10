import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/attendance_model.dart';
import '../widget/add_ticket_dialog.dart';

class AttendanceController extends GetxController {
  final RxList<AttendanceRecord> attendanceRecords = <AttendanceRecord>[
    AttendanceRecord(
      employee: 'John Doe',
      date: 'Dec 15, 2025',
      day: 'Monday',
      status: 'Absent',
      statusCode: 'A',
      hasTicket: true,
      punchingTime: '9 H',
      hubstuffTime: '8 H',
      leaveRecord: 'None',
      punchRecords: '2',
      clockIn: '09:15 AM',
      clockOut: '06:15 PM',
      late: '15 min',
      earlyLeaving: '0 min',
      overtime: '0 H',
      updatedBy: 'System',
      updateAt: 'Dec 15, 10:00 AM',
    ),
    AttendanceRecord(
      employee: 'John Doe',
      date: 'Dec 16, 2025',
      day: 'Tuesday',
      status: 'Present',
      statusCode: 'P',
      hasTicket: false,
      punchingTime: '8 H',
      hubstuffTime: '8 H',
      leaveRecord: 'None',
      punchRecords: '1',
      clockIn: '09:00 AM',
      clockOut: '06:00 PM',
      late: '0 min',
      earlyLeaving: '0 min',
      overtime: '0 H',
      updatedBy: 'System',
      updateAt: 'Dec 16, 10:00 AM',
    ),
    AttendanceRecord(
      employee: 'John Doe',
      date: 'Dec 17, 2025',
      day: 'Wednesday',
      status: 'Present',
      statusCode: 'P',
      hasTicket: false,
      punchingTime: '8 H',
      hubstuffTime: 'N/A',
      leaveRecord: 'None',
      punchRecords: '1',
      clockIn: '09:00 AM',
      clockOut: '06:00 PM',
      late: '0 min',
      earlyLeaving: '0 min',
      overtime: '0 H',
      updatedBy: 'System',
      updateAt: 'Dec 17, 10:00 AM',
    ),
    AttendanceRecord(
      employee: 'John Doe',
      date: 'Dec 18, 2025',
      day: 'Thursday',
      status: 'Present',
      statusCode: 'P',
      hasTicket: false,
      punchingTime: 'N/A',
      hubstuffTime: 'N/A',
      leaveRecord: 'None',
      punchRecords: '0',
      clockIn: 'N/A',
      clockOut: 'N/A',
      late: 'N/A',
      earlyLeaving: 'N/A',
      overtime: 'N/A',
      updatedBy: 'System',
      updateAt: 'Dec 18, 10:00 AM',
    ),
    AttendanceRecord(
      employee: 'John Doe',
      date: 'Dec 19, 2025',
      day: 'Friday',
      status: 'Present',
      statusCode: 'P',
      hasTicket: false,
      punchingTime: 'N/A',
      hubstuffTime: 'N/A',
      leaveRecord: 'None',
      punchRecords: '0',
      clockIn: 'N/A',
      clockOut: 'N/A',
      late: 'N/A',
      earlyLeaving: 'N/A',
      overtime: 'N/A',
      updatedBy: 'System',
      updateAt: 'Dec 19, 10:00 AM',
    ),
    AttendanceRecord(
      employee: 'John Doe',
      date: 'Dec 20, 2025',
      day: 'Saturday',
      status: 'Absent',
      statusCode: 'A',
      hasTicket: true,
      punchingTime: 'N/A',
      hubstuffTime: 'N/A',
      leaveRecord: 'Sick Leave',
      punchRecords: '0',
      clockIn: 'N/A',
      clockOut: 'N/A',
      late: 'N/A',
      earlyLeaving: 'N/A',
      overtime: 'N/A',
      updatedBy: 'HR',
      updateAt: 'Dec 20, 09:30 AM',
    ),
    AttendanceRecord(
      employee: 'Jane Smith',
      date: 'Dec 15, 2025',
      day: 'Monday',
      status: 'Present',
      statusCode: 'P',
      hasTicket: false,
      punchingTime: '8.5 H',
      hubstuffTime: '8 H',
      leaveRecord: 'None',
      punchRecords: '1',
      clockIn: '09:05 AM',
      clockOut: '06:05 PM',
      late: '5 min',
      earlyLeaving: '0 min',
      overtime: '0.5 H',
      updatedBy: 'System',
      updateAt: 'Dec 15, 10:00 AM',
    ),
    AttendanceRecord(
      employee: 'Jane Smith',
      date: 'Dec 16, 2025',
      day: 'Tuesday',
      status: 'Present',
      statusCode: 'P',
      hasTicket: false,
      punchingTime: '8 H',
      hubstuffTime: '8 H',
      leaveRecord: 'None',
      punchRecords: '1',
      clockIn: '09:00 AM',
      clockOut: '06:00 PM',
      late: '0 min',
      earlyLeaving: '0 min',
      overtime: '0 H',
      updatedBy: 'System',
      updateAt: 'Dec 16, 10:00 AM',
    ),
  ].obs;

  final RxString selectedMonth = 'December 2025'.obs;
  final RxString selectedDate = ''.obs;
  final RxInt totalAbsent = 2.obs;
  final RxInt totalPresent = 29.obs;
  final TextEditingController datePickerController = TextEditingController();

  final Rx<DateTimeRange?> selectedDateRange = Rx<DateTimeRange?>(null);
  final RxString selectedDateText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Set default to current month
    _setDefaultCurrentMonth();
  }

  void _setDefaultCurrentMonth() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    // Ensure last day doesn't exceed current date
    final safeLastDay = lastDayOfMonth.isAfter(now) ? now : lastDayOfMonth;

    selectedDateRange.value = DateTimeRange(start: firstDayOfMonth, end: safeLastDay);
    selectedDateText.value = DateFormat('MMMM yyyy').format(now);
  }

  void pickDateRange(BuildContext context) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final now = DateTime.now();

    // Ensure initial date range doesn't exceed current date
    DateTimeRange? safeInitialRange;
    if (selectedDateRange.value != null) {
      final start = selectedDateRange.value!.start;
      // Ensure end date doesn't exceed current date
      final end = selectedDateRange.value!.end.isAfter(now)
          ? now
          : selectedDateRange.value!.end;
      safeInitialRange = DateTimeRange(start: start, end: end);
    } else {
      _setDefaultCurrentMonth();
      safeInitialRange = selectedDateRange.value;
    }

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: now, // Current date as last date
      initialDateRange: safeInitialRange,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.colorScheme.primary,
              onPrimary: theme.colorScheme.onPrimary,
              onSurface: theme.colorScheme.onSurface,
            ),
            textTheme: theme.textTheme.copyWith(
              bodyMedium: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
            dialogBackgroundColor: theme.dialogBackgroundColor,
            datePickerTheme: DatePickerThemeData(
              backgroundColor: isDark ? Colors.grey[900] : Colors.white,
              headerBackgroundColor:
              isDark ? Colors.grey[850] : theme.colorScheme.primary,
              rangeSelectionBackgroundColor:
              theme.colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDateRange.value = picked;

      // Format to show month and year only
      final monthYear = DateFormat('MMMM yyyy').format(picked.start);
      selectedDateText.value = monthYear;

      // Also update the TextEditingController if you still need it
      datePickerController.text = monthYear;

      print('Selected month: $monthYear');
      print('Start date: ${DateFormat('yyyy-MM-dd').format(picked.start)}');
      print('End date: ${DateFormat('yyyy-MM-dd').format(picked.end)}');
    }
  }

  void onAddTicketPressed(String date) {
    Get.dialog(
      AddTicketDialog(date: date),
      barrierDismissible: false,
    );
  }
}