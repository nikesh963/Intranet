// features/tickets/presentation/screens/manage_tickets_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/app_bar/custom_app_bar.dart';
import '../../model/manage_ticket_model.dart';
import '../controller/manage_ticket_controller.dart';

class ManageTicketsScreen extends StatelessWidget {
  ManageTicketsScreen({super.key});

  final ManageTicketsController controller = Get.put(ManageTicketsController());
  final ScrollController _horizontalScrollController = ScrollController();
  final ValueNotifier<bool> _isScrollingNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppTheme.colors.white,
        appBar: DBAppBar(title: "Manage Tickets", isLeadingWidget: false),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Section
                  _buildSearchSection(),
                  SizedBox(height: 24.h),
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
              hintText: "Search tickets...",
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // "Page" text
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Text(
                "Page",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
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
              icon: Icon(Icons.arrow_drop_down, size: 20.w),
              isExpanded: true,
              items: List.generate(10, (index) => (index + 1).toString()).map((
                String value,
              ) {
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
          ],
        ),
        ElevatedButton.icon(
          onPressed: controller.onCreateTicketPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          icon: Icon(Icons.add, size: 20.w, color: Colors.white),
          label: Text(
            'Create Ticket',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTicketsTable() {
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
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.colors.gray,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              topRight: Radius.circular(8.r),
                            ),
                          ),
                          child: Row(
                            children: [
                              _buildHeaderCell("Action", 80.w),
                              _buildHeaderCell("Employee", 120.w),
                              _buildHeaderCell("Date", 100.w),
                              _buildHeaderCell("Ticket Code", 120.w),
                              _buildHeaderCell("Status", 100.w),
                              _buildHeaderCell("Title", 150.w),
                              _buildHeaderCell("Description", 200.w),
                              _buildHeaderCell("RO", 100.w),
                              _buildHeaderCell("New", 80.w),
                              _buildHeaderCell("Department", 150.w),
                              _buildHeaderCell("Priority", 100.w),
                              _buildHeaderCell("Created By", 120.w),
                              _buildHeaderCell("Created At", 120.w),
                            ],
                          ),
                        ),

                        // Table Body
                        Column(
                          children: controller.filteredTickets
                              .asMap()
                              .entries
                              .map((entry) {
                                final index = entry.key;
                                final ticket = entry.value;

                                return Container(
                                  width: _calculateTotalWidth(),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12.h,
                                    horizontal: 16.w,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          index ==
                                              controller
                                                      .filteredTickets
                                                      .length -
                                                  1
                                          ? BorderSide.none
                                          : BorderSide(
                                              color: AppTheme.colors.gray,
                                              width: 1,
                                            ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      _buildActionCell(ticket, 80.w),
                                      _buildDataCell(ticket.employee, 120.w),
                                      _buildDataCell(ticket.date, 100.w),
                                      _buildDataCell(ticket.ticketCode, 120.w),
                                      _buildStatusCell(
                                        ticket.status,
                                        ticket.getStatusColor(),
                                        100.w,
                                      ),
                                      _buildDataCell(ticket.title, 150.w),
                                      _buildDataCell(ticket.description, 200.w),
                                      _buildDataCell(ticket.ro, 100.w),
                                      _buildDataCell(ticket.newStatus, 80.w),
                                      _buildDataCell(ticket.department, 150.w),
                                      _buildPriorityCell(
                                        ticket.priority,
                                        ticket.getPriorityColor(),
                                        100.w,
                                      ),
                                      _buildDataCell(ticket.createdBy, 120.w),
                                      _buildDataCell(ticket.createdAt, 120.w),
                                    ],
                                  ),
                                );
                              })
                              .toList(),
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
                    final visibleWidth =
                        MediaQuery.of(context).size.width - 32.w;

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
                                              .position
                                              .maxScrollExtent
                                        : 1.0;

                                    final thumbWidth =
                                        (visibleWidth / totalWidth) *
                                        constraints.maxWidth;
                                    final thumbPosition = maxScrollExtent > 0
                                        ? (scrollOffset / maxScrollExtent) *
                                              (constraints.maxWidth -
                                                  thumbWidth)
                                        : 0.0;

                                    return Positioned(
                                      left: thumbPosition.clamp(
                                        0.0,
                                        constraints.maxWidth - thumbWidth,
                                      ),
                                      child: Container(
                                        width: thumbWidth,
                                        height: 4.h,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                            2.r,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blue.withOpacity(
                                                0.3,
                                              ),
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
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
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
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget _buildStatusCell(String status, Color color, double width) {
    return SizedBox(
      width: width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: color,
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

  Widget _buildPriorityCell(String priority, Color color, double width) {
    return SizedBox(
      width: width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          // color: color,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          priority,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            // color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildActionCell(ManageTicketModel ticket, double width) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // View Button
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              onPressed: () => controller.onViewTicket(ticket),
              icon: Icon(
                Icons.shortcut_rounded,
                size: 18.w,
                color: Colors.white,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotalWidth() {
    return 80.w + // Action
        120.w + // Employee
        100.w + // Date
        120.w + // Ticket Code
        100.w + // Status
        150.w + // Title
        200.w + // Description
        100.w + // RO
        80.w + // New
        150.w + // Department
        100.w + // Priority
        120.w + // Created By
        120.w + // Created At
        (16.w * 2); // Padding
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
          child: Obx(
            () => Text(
              "1 of ${(controller.filteredTickets.length / 10).ceil()} Pages",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
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
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
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
                  icon: Icon(Icons.arrow_drop_down, size: 20.w),
                  isExpanded: true,
                  items: List.generate(10, (index) => (index + 1).toString())
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
                      })
                      .toList(),
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
                child: Icon(Icons.arrow_back, size: 20.w),
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
                child: Icon(Icons.arrow_forward, size: 20.w),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
