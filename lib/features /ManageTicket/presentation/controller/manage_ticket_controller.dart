// features/tickets/presentation/controllers/manage_tickets_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/manage_ticket_model.dart';
import '../widget/create_ticket_dialog.dart';



class ManageTicketsController extends GetxController {
  final RxList<ManageTicketModel> tickets = <ManageTicketModel>[
    ManageTicketModel(
      id: '1',
      employee: 'John Doe',
      date: 'Dec 15, 2025',
      ticketCode: 'TCK-001',
      status: 'Approve',
      title: 'Attendance Change Request',
      description: 'Need to change attendance status from Absent to Present',
      ro: 'Manager 1',
      newStatus: 'Present',
      department: 'HR Department',
      priority: 'High',
      createdBy: 'John Doe',
      createdAt: 'Dec 15, 9:30 AM',
    ),
    ManageTicketModel(
      id: '2',
      employee: 'Jane Smith',
      date: 'Dec 16, 2025',
      ticketCode: 'TCK-002',
      status: 'Rejected',
      title: 'System Access Issue',
      description: 'Unable to access attendance portal',
      ro: 'Manager 2',
      newStatus: 'N/A',
      department: 'Software IT Support',
      priority: 'Critical',
      createdBy: 'Jane Smith',
      createdAt: 'Dec 16, 10:15 AM',
      updatedAt: 'Dec 16, 11:00 AM',
    ),
    ManageTicketModel(
      id: '3',
      employee: 'Robert Johnson',
      date: 'Dec 17, 2025',
      ticketCode: 'TCK-003',
      status: 'Rejected',
      title: 'Late Marking Request',
      description: 'Forgot to mark attendance, request approval',
      ro: 'Manager 1',
      newStatus: 'Present',
      department: 'Reporting Officer',
      priority: 'Medium',
      createdBy: 'Robert Johnson',
      createdAt: 'Dec 17, 8:45 AM',
      resolvedAt: 'Dec 17, 4:30 PM',
    ),
    ManageTicketModel(
      id: '4',
      employee: 'Sarah Williams',
      date: 'Dec 18, 2025',
      ticketCode: 'TCK-004',
      status: 'Pending',
      title: 'Leave Approval Request',
      description: 'Request for 2 days casual leave',
      ro: 'Manager 3',
      newStatus: 'Leave',
      department: 'HR Department',
      priority: 'Low',
      createdBy: 'Sarah Williams',
      createdAt: 'Dec 18, 9:00 AM',
      resolvedAt: 'Dec 18, 12:00 PM',
      updatedAt: 'Dec 18, 3:00 PM',
    ),
    ManageTicketModel(
      id: '5',
      employee: 'Michael Brown',
      date: 'Dec 19, 2025',
      ticketCode: 'TCK-005',
      status: 'Pending',
      title: 'Hardware Issue',
      description: 'Biometric device not working',
      ro: 'Manager 2',
      newStatus: 'N/A',
      department: 'Hardware and IT Support',
      priority: 'High',
      createdBy: 'Michael Brown',
      createdAt: 'Dec 19, 10:30 AM',
    ),
    ManageTicketModel(
      id: '6',
      employee: 'Emily Davis',
      date: 'Dec 20, 2025',
      ticketCode: 'TCK-006',
      status: 'Pending',
      title: 'Salary Query',
      description: 'Deduction in salary for attendance',
      ro: 'Manager 1',
      newStatus: 'N/A',
      department: 'HR Department',
      priority: 'Medium',
      createdBy: 'Emily Davis',
      createdAt: 'Dec 20, 11:00 AM',
      updatedAt: 'Dec 20, 2:30 PM',
    ),
    ManageTicketModel(
      id: '7',
      employee: 'David Wilson',
      date: 'Dec 21, 2025',
      ticketCode: 'TCK-007',
      status: 'Pending',
      title: 'Report Generation Issue',
      description: 'Cannot generate monthly attendance report',
      ro: 'Manager 3',
      newStatus: 'N/A',
      department: 'Software IT Support',
      priority: 'Critical',
      createdBy: 'David Wilson',
      createdAt: 'Dec 21, 9:15 AM',
    ),
    ManageTicketModel(
      id: '8',
      employee: 'Lisa Anderson',
      date: 'Dec 22, 2025',
      ticketCode: 'TCK-008',
      status: 'Pending',
      title: 'Early Leaving Request',
      description: 'Need to leave early for medical appointment',
      ro: 'Manager 2',
      newStatus: 'Half Day',
      department: 'Reporting Officer',
      priority: 'Low',
      createdBy: 'Lisa Anderson',
      createdAt: 'Dec 22, 8:30 AM',
      resolvedAt: 'Dec 22, 10:00 AM',
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
      CreateTicketDialog(),
      barrierDismissible: false,
    );

  }

  void onViewTicket(ManageTicketModel ticket) {
    // Navigate to ticket details screen
    Get.snackbar(
      'View Ticket',
      'Viewing ticket: ${ticket.ticketCode}',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void onEditTicket(ManageTicketModel ticket) {
    // Navigate to edit ticket screen
    Get.snackbar(
      'Edit Ticket',
      'Editing ticket: ${ticket.ticketCode}',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  void onDeleteTicket(ManageTicketModel ticket) {
    Get.defaultDialog(
      title: 'Delete Ticket',
      middleText: 'Are you sure you want to delete ticket ${ticket.ticketCode}?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        tickets.remove(ticket);
        Get.back();
        Get.snackbar(
          'Success',
          'Ticket ${ticket.ticketCode} deleted successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
    );
  }

  // Filter tickets based on search and filters
  List<ManageTicketModel> get filteredTickets {
    return tickets.where((ticket) {
      // Search filter
      final searchTerm = searchController.text.toLowerCase();
      final matchesSearch = searchTerm.isEmpty ||
          ticket.employee.toLowerCase().contains(searchTerm) ||
          ticket.ticketCode.toLowerCase().contains(searchTerm) ||
          ticket.title.toLowerCase().contains(searchTerm) ||
          ticket.department.toLowerCase().contains(searchTerm);

      // Status filter
      final matchesStatus = selectedStatus.value == 'All' ||
          ticket.status.toLowerCase() == selectedStatus.value.toLowerCase();

      // Department filter
      final matchesDepartment = selectedDepartment.value == 'All' ||
          ticket.department == selectedDepartment.value;

      // Priority filter
      final matchesPriority = selectedPriority.value == 'All' ||
          ticket.priority == selectedPriority.value;

      return matchesSearch && matchesStatus && matchesDepartment && matchesPriority;
    }).toList();
  }

  // Get counts for statistics
  int get openTicketsCount => tickets.where((t) => t.status == 'Open').length;
  int get inProgressTicketsCount => tickets.where((t) => t.status == 'In Progress').length;
  int get resolvedTicketsCount => tickets.where((t) => t.status == 'Resolved').length;
  int get closedTicketsCount => tickets.where((t) => t.status == 'Closed').length;
  int get totalTicketsCount => tickets.length;
}