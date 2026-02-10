import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/app_bar/custom_app_bar.dart';
import '../controller/attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({super.key});

  final AttendanceController controller = Get.put(AttendanceController());
  final ScrollController _horizontalScrollController = ScrollController();
  final ValueNotifier<bool> _isScrollingNotifier = ValueNotifier<bool>(false);
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  _buildSearchSection(),
                  SizedBox(height: 24.h),
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
        // Month Dropdown
        Container(
          height: 45.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.colors.black.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: InkWell(
            onTap: () {
              controller.pickDateRange(context);
            },
            borderRadius: BorderRadius.circular(8.r),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Obx(() => Text(
                    controller.selectedDateText.value.isEmpty
                        ? DateFormat('MMMM yyyy').format(DateTime.now())
                        : controller.selectedDateText.value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )),
                ),
                SizedBox(width: 8.w),
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Icon(
                      Icons.calendar_today,
                      size: 20.w,
                      color: AppTheme.colors.black.withOpacity(0.5)
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Apply Button
        Container(
          height: 45.h,
          child: ElevatedButton(
            onPressed: () {
              // Handle apply button press
              if (controller.selectedDateRange.value != null) {
                print('Applying filter for month: ${controller.selectedDateText.value}');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
            ),
            child: Text(
              'Apply',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.colors.white,
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
                Text(
                  "2",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    // color: AppTheme.colors.success,
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
                Text(
                  "29",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    // color: AppTheme.colors.info,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollStartNotification ||
                      notification is ScrollUpdateNotification) {
                    _isScrollingNotifier.value = true;
                  } else if (notification is ScrollEndNotification) {
                    Future.delayed(Duration(milliseconds: 500), () {
                      _isScrollingNotifier.value = false;
                    });
                  }
                  return false;
                },
                child: Obx(() {
                  return SingleChildScrollView(
                    controller: _horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Table Header
                        Container(
                          width: _calculateTotalWidth(),
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: AppTheme.colors.gray,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              topRight: Radius.circular(8.r),
                            ),
                          ),
                          child: Row(
                            children: [
                              _buildHeaderCell("Employee", 120.w),
                              _buildHeaderCell("Date", 100.w),
                              _buildHeaderCell("Day", 80.w),
                              _buildHeaderCell("Status", 100.w),
                              _buildHeaderCell("Status Code", 100.w),
                              _buildHeaderCell("Add Ticket", 100.w),
                              _buildHeaderCell("Punching Time", 100.w),
                              _buildHeaderCell("Hubstuff Time", 100.w),
                              _buildHeaderCell("Leave Record", 100.w),
                              _buildHeaderCell("Punch Records", 100.w),
                              _buildHeaderCell("Clock In", 100.w),
                              _buildHeaderCell("Clock Out", 100.w),
                              _buildHeaderCell("Late", 80.w),
                              _buildHeaderCell("Early Leaving", 100.w),
                              _buildHeaderCell("Overtime", 80.w),
                              _buildHeaderCell("Updated By", 120.w),
                              _buildHeaderCell("Update At", 120.w),
                            ],
                          ),
                        ),

                        // Table Body
                        Column(
                          children: controller.attendanceRecords
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final record = entry.value;

                            return Container(
                              width: _calculateTotalWidth(),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: index ==
                                      controller.attendanceRecords.length - 1
                                      ? BorderSide.none
                                      : BorderSide(
                                    color: AppTheme.colors.gray,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  _buildDataCell(record.employee, 120.w),
                                  _buildDataCell(record.date, 100.w),
                                  _buildDataCell(record.day, 80.w),
                                  _buildStatusCell(record.status, 100.w),
                                  _buildDataCell(record.statusCode, 100.w),
                                  _buildAddTicketCell(record.hasTicket, record.date, 100.w),
                                  _buildDataCell(record.punchingTime, 100.w),
                                  _buildDataCell(record.hubstuffTime, 100.w),
                                  _buildDataCell(record.leaveRecord, 100.w),
                                  _buildDataCell(record.punchRecords, 100.w),
                                  _buildDataCell(record.clockIn, 100.w),
                                  _buildDataCell(record.clockOut, 100.w),
                                  _buildDataCell(record.late, 80.w),
                                  _buildDataCell(record.earlyLeaving, 100.w),
                                  _buildDataCell(record.overtime, 80.w),
                                  _buildDataCell(record.updatedBy, 120.w),
                                  _buildDataCell(record.updateAt, 120.w),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              // Scroll Indicator
              Container(
                height: 6.h,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final totalWidth = _calculateTotalWidth();
                    final visibleWidth = MediaQuery.of(context).size.width - 32.w;

                    if (totalWidth <= visibleWidth) {
                      return SizedBox.shrink();
                    }

                    return ValueListenableBuilder<bool>(
                      valueListenable: _isScrollingNotifier,
                      builder: (context, isScrolling, child) {
                        return AnimatedOpacity(
                          opacity: isScrolling ? 1.0 : 0.7,
                          duration: Duration(milliseconds: 300),
                          child: Container(
                            width: constraints.maxWidth,
                            child: Stack(
                              children: [
                                // Background track
                                Container(
                                  width: constraints.maxWidth,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(1.5.r),
                                  ),
                                ),

                                // Blue scroll thumb
                                AnimatedBuilder(
                                  animation: _horizontalScrollController,
                                  builder: (context, child) {
                                    final scrollOffset =
                                    _horizontalScrollController.hasClients
                                        ? _horizontalScrollController.offset
                                        : 0.0;
                                    final maxScrollExtent =
                                    _horizontalScrollController.hasClients
                                        ? _horizontalScrollController
                                        .position.maxScrollExtent
                                        : 1.0;

                                    final thumbWidth =
                                        (visibleWidth / totalWidth) * constraints.maxWidth;
                                    final thumbPosition = maxScrollExtent > 0
                                        ? (scrollOffset / maxScrollExtent) *
                                        (constraints.maxWidth - thumbWidth)
                                        : 0.0;

                                    return Positioned(
                                      left: thumbPosition
                                          .clamp(0.0, constraints.maxWidth - thumbWidth),
                                      child: Container(
                                        width: thumbWidth,
                                        height: 4.h,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(2.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blue.withOpacity(0.3),
                                              blurRadius: 2,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildStatusCell(String status, double width) {
    final Color bgColor;
    final Color textColor;

    switch (status.toLowerCase()) {
      case 'present':
        bgColor = Colors.green;
        // textColor = Color(0xFF16A34A);
        break;
      case 'absent':
        bgColor = Colors.red;
        // textColor = Color(0xFFDC2626);
        break;
      default:
        bgColor = Colors.grey[200]!;
        textColor = Colors.grey[800]!;
    }

    return SizedBox(
      width: width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAddTicketCell(bool hasTicket, String date, double width) {
    return SizedBox(
      width: width,
      child: Center(
        child: GestureDetector(
          // ✅ Disable click if ticket already added
          onTap: hasTicket ? null : () => controller.onAddTicketPressed(date),
          child: Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              // ✅ Green if ticket exists
              color: hasTicket
                  ? Colors.green
                  : AppTheme.colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                // Optional: change icon too
                hasTicket ? Icons.check : Icons.add,
                size: 16.w,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _calculateTotalWidth() {
    return 120.w + // Employee
        100.w + // Date
        80.w + // Day
        100.w + // Status
        100.w + // Status Code
        100.w + // Add Ticket
        100.w + // Punching Time
        100.w + // Hubstuff Time
        100.w + // Leave Record
        100.w + // Punch Records
        100.w + // Clock In
        100.w + // Clock Out
        80.w + // Late
        100.w + // Early Leaving
        80.w + // Overtime
        120.w + // Updated By
        120.w + // Update At
        (16.w * 2);
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Text: "1 of 13 Pages"
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            "1 of 13 Pages",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        // Right side: Page selector and arrows
        Row(
          children: [
            // "Page" text
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Text(
                "Page",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(width: 8.w),

            // Page number dropdown/input
            Container(
              width: 45.w,
              height: 35.h,
              padding: EdgeInsets.only(left: 8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: AppTheme.colors.black.withOpacity(0.2),
                  width: 1.w,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: "1",
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 20.w,
                  ),
                  isExpanded: true,
                  items: List.generate(13, (index) => (index + 1).toString())
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Handle page change
                  },
                ),
              ),
            ),
            SizedBox(width: 16.w),

            // Back arrow
            GestureDetector(
              onTap: () {
                // Handle previous page
              },
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AppTheme.colors.black.withOpacity(0.2),
                    width: 1.w,
                  ),
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 20.w,
                ),
              ),
            ),
            SizedBox(width: 8.w),

            // Forward arrow
            GestureDetector(
              onTap: () {
                // Handle next page
              },
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AppTheme.colors.black.withOpacity(0.2),
                    width: 1.w,
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  size: 20.w,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}