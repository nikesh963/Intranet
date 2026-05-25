// features/tickets/presentation/controller/manage_ticket_controller.dart

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Common/CommonSnackBar.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../../../core/routes/app_pages.dart';
import '../../model/manage_ticket_model.dart';
import '../widget/create_ticket_dialog.dart';


class ManageTicketsController extends GetxController {

  final ApiHelper _apiHelper = ApiHelper();

  RxList<Ticket> tickets = <Ticket>[].obs;

  RxBool isLoading = false.obs;
  RxInt currentPage = 1.obs;
  RxInt lastPage = 1.obs;
  RxInt totalItems = 0.obs;
  RxInt perPage = 10.obs;
  final TextEditingController searchController =
  TextEditingController();

  RxString selectedStatus = "All".obs;

  @override
  void onInit() {
    super.onInit();
    getTickets();
  }

  /// ================= GET TICKETS =================

  // Future<void> getTickets() async {
  //
  //   try {
  //
  //     isLoading.value = true;
  //
  //     final response =
  //     await _apiHelper.get("/mobile/ticket");
  //
  //     final ticketsResponse =
  //     Tickets.fromJson(response.data);
  //
  //     tickets.value =
  //         ticketsResponse.data?.tickets ?? [];
  //
  //   } catch (e) {
  //
  //     debugPrint("GET TICKETS ERROR : $e");
  //
  //     Get.snackbar(
  //       "Error",
  //       "Failed to load tickets",
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //
  //   } finally {
  //
  //     isLoading.value = false;
  //   }
  // }
  Future<void> getTickets({int page = 1}) async {

    try {

      isLoading.value = true;

      final response =
      await _apiHelper.get("/mobile/ticket?page=$page");

      final ticketsResponse =
      Tickets.fromJson(response.data);

      tickets.value =
          ticketsResponse.data?.tickets ?? [];

      /// PAGINATION
      currentPage.value =
          ticketsResponse.data?.pagination?.currentPage ?? 1;

      lastPage.value =
          ticketsResponse.data?.pagination?.lastPage ?? 1;

      totalItems.value =
          ticketsResponse.data?.pagination?.total ?? 0;

      perPage.value =
          ticketsResponse.data?.pagination?.perPage ?? 10;

    } catch (e) {

      debugPrint("GET TICKETS ERROR : $e");

      Get.snackbar(
        "Error",
        "Failed to load tickets",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

    } finally {

      isLoading.value = false;
    }
  }
  /// NEXT PAGE
  void nextPage() {

    if (currentPage.value < lastPage.value) {

      getTickets(
        page: currentPage.value + 1,
      );
    }
  }

  /// PREVIOUS PAGE
  void previousPage() {

    if (currentPage.value > 1) {

      getTickets(
        page: currentPage.value - 1,
      );
    }
  }

  /// CHANGE PAGE
  void changePage(int page) {

    getTickets(page: page);
  }

  /// HAS NEXT PAGE
  bool get hasNextPage {

    return currentPage.value < lastPage.value;
  }

  /// HAS PREVIOUS PAGE
  bool get hasPreviousPage {

    return currentPage.value > 1;
  }
  /// ================= FILTERED TICKETS =================

  List<Ticket> get filteredTickets {

    final search =
    searchController.text.toLowerCase();

    return tickets.where((ticket) {

      final matchesSearch =

          search.isEmpty ||

              (ticket.employeeName ?? "")
                  .toLowerCase()
                  .contains(search) ||

              (ticket.ticketCode ?? "")
                  .toLowerCase()
                  .contains(search) ||

              (ticket.title ?? "")
                  .toLowerCase()
                  .contains(search);

      final matchesStatus =

          selectedStatus.value == "All" ||

              (ticket.status ?? "")
                  .toLowerCase() ==
                  selectedStatus.value.toLowerCase();

      return matchesSearch &&
          matchesStatus;

    }).toList();
  }

  /// ================= STATUS COLOR =================

  Color getStatusColor(String? status) {

    switch (status?.toLowerCase()) {

      case "open":
        return Colors.orange;

      case "closed":
        return Colors.green;

      case "pending":
        return Colors.blue;

      case "rejected":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  /// ================= PRIORITY COLOR =================

  Color getPriorityColor(String? priority) {

    switch (priority?.toLowerCase()) {

      case "high":
        return Colors.red;

      case "medium":
        return Colors.orange;

      case "low":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  /// ================= ACTIONS =================

  // void onViewTicket(Ticket ticket) {
  //
  //   Get.snackbar(
  //     "Ticket",
  //     ticket.ticketCode ?? "",
  //     backgroundColor: Colors.green,
  //     colorText: Colors.white,
  //   );
  // }
  void onViewTicket(Ticket ticket) {

    if (ticket.id == null) {

      SnackBarService.showErrorSnackBar(
        "Ticket ID not found",
      );

      return;
    }

    Get.toNamed(
      AppRoutes.reply,
      arguments: ticket.id!,
    );
  }
  void onCreateTicketPressed() {
    Get.dialog(
      CreateTicketDialog(),
      barrierDismissible: true,
    );
  }

  /// ================= CREATE TICKET =================

  Future<bool> createTicket({
    required String title,
    required String priority,
    required String description,
    required String department,
    List<PlatformFile>? files,
  }) async {

    try {

      isLoading.value = true;

      dio.FormData formData = dio.FormData.fromMap({

        "title": title,
        "priority": priority,
        "description": description,
        "ticket_department": department,
      });

      /// MULTIPLE FILES
      if (files != null && files.isNotEmpty) {

        for (var file in files) {

          if (file.path != null) {

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
        }
      }

      final response = await _apiHelper.postFormData(
        "/mobile/ticket-store",
        formData,
      );

      debugPrint(
        "CREATE TICKET RESPONSE : ${response.data}",
      );

      /// CLOSE DIALOG FIRST
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

      /// REFRESH LIST
      await getTickets(
        page: currentPage.value,
      );

      return true;

    } catch (e) {

      debugPrint("CREATE TICKET ERROR : $e");

      /// DON'T CLOSE DIALOG
      SnackBarService.showErrorSnackBar(
        "Failed to create ticket",
      );

      return false;

    } finally {

      isLoading.value = false;
    }
  }
}