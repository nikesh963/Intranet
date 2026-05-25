import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Common/CommonSnackBar.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/app_bar/custom_app_bar.dart';
import '../controller/attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({super.key});

  final AttendanceController controller = Get.put(AttendanceController());
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.  fetchAttendance(page: 1);
    });
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppTheme.colors.white,
        appBar: DBAppBar(
        title: "Attendance List",
        isLeadingWidget: false,
      ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // _buildSearchSection(),
                  // SizedBox(height: 24.h),
                  // Search Section
                  _buildDateSection(context),
                  SizedBox(height: 24.h),

                  // Total Absent/Present Section
                  _buildStatsSection(),
                  SizedBox(height: 24.h),

                  // Attendance Table
                  _buildAttendanceTable(),
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
            controller: _searchController,
            onChanged: (value) {
              // trigger rebuild if needed
            },
            style: TextStyle(fontSize: 16.sp, color: Colors.black),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),

              suffixIcon: IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  _searchController.clear();
                },
              ),

              // ✅ BORDER
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
                borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.2),
              ),

              isDense: true,
              contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSection(BuildContext context) {
    return Row(
      children: [

        /// Month Year Picker
        Expanded(
          child: Container(
            height: 45.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.colors.black.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: InkWell(
              onTap: () {
                controller.pickMonthYear(context);
              },
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Obx(
                            () => Text(
                          controller.selectedMonthYear.value,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    Icon(
                      Icons.calendar_month,
                      size: 20.w,
                      color: AppTheme.colors.black
                          .withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 12.w),

        /// Apply Button
        SizedBox(
          height: 45.h,
          width: 120.w,
          child: ElevatedButton(
            onPressed: () {
              controller.fetchAttendance(page: 1);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              "Apply",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildStatsSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  "Total Absent",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    // color: AppTheme.colors.textSecondary,
                  ),
                ),
                SizedBox(width: 8.w),
                Obx(
                      () => Text(
                    controller.totalAbsent.value.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Present",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    // color: AppTheme.colors.textSecondary,
                  ),
                ),
                SizedBox(width: 8.w),
                Obx(
                      () => Text(
                    controller.totalPresent.value.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildAttendanceTable() {

    return Obx(() {

      if (controller.isLoading.value) {
        // return const Center(
        //   child: CircularProgressIndicator(),
        // );
        return _buildAttendanceShimmer();
      }

      if (controller.attendanceRecords.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Text(
              "No attendance found",
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount:
        controller.attendanceRecords.length,

        separatorBuilder: (_, __) =>
            SizedBox(height: 12.h),

        itemBuilder: (context, index) {

          final record =
          controller.attendanceRecords[index];

          final isPresent =
              (record.status?.name ?? "")
                  .toLowerCase() ==
                  "present";

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(12.r),
              border: Border.all(
                color:
                Colors.black.withOpacity(0.08),
              ),
            ),

            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),

              child: ExpansionTile(

                tilePadding:
                EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 6.h,
                ),

                childrenPadding:
                EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),

                expandedCrossAxisAlignment:
                CrossAxisAlignment.start,

                leading: CircleAvatar(
                  radius: 18.r,
                  backgroundColor:
                  AppTheme.colors.blue
                      .withOpacity(0.1),

                  child: Text(
                    record.employeeName
                        ?.toString()
                        .split('.')
                        .last[0] ??
                        "U",
                    style: TextStyle(
                      color:
                      AppTheme.colors.blue,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

                title: Text(
                  record.employeeName
                      ?.toString()
                      .split('.')
                      .last
                      .replaceAll('_', ' ') ??
                      "-",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                subtitle: Padding(
                  padding:
                  EdgeInsets.only(top: 4.h),

                  child: Text(
                    controller.formatDate(
                        record.date),

                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),

                trailing: Row(
                  mainAxisSize:
                  MainAxisSize.min,

                  children: [

                    Container(
                      padding:
                      EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),

                      decoration: BoxDecoration(
                        color: isPresent
                            ? Colors.green
                            : Colors.red,

                        borderRadius:
                        BorderRadius.circular(
                            20.r),
                      ),

                      child: Text(
                        record.status?.name ??
                            "-",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),

                    (record.ticketStatus?.toLowerCase() == "close")
                        ? Container(
                      width: 50.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          "Close",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )

                        : (record.ticket == "1")
                        ? GestureDetector(
                      onTap: () {

                        if (record.ticketId != null) {

                          Get.toNamed(
                            AppRoutes.reply,
                            arguments: record.ticketId!,
                            // arguments: {
                            //   "ticket_id": record.ticketId
                            //   // "attendance_id": record.id,
                            //   // "attendance_status":
                            //   // record.status?.name ?? "",
                            // },
                          );

                        } else {

                          SnackBarService.showErrorSnackBar(
                            "Ticket ID not found",
                          );
                        }
                      },
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.green,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppIcons.ACTION,
                            width: 16.w,
                            height: 16.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )

                        : GestureDetector(
                      // onTap: () => controller.onAddTicketPressed(
                      //   controller.formatDate(record.date),
                      // ),
                      onTap: () => controller.onAddTicketPressed(record),
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.blue,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18.w,
                        ),
                      ),
                    ),
                  ],
                ),

                children: [

                  _buildDetailRow(
                      "Day",
                      record.day ?? "-"),

                  _buildDetailRow(
                      "Status Code",
                      record.statusCode?.name ??
                          "-"),

                  _buildDetailRow(
                      "Punching Time",
                      record.duration
                          ?.toString() ??
                          "-"),

                  _buildDetailRow(
                      "Hubstaff Time",
                      record.hubstuffDuration
                          ?.toString() ??
                          "-"),

                  _buildDetailRow(
                      "Punch Records",
                      record.punchRecords
                          ?.toString() ??
                          "-"),

                  _buildDetailRow(
                      "Clock In",
                      record.clockIn ?? "-"),

                  _buildDetailRow(
                      "Clock Out",
                      record.clockOut ?? "-"),

                  _buildDetailRow(
                      "Late",
                      record.late ?? "-"),

                  _buildDetailRow(
                      "Early Leaving",
                      record.earlyLeaving ??
                          "-"),

                  _buildDetailRow(
                      "Overtime",
                      record.overtime ?? "-"),

                  _buildDetailRow(
                      "Updated At",
                      controller
                          .formatDateTime(
                          record.updatedAt)),
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
  Widget _buildPagination() {

    return Obx(() {

      final current = controller.currentPage.value;
      final last = controller.lastPage.value;

      final bool hasNext = current < last;
      final bool hasPrevious = current > 1;

      return Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          /// PAGE INFO
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(8.r),
            ),

            child: Text(
              "$current of $last Pages",

              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          /// RIGHT SIDE
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

                onSelected: (String value) {

                  controller.fetchAttendance(
                    page: int.parse(value),
                  );
                },

                itemBuilder: (BuildContext context) {

                  return List.generate(
                    last,
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

                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(8.r),

                    border: Border.all(
                      color: AppTheme.colors.black
                          .withOpacity(0.2),
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      Text(
                        current.toString(),

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
                    ? () {

                  controller.fetchAttendance(
                    page: current - 1,
                  );

                }
                    : null,

                child: Container(

                  padding: EdgeInsets.all(8.w),

                  decoration: BoxDecoration(

                    color: hasPrevious
                        ? AppTheme.colors.blue
                        : Colors.grey.shade300,

                    borderRadius:
                    BorderRadius.circular(8.r),

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
                    ? () {

                  controller.fetchAttendance(
                    page: current + 1,
                  );

                }
                    : null,

                child: Container(

                  padding: EdgeInsets.all(8.w),

                  decoration: BoxDecoration(

                    color: hasNext
                        ? AppTheme.colors.blue
                        : Colors.grey.shade300,

                    borderRadius:
                    BorderRadius.circular(8.r),

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
  Widget _buildAttendanceShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [

          /// Stats Cards
          Row(
            children: [

              Expanded(
                child: Container(
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Container(
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          /// Attendance List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),

            itemBuilder: (context, index) {

              return Container(
                padding: EdgeInsets.all(16.w),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),

                child: Row(
                  children: [

                    /// Avatar
                    Container(
                      width: 40.w,
                      height: 40.w,

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),

                    SizedBox(width: 12.w),

                    /// Name + Date
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Container(
                            width: 140.w,
                            height: 12.h,
                            color: Colors.white,
                          ),

                          SizedBox(height: 8.h),

                          Container(
                            width: 90.w,
                            height: 10.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                    /// Status
                    Container(
                      width: 70.w,
                      height: 28.h,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(20.r),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}