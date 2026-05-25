/// ===============================================
/// UPDATE CONTROLLER
/// features/tickets/presentation/controller/reply_controller.dart
/// ===============================================

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Common/CommonSnackBar.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../model/reply_model.dart';

class TicketReplyController extends GetxController {

  final int ticketId;

  TicketReplyController(this.ticketId);

  final ApiHelper _apiHelper = ApiHelper();

  RxBool isLoading = false.obs;
  RxBool isReplyLoading = false.obs;

  Rx<Ticket?> ticket = Rx<Ticket?>(null);

  RxList<Reply> replies = <Reply>[].obs;

  TextEditingController replyController =
  TextEditingController();

  /// STATUS
  RxString selectedStatus = "open".obs;

  /// ATTENDANCE STATUS
  RxString selectedAttendanceStatus =
      "Present".obs;

  /// FILES
  RxList<PlatformFile> selectedFiles =
      <PlatformFile>[].obs;

  @override
  void onInit() {
    super.onInit();

    getTicketReplies();
  }

  /// ================= GET REPLIES =================

  Future<void> getTicketReplies() async {

    try {

      isLoading.value = true;

      final response = await _apiHelper.get(
        "/mobile/ticket/$ticketId/reply",
      );

      final ticketReply =
      TicketReply.fromJson(response.data);

      ticket.value = ticketReply.data?.ticket;

      replies.value =
          ticketReply.data?.replies ?? [];

    } catch (e) {

      debugPrint("GET REPLY ERROR : $e");

      SnackBarService.showErrorSnackBar(
        "Failed to load replies",
      );

    } finally {

      isLoading.value = false;
    }
  }

  /// ================= PICK FILE =================

  Future<void> pickFiles() async {

    try {

      FilePickerResult? result =
      await FilePicker.platform.pickFiles(
        allowMultiple: true,
      );

      if (result != null &&
          result.files.isNotEmpty) {

        selectedFiles.addAll(result.files);
      }

    } catch (e) {

      debugPrint("FILE PICK ERROR : $e");
    }
  }

  /// ================= REMOVE FILE =================

  void removeFile(int index) {

    selectedFiles.removeAt(index);
  }

  /// ================= SEND REPLY =================

  Future<void> sendReply() async {

    try {

      if (replyController.text.trim().isEmpty) {

        SnackBarService.showErrorSnackBar(
          "Please enter reply",
        );

        return;
      }

      isReplyLoading.value = true;

      final currentTicket = ticket.value;

      dio.FormData formData =
      dio.FormData.fromMap({

        "ticket_id": ticketId,

        "description":
        replyController.text.trim(),

        "status":
        selectedStatus.value,
      });

      /// ATTENDANCE DATA
      if (currentTicket?.ticketDepartment
          ?.toLowerCase() ==
          "attendance") {

        formData.fields.add(
          MapEntry(
            "attendance_id",

            currentTicket?.employeeId
                ?.toString() ??
                "",
          ),
        );

        formData.fields.add(
          MapEntry(
            "attendance_status",
            selectedAttendanceStatus.value,
          ),
        );
      }

      /// FILES
      if (selectedFiles.isNotEmpty) {

        for (var file in selectedFiles) {

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

      final response =
      await _apiHelper.postFormData(

        "/mobile/ticket/changereply",

        formData,
      );

      debugPrint(
        "SEND REPLY RESPONSE : ${response.data}",
      );

      replyController.clear();

      selectedFiles.clear();

      SnackBarService.showSuccessSnackBar(
        response.data["message"] ??
            "Reply sent successfully",
      );

      /// REFRESH
      await getTicketReplies();

    } catch (e) {

      debugPrint("SEND REPLY ERROR : $e");

      SnackBarService.showErrorSnackBar(
        "Failed to send reply",
      );

    } finally {

      isReplyLoading.value = false;
    }
  }
}