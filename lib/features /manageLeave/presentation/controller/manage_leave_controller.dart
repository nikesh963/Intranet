// features/tickets/presentation/controller/manage_leave_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Common/CommonSnackBar.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../model/manage_leave_model.dart';
import '../widget/create_leave_dialog.dart';

class ManageLeaveController extends GetxController {
  final ApiHelper apiHelper = ApiHelper();

  RxBool isLoading = false.obs;

  RxList<Leaf> leaveTickets = <Leaf>[].obs;

  final TextEditingController searchController = TextEditingController();
  bool get hasNextPage => currentPage.value < lastPage.value;
  bool get hasPreviousPage => currentPage.value > 1;
  RxInt currentPage = 1.obs;
  RxInt lastPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxInt totalRecords = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getLeaves();
  }

  void changePage(int page) {
    if (page != currentPage.value) {
      getLeaves(page: page);
    }
  }

  Future<void> getLeaves({int page = 1}) async {
    try {
      isLoading.value = true;

      final response = await apiHelper.get(
        "/mobile/leaves",
        queryParameters: {
          "page": page,
        },
      );

      Leaves leavesResponse = Leaves.fromJson(response.data);

      leaveTickets.value = leavesResponse.data?.leaves ?? [];

      currentPage.value = leavesResponse.data?.currentPage ?? 1;
      lastPage.value = leavesResponse.data?.lastPage ?? 1;
      totalPages.value = leavesResponse.data?.lastPage ?? 1;
      totalRecords.value = leavesResponse.data?.total ?? 0;
    } catch (e) {
      debugPrint("Error fetching leaves: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void nextPage() {
    if (currentPage.value < lastPage.value) {
      getLeaves(page: currentPage.value + 1);
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      getLeaves(page: currentPage.value - 1);
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat("dd MMM yyyy").format(date);
  }

  void onCreateTicketPressed() {
    Get.dialog(
      const CreateLeaveDialog(),
      barrierDismissible: true,
    );
  }
  // Leave Type Mapping
  int getLeaveTypeId(String leaveType) {
    switch (leaveType) {
      case 'LOP (Loss Of Pay)':
        return 1;

      case 'Earned':
        return 2;

      default:
        return 1;
    }
  }

// Day Mapping
  String getDayValue(String dayType) {
    switch (dayType) {
      case 'Full Day':
        return 'full_day';

      case 'First Half':
        return 'first_half';

      case 'Second Half':
        return 'second_half';

      default:
        return 'full_day';
    }
  }

  /// CREATE LEAVE API
  Future<bool> createLeave({
    required String leaveType,
    required String startDate,
    required String endDate,
    required String leaveReason,
    required String startDay,
    required String endDay,
  }) async {
    try {
      isLoading.value = true;

      final Map<String, dynamic> body = {
        "leave_type_id": getLeaveTypeId(leaveType),
        "start_date": startDate,
        "end_date": endDate,
        "leave_reason": leaveReason,
        "start_day": getDayValue(startDay),
        "end_day": getDayValue(endDay),
      };

      final response = await apiHelper.post(
        "/mobile/leave-store",
        data: body,
      );

      debugPrint("Create Leave Response : ${response.data}");

      /// CLOSE DIALOG FIRST
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      /// SHOW SUCCESS SNACKBAR
      Future.delayed(const Duration(milliseconds: 200), () {
        SnackBarService.showSuccessSnackBar(
          response.data["message"] ?? "Leave created successfully",
        );
      });

      /// Refresh leave list
      await getLeaves(page: currentPage.value);

      return true;

    } catch (e) {

      debugPrint("Create Leave Error : $e");

      /// DON'T CLOSE DIALOG
      SnackBarService.showErrorSnackBar(
        "Failed to create leave",
      );

      return false;

    } finally {
      isLoading.value = false;
    }
  }
}