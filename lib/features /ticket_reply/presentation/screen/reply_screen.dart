/// ===============================================
/// CREATE NEW SCREEN
/// features/tickets/presentation/screens/ticket_reply_screen.dart
/// ===============================================

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/app_bar/custom_app_bar.dart';
import '../controller/reply_controller.dart';


class TicketReplyScreen extends StatelessWidget {
  final int ticketId;

  const TicketReplyScreen({
    super.key,
    required this.ticketId,
  });

  @override
  Widget build(BuildContext context) {
    final TicketReplyController controller =
    Get.put(TicketReplyController(ticketId));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DBAppBar(
        isLeadingWidget: false,
        title: "Ticket Reply",
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final ticket = controller.ticket.value;

        if (ticket == null) {
          return const Center(
            child: Text("No Data Found"),
          );
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    /// ================= TICKET CARD =================
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ticket.department ?? "-",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          SizedBox(height: 18.h),

                          _buildRow(
                            "Title",
                            ticket.title ?? "-",
                          ),

                          _buildRow(
                            "Department",
                            ticket.ticketDepartment ?? "-",
                          ),

                          _buildRow(
                            "Status",
                            ticket.status ?? "-",
                          ),

                          _buildRow(
                            "Description",
                            ticket.description ?? "-",
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    /// ================= REPLIES =================
                    ListView.separated(
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemCount: controller.replies.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        final reply =
                        controller.replies[index];

                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    reply.createdByName ??
                                        "-",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight:
                                      FontWeight.w700,
                                    ),
                                  ),

                                  Text(
                                    reply.createdAt == null
                                        ? "-"
                                        : DateFormat(
                                      "yyyy-MM-dd HH:mm:ss",
                                    ).format(
                                      reply.createdAt!,
                                    ),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 14.h),

                              Text(
                                reply.description ?? "-",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// ================= ADD REPLY =================

            Container(
              padding: EdgeInsets.all(16.w),

              decoration: BoxDecoration(

                color: Colors.white,

                border: Border(
                  top: BorderSide(
                    color: Colors.black12,
                  ),
                ),
              ),

              child: Column(

                children: [

                  /// TEXTFIELD
                  TextField(

                    controller:
                    controller.replyController,

                    minLines: 3,
                    maxLines: 6,

                    decoration: InputDecoration(

                      hintText: "Write your reply...",

                      filled: true,

                      fillColor: Colors.grey.shade50,

                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14.r),
                      ),

                      enabledBorder:
                      OutlineInputBorder(

                        borderRadius:
                        BorderRadius.circular(14.r),

                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),

                      focusedBorder:
                      OutlineInputBorder(

                        borderRadius:
                        BorderRadius.circular(14.r),

                        borderSide: BorderSide(
                          color: AppTheme.colors.blue,
                        ),
                      ),
                    ),
                  ),

                  // SizedBox(height: 14.h),
                  //
                  // /// STATUS ROW
                  // Row(
                  //   children: [
                  //
                  //     /// STATUS
                  //     Expanded(
                  //       child: Obx(() {
                  //
                  //         return DropdownButtonFormField<String>(
                  //
                  //           value:
                  //           controller.selectedStatus.value,
                  //
                  //           decoration: InputDecoration(
                  //
                  //             labelText: "Status",
                  //
                  //             border: OutlineInputBorder(
                  //               borderRadius:
                  //               BorderRadius.circular(12.r),
                  //             ),
                  //           ),
                  //
                  //           items: [
                  //
                  //             "open",
                  //             "closed",
                  //             "pending",
                  //             "rejected",
                  //
                  //           ].map((e) {
                  //
                  //             return DropdownMenuItem(
                  //
                  //               value: e,
                  //
                  //               child: Text(e),
                  //             );
                  //           }).toList(),
                  //
                  //           onChanged: (value) {
                  //
                  //             controller.selectedStatus.value =
                  //                 value ?? "open";
                  //           },
                  //         );
                  //       }),
                  //     ),
                  //
                  //     SizedBox(width: 12.w),
                  //
                  //     /// ATTENDANCE STATUS
                  //     if (ticket.ticketDepartment
                  //         ?.toLowerCase() ==
                  //         "attendance")
                  //       Expanded(
                  //         child: Obx(() {
                  //
                  //           return DropdownButtonFormField<String>(
                  //
                  //             value: controller
                  //                 .selectedAttendanceStatus
                  //                 .value,
                  //
                  //             decoration: InputDecoration(
                  //
                  //               labelText:
                  //               "Attendance Status",
                  //
                  //               border:
                  //               OutlineInputBorder(
                  //                 borderRadius:
                  //                 BorderRadius.circular(
                  //                   12.r,
                  //                 ),
                  //               ),
                  //             ),
                  //
                  //             items: [
                  //
                  //               "Present",
                  //               "HalfDay",
                  //               "Absent",
                  //
                  //             ].map((e) {
                  //
                  //               return DropdownMenuItem(
                  //
                  //                 value: e,
                  //
                  //                 child: Text(e),
                  //               );
                  //             }).toList(),
                  //
                  //             onChanged: (value) {
                  //
                  //               controller
                  //                   .selectedAttendanceStatus
                  //                   .value =
                  //                   value ?? "Present";
                  //             },
                  //           );
                  //         }),
                  //       ),
                  //   ],
                  // ),

                  SizedBox(height: 14.h),

                  /// FILE PICKER
                  Row(
                    children: [

                      GestureDetector(

                        onTap: controller.pickFiles,

                        child: Container(

                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 12.h,
                          ),

                          decoration: BoxDecoration(

                            color: AppTheme.colors.blue,

                            borderRadius:
                            BorderRadius.circular(12.r),
                          ),

                          child: Row(
                            children: [

                              Icon(
                                Icons.attach_file,
                                color: Colors.white,
                                size: 18.w,
                              ),

                              SizedBox(width: 6.w),

                              Text(
                                "Upload File",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 12.w),

                      Expanded(
                        child: Obx(() {

                          if (controller
                              .selectedFiles.isEmpty) {

                            return Text(
                              "No file selected",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.sp,
                              ),
                            );
                          }

                          return SizedBox(

                            height: 40.h,

                            child: ListView.separated(

                              scrollDirection:
                              Axis.horizontal,

                              itemCount: controller
                                  .selectedFiles.length,

                              separatorBuilder:
                                  (_, __) =>
                                  SizedBox(width: 8.w),

                              itemBuilder: (context, index) {

                                final file = controller
                                    .selectedFiles[index];

                                return Container(

                                  padding:
                                  EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 6.h,
                                  ),

                                  decoration: BoxDecoration(

                                    color: Colors.blue
                                        .withOpacity(0.1),

                                    borderRadius:
                                    BorderRadius.circular(
                                      20.r,
                                    ),
                                  ),

                                  child: Row(
                                    children: [

                                      Text(
                                        file.name,

                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),

                                      SizedBox(width: 6.w),

                                      GestureDetector(

                                        onTap: () {

                                          controller
                                              .removeFile(
                                            index,
                                          );
                                        },

                                        child: Icon(
                                          Icons.close,
                                          size: 16.w,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  /// SEND BUTTON
                  SizedBox(

                    width: double.infinity,

                    height: 50.h,

                    child: Obx(() {

                      return ElevatedButton.icon(

                        onPressed:
                        controller.isReplyLoading.value
                            ? null
                            : controller.sendReply,

                        style: ElevatedButton.styleFrom(

                          backgroundColor:
                          AppTheme.colors.blue,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12.r),
                          ),
                        ),

                        icon: controller
                            .isReplyLoading.value
                            ? SizedBox(
                          height: 18.h,
                          width: 18.w,
                          child:
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18.w,
                        ),

                        label: Text(

                          controller.isReplyLoading.value
                              ? "Sending..."
                              : "Send Reply",

                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildRow(
      String title,
      String value,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}