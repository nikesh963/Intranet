// features/tickets/presentation/controllers/manage_tickets_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/manage_leave_model.dart';
import '../widget/create_leave_dialog.dart';

class ManageLeaveController extends GetxController {
  final RxList<ManageLeaveModel> leaveTickets = <ManageLeaveModel>[
    ManageLeaveModel(
      employee: 'John Doe',
      ro: 'RO001',
      leaveType: 'Loss Of Pay(LOP)',
      appliedOn: '2023-12-15',
      startDate: '2023-12-20',
      endDate: '2023-12-22',
      totalDays: '3',
      status: 'Approved',
      lastUpdatedBy: 'Admin',
    ),
    ManageLeaveModel(
      employee: 'Jane Smith',
      ro: 'RO002',
      leaveType: 'Loss Of Pay(LOP)',
      appliedOn: '2023-12-14',
      startDate: '2023-12-16',
      endDate: '2023-12-17',
      totalDays: '2',
      status: 'Pending',
      lastUpdatedBy: 'Manager',
    ),
    ManageLeaveModel(
      employee: 'Bob Johnson',
      ro: 'RO003',
      leaveType: 'Earned',
      appliedOn: '2023-12-10',
      startDate: '2023-12-25',
      endDate: '2023-12-31',
      totalDays: '7',
      status: 'Approved',
      lastUpdatedBy: 'HR',
    ),
    ManageLeaveModel(
      employee: 'Alice Brown',
      ro: 'RO004',
      leaveType: 'Earned',
      appliedOn: '2023-12-01',
      startDate: '2024-01-01',
      endDate: '2024-04-01',
      totalDays: '90',
      status: 'Approved',
      lastUpdatedBy: 'HR Manager',
    ),
    ManageLeaveModel(
      employee: 'Charlie Wilson',
      ro: 'RO005',
      leaveType: 'Earned',
      appliedOn: '2023-12-18',
      startDate: '2023-12-19',
      endDate: '2023-12-19',
      totalDays: '1',
      status: 'Rejected',
      lastUpdatedBy: 'Supervisor',
    ),
    ManageLeaveModel(
      employee: 'David Miller',
      ro: 'RO006',
      leaveType: 'Earned',
      appliedOn: '2023-12-12',
      startDate: '2023-12-28',
      endDate: '2023-12-29',
      totalDays: '2',
      status: 'Pending',
      lastUpdatedBy: 'Team Lead',
    ),
    ManageLeaveModel(
      employee: 'Eva Davis',
      ro: 'RO007',
      leaveType: 'Earned',
      appliedOn: '2023-12-05',
      startDate: '2024-01-15',
      endDate: '2024-01-30',
      totalDays: '16',
      status: 'Approved',
      lastUpdatedBy: 'HR',
    ),
    ManageLeaveModel(
      employee: 'Frank Thomas',
      ro: 'RO008',
      leaveType: 'Earned',
      appliedOn: '2023-12-16',
      startDate: '2023-12-18',
      endDate: '2023-12-20',
      totalDays: '3',
      status: 'Approved',
      lastUpdatedBy: 'Manager',
    ),
  ].obs;

  final RxString selectedMonth = 'December 2025'.obs;
  final Rx<DateTimeRange?> selectedDateRange = Rx<DateTimeRange?>(null);
  final RxString selectedDateText = ''.obs;
  final TextEditingController datePickerController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final RxString selectedStatus = 'All'.obs;
  final RxString selectedDepartment = 'All'.obs;
  final RxString selectedPriority = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onCreateTicketPressed() {
    // Navigate to create ticket screen or show dialog
    Get.dialog(
      CreateLeaveDialog(),
      barrierDismissible: false,
    );
  }
}