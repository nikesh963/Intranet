import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../../../../Common/CommonSnackBar.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../../../core/theme/app_theme.dart';
import '../../model/attendance_model.dart';
import '../widget/add_ticket_dialog.dart';

class AttendanceController extends GetxController {

  final ApiHelper _apiHelper = ApiHelper();

  /// LOADING
  RxBool isLoading = false.obs;
  RxInt currentPage = 1.obs;
  RxInt lastPage = 1.obs;
  RxInt totalItems = 0.obs;
  RxInt perPage = 10.obs;
  bool get hasNextPage => currentPage.value < lastPage.value;
  bool get hasPreviousPage => currentPage.value > 1;

  /// MAIN DATA
  RxList<AttendanceElement> attendanceRecords =
      <AttendanceElement>[].obs;

  /// STATS
  RxDouble totalAbsent = 0.0.obs;
  RxDouble totalPresent = 0.0.obs;

  /// MONTH
  RxString selectedMonthYear = ''.obs;

  /// PAGINATION
  // RxInt currentPage = 1.obs;

  @override
  void onInit() {
    super.onInit();

    selectedMonthYear.value =
        DateFormat('MMMM yyyy').format(DateTime.now());

    fetchAttendance();
  }

  /// FETCH API
  // Future<void> fetchAttendance() async {
  //   try {
  //     isLoading.value = true;
  //
  //     final month =
  //     DateFormat('yyyy-MM').format(
  //       DateFormat('MMMM yyyy')
  //           .parse(selectedMonthYear.value),
  //     );
  //
  //     final response = await _apiHelper.get(
  //       "/mobile/attendanceemployee",
  //       queryParameters: {
  //         "view_type": "table",
  //         "type": "monthly",
  //         "month": month,
  //       },
  //     );
  //
  //     final attendance =
  //     Attendance.fromJson(response.data);
  //
  //     attendanceRecords.value =
  //         attendance.data?.attendance ?? [];
  //
  //     totalPresent.value =
  //         attendance.data?.attendanceStatus?.present ?? 0;
  //
  //     totalAbsent.value =
  //         attendance.data?.attendanceStatus?.absent ?? 0;
  //
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error",
  //       e.toString(),
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future<void> fetchAttendance({int page = 1}) async {
    try {
      isLoading.value = true;

      final month = DateFormat('yyyy-MM').format(
        DateFormat('MMMM yyyy').parse(
          selectedMonthYear.value,
        ),
      );

      final response = await _apiHelper.get(
        "/mobile/attendanceemployee",
        queryParameters: {
          "view_type": "table",
          "type": "monthly",
          "month": month,
          "page": page,
        },
      );

      final attendance = Attendance.fromJson(response.data);

      attendanceRecords.value =
          attendance.data?.attendance ?? [];

      totalPresent.value =
          attendance.data?.attendanceStatus?.present ?? 0;

      totalAbsent.value =
          attendance.data?.attendanceStatus?.absent ?? 0;

      /// PAGINATION DATA
      currentPage.value =
          attendance.data?.pagination?.currentPage ?? 1;

      lastPage.value =
          attendance.data?.pagination?.lastPage ?? 1;

      totalItems.value =
          attendance.data?.pagination?.total ?? 0;

      perPage.value =
          attendance.data?.pagination?.perPage ?? 10;

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

    } finally {
      isLoading.value = false;
    }
  }

  void nextPage() {
    if (currentPage.value < lastPage.value) {
      fetchAttendance(page: currentPage.value + 1);
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      fetchAttendance(page: currentPage.value - 1);
    }
  }

  void changePage(int page) {
    if (page != currentPage.value && page <= lastPage.value && page >= 1) {
      fetchAttendance(page: page);
    }
  }
  /// MONTH PICKER
  Future<void> pickMonthYear(
      BuildContext context) async {

    final theme = Theme.of(context);

    final DateTime? picked =
    await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),

      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme:
            theme.colorScheme.copyWith(
              primary: AppTheme.colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),

            textButtonTheme:
            TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                AppTheme.colors.blue,
              ),
            ),
          ),

          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(
              textScaler:
              const TextScaler.linear(0.92),
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {

      selectedMonthYear.value =
          DateFormat('MMMM yyyy')
              .format(picked);
      currentPage.value = 1;
      fetchAttendance(page: 1);
    }
  }

  // void onAddTicketPressed(String date) {
  //   Get.dialog(
  //     AddTicketDialog(date: date),
  //     barrierDismissible: false,
  //   );
  // }
  void onAddTicketPressed(AttendanceElement record) {

    Get.dialog(AddTicketDialog(record: record),

      /// CLOSE WHEN CLICK OUTSIDE
      barrierDismissible: true,
    );
  }

  /// FORMATTERS
  String formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('dd MMM yyyy')
        .format(date);
  }

  String formatDateTime(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('dd MMM yyyy, hh:mm a')
        .format(date);
  }

  Future<bool> createAttendanceTicket({
    required String title,
    required String priority,
    required String description,
    required String department,
    required int attendanceId,
    PlatformFile? file,
  }) async {

    try {

      isLoading.value = true;

      dio.FormData formData = dio.FormData.fromMap({

        "title": title,

        "priority": priority.toLowerCase(),

        "description": description,

        "ticket_department": department,

        "attendance_id": attendanceId,
      });

      /// FILE
      if (file != null && file.path != null) {

        formData.files.add(
          MapEntry(
            "atteched_file[]",

            await dio.MultipartFile.fromFile(
              file.path!,
              filename: file.name,
            ),
          ),
        );
      }

      final response = await _apiHelper.postFormData(
        "/mobile/ticket-store",
        formData,
      );

      debugPrint(
        "CREATE ATTENDANCE TICKET RESPONSE : ${response.data}",
      );

      /// CLOSE DIALOG ON SUCCESS
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      /// SUCCESS SNACKBAR
      Future.delayed(
        const Duration(milliseconds: 200),
            () {

          SnackBarService.showSuccessSnackBar(
            response.data["message"] ??
                "Ticket created successfully",
          );
        },
      );

      /// REFRESH ATTENDANCE
      await fetchAttendance(
        page: currentPage.value,
      );

      return true;

    } catch (e) {

      debugPrint(
        "CREATE ATTENDANCE TICKET ERROR : $e",
      );

      /// DO NOT CLOSE DIALOG
      SnackBarService.showErrorSnackBar(
        "Failed to create ticket",
      );

      return false;

    } finally {

      isLoading.value = false;
    }
  }
}