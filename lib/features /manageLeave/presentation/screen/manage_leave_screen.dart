// features/tickets/presentation/screens/manage_tickets_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/app_bar/custom_app_bar.dart';
import '../../model/manage_leave_model.dart';
import '../controller/manage_leave_controller.dart';

class ManageLeaveScreen extends StatelessWidget {
  ManageLeaveScreen({super.key});

  final ManageLeaveController controller = Get.put(ManageLeaveController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.  getLeaves(page: 1);
    });
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppTheme.colors.white,
        appBar: DBAppBar(title: "Manage Leave", isLeadingWidget: false),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Section
                  // _buildSearchSection(),
                  // SizedBox(height: 24.h),
                  // Create Ticket Button
                  _buildCreateTicketButton(),
                  SizedBox(height: 24.h),

                  // Tickets Table
                  _buildTicketsTable(),
                  SizedBox(height: 24.h),

                  // Pagination
                  _buildPagination(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.searchController,
            onChanged: (value) {
              controller.update();
            },
            style: TextStyle(fontSize: 16.sp, color: Colors.black),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  controller.searchController.clear();
                  controller.update();
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                  width: 1.2,
                ),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 10.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateTicketButton() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// PAGE SELECTOR
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h,
                ),
                child: Text(
                  "Page",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              PopupMenuButton<String>(
                color: Colors.white,
                offset: Offset(0, 5.h),

                onSelected: (String newValue) {
                  controller.changePage(
                    int.parse(newValue),
                  );
                },

                itemBuilder: (BuildContext context) {
                  return List.generate(
                    controller.lastPage.value,
                        (index) => (index + 1).toString(),
                  ).map((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      child: Text(value),
                    );
                  }).toList();
                },

                child: Container(
                  width: 55.w,
                  height: 38.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppTheme.colors.black.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        controller.currentPage.value.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Icon(
                        Icons.arrow_drop_down,
                        size: 20.w,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /// CREATE BUTTON
          ElevatedButton.icon(
            onPressed: controller.onCreateTicketPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.colors.blue,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 12.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            icon: Icon(
              Icons.add,
              size: 20.w,
              color: Colors.white,
            ),
            label: Text(
              'Create Leave',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildTicketsTable() {
    return Obx(() {

      if (controller.isLoading.value) {
        // return const Center(
        //   child: CircularProgressIndicator(),
        // );
        return _buildLeaveShimmer();
      }

      if (controller.leaveTickets.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Text(
              "No Leaves Found",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.leaveTickets.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {

          final ticket = controller.leaveTickets[index];

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.black.withOpacity(0.08),
              ),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 6.h,
                ),
                childrenPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
                expandedCrossAxisAlignment:
                CrossAxisAlignment.start,

                leading: CircleAvatar(
                  radius: 18.r,
                  backgroundColor:
                  AppTheme.colors.blue.withOpacity(0.1),
                  child: Text(
                    ticket.employeeName != null &&
                        ticket.employeeName!.isNotEmpty
                        ? ticket.employeeName![0].toUpperCase()
                        : "?",
                    style: TextStyle(
                      color: AppTheme.colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                title: Text(
                  ticket.employeeName ?? "-",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                subtitle: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    ticket.leaveTypeName ?? "-",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),

                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      "${ticket.totalLeaveDays ?? "0"} Days",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          ticket.status ?? "",
                        ),
                        borderRadius:
                        BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        ticket.status ?? "-",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                children: [

                  _buildDetailRow(
                    "Department",
                    ticket.department ?? "-",
                  ),

                  _buildDetailRow(
                    "Branch",
                    ticket.branchName ?? "-",
                  ),

                  _buildDetailRow(
                    "Applied On",
                    controller.formatDate(ticket.appliedOn),
                  ),

                  _buildDetailRow(
                    "Start Date",
                    controller.formatDate(ticket.startDate),
                  ),

                  _buildDetailRow(
                    "End Date",
                    controller.formatDate(ticket.endDate),
                  ),

                  _buildDetailRow(
                    "Created By",
                    ticket.createdByName ?? "-",
                  ),

                  _buildDetailRow(
                    "Reason",
                    ticket.leaveReason ?? "-",
                  ),

                  _buildDetailRow(
                    "Remark",
                    ticket.remark ?? "-",
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: 120.w,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value.isEmpty ? "-" : value,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }


// Helper methods for styling
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }


  Widget _buildPagination() {
    return Obx(() {

      final bool hasNext = controller.hasNextPage;
      final bool hasPrevious = controller.hasPreviousPage;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// PAGE COUNT
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              "${controller.currentPage.value} of ${controller.lastPage.value} Pages",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          /// RIGHT SECTION
          Row(
            children: [

              /// PAGE TEXT
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h,
                ),
                child: Text(
                  "Page",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              /// PAGE POPUP
              PopupMenuButton<String>(
                color: Colors.white,
                offset: Offset(0, 5.h),

                onSelected: (String newValue) {
                  controller.changePage(
                    int.parse(newValue),
                  );
                },

                itemBuilder: (BuildContext context) {
                  return List.generate(
                    controller.lastPage.value,
                        (index) => (index + 1).toString(),
                  ).map((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      child: Text(value),
                    );
                  }).toList();
                },

                child: Container(
                  width: 55.w,
                  height: 38.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppTheme.colors.black.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        controller.currentPage.value.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Icon(
                        Icons.arrow_drop_down,
                        size: 20.w,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 16.w),

              /// PREVIOUS BUTTON
              GestureDetector(
                onTap: hasPrevious
                    ? controller.previousPage
                    : null,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: hasPrevious
                        ? AppTheme.colors.blue
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: hasPrevious
                          ? AppTheme.colors.blue
                          : Colors.grey.shade400,
                      width: 1.w,
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    size: 20.w,
                    color: hasPrevious
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              /// NEXT BUTTON
              GestureDetector(
                onTap: hasNext
                    ? controller.nextPage
                    : null,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: hasNext
                        ? AppTheme.colors.blue
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: hasNext
                          ? AppTheme.colors.blue
                          : Colors.grey.shade400,
                      width: 1.w,
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20.w,
                    color: hasNext
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildLeaveShimmer() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),

      itemBuilder: (context, index) {

        return Shimmer.fromColors(

          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,

          child: Container(

            padding: EdgeInsets.all(14.w),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),

            child: Row(
              children: [

                /// AVATAR
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.white,
                ),

                SizedBox(width: 12.w),

                /// TITLE + SUBTITLE
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Container(
                        height: 14.h,
                        width: 140.w,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(6.r),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Container(
                        height: 12.h,
                        width: 90.w,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(6.r),
                        ),
                      ),
                    ],
                  ),
                ),

                /// RIGHT SIDE
                Column(
                  children: [

                    Container(
                      height: 12.h,
                      width: 50.w,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(6.r),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Container(
                      height: 24.h,
                      width: 70.w,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(20.r),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
