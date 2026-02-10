import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../controller/home_controller.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  // final HomeController controller = Get.find<HomeController>();
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with time and welcome
                _buildHeader(context),
                SizedBox(height: 24.h),

              _buildBannerCarousel(),


                SizedBox(height: 16.h),

                Center(
                  child: Obx(() {
                    final challenges = controller.bannerImages;
                    if (challenges.isEmpty) return SizedBox.shrink();
                    return AnimatedSmoothIndicator(
                      activeIndex: controller.currentBannerIndex.value,
                      count: challenges.length,
                      effect: ExpandingDotsEffect(
                        dotWidth: 8.h,
                        dotHeight: 8.h,
                        activeDotColor: AppTheme.colors.black,
                        dotColor: Colors.grey,
                      ),
                    );
                  }
                  ),
                ),
                SizedBox(height: 24.h),
                // Main content
                _buildMainContent(context),
                SizedBox(height: 10.h),
Divider(),
                SizedBox(height: 10.h),
                // Tickets section
                _buildTicketsSection(),
                SizedBox(height: 24.h),

                // Pagination
                _buildPagination(),
                SizedBox(height: 10.h,),
                Divider(),
                // SizedBox(height: 10.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Material(
          borderRadius: BorderRadius.circular(50.r),
          color: Colors.transparent,
          elevation: 0,
          // color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(), // 👈 ripple is circular
            onTap: () async {
              HapticFeedback.selectionClick(); // 👈 small vibration
              await Future.delayed(
                  const Duration(milliseconds: 300)); // 👈 smooth delay
              // Get.toNamed(AppRoutes.profile);
              // dashboardController.updateSelectedTabIndex(3);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: SvgPicture.asset(
                  AppIcons.ATTENDANCE,
                  // controller.userAvatar, // your svg path
                  width: 27.w, // match the diameter
                  height: 27.h,
                  color:
                  AppTheme.colors.black, // Dark theme → your grey
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 4.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            // Welcome message
            Row(
              children: [
                Text(
                  "Hello, ",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    // color: AppTheme.colors.textPrimary,
                  ),
                ),
                Text(
                  "Rahul",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.primary
                    // color: AppTheme.colors.textPrimary,
                  ),
                ),
              ],
            ),
            // SizedBox(height: 8.h),
            Text(
              "Let's find what you need today",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                // color: AppTheme.colors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBannerCarousel() {
    final banners = controller.bannerImages;

    if (banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider.builder(
      itemCount: banners.length,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: false,

        viewportFraction: 1,
        onPageChanged: (index, reason) {
          controller.currentBannerIndex.value = index;

        },
      ),
      itemBuilder: (context, index, realIndex) {
        final imagePath = banners[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.asset(
              imagePath,
              fit: BoxFit.values[1],
              width: double.infinity,
            ),
          ),
        );
      },
    );
  }
  Widget _buildMainContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),

      ),
      child: Column(
        children: [
          // Leave balances
          _buildLeaveBalances(),
          SizedBox(height: 16.h),
          // Tickets summary
          _buildTicketsSummary(),
        ],
      ),
    );
  }
  Widget _buildLeaveBalances() {
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
                  "Total Leave Balance",
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
                  "Total Leaves",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    // color: AppTheme.colors.textSecondary,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "10.5",
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

  Widget _buildTicketsSummary() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              // color: AppTheme.colors.warningLight,
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Current Appraisal\n Period Leaves",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    // color: AppTheme.colors.textSecondary,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "10.5",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    // color: AppTheme.colors.warning,
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
              // color: AppTheme.colors.errorLight,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Total Tickets",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    // color: AppTheme.colors.textSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "19",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    // color: AppTheme.colors.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildTicketsSection() {
    // Create a ScrollController for the horizontal scrolling
    final ScrollController _horizontalScrollController = ScrollController();
    final ValueNotifier<bool> _isScrollingNotifier = ValueNotifier<bool>(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            "Tickets",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.05),
            //     blurRadius: 4,
            //     offset: const Offset(0, 2),
            //   ),
            // ],
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
                              _buildHeaderCell("RO", 80.w),
                              _buildHeaderCell("Leave Type", 100.w),
                              _buildHeaderCell("Applied On", 100.w),
                              _buildHeaderCell("Start Date", 100.w),
                              _buildHeaderCell("End Date", 100.w),
                              _buildHeaderCell("Total Days", 100.w),
                              _buildHeaderCell("Status", 100.w),
                              _buildHeaderCell("Last Updated By", 130.w),
                            ],
                          ),
                        ),

                        // Table Body
                        Column(
                          children: controller.leaveTickets.asMap().entries.map((entry) {
                            final index = entry.key;
                            final ticket = entry.value;

                            return Container(
                              width: _calculateTotalWidth(),
                              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: index == controller.leaveTickets.length - 1
                                      ? BorderSide.none
                                      : BorderSide(
                                    color: AppTheme.colors.gray,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  _buildDataCell(ticket.employee, 120.w),
                                  _buildDataCell(ticket.ro, 80.w),
                                  _buildLeaveTypeCell(ticket.leaveType, 100.w),
                                  _buildDataCell(ticket.appliedOn, 100.w),
                                  _buildDataCell(ticket.startDate, 100.w),
                                  _buildDataCell(ticket.endDate, 100.w),
                                  _buildTotalDaysCell(ticket.totalDays, 100.w),
                                  _buildStatusCell(ticket.status, 100.w),
                                  _buildDataCell(ticket.lastUpdatedBy, 130.w),
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

              // Blue Scroll Indicator at the bottom
              Container(
                height: 6.h,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final totalWidth = _calculateTotalWidth();
                    final visibleWidth = MediaQuery.of(context).size.width - 32.w; // Screen width minus padding

                    // Only show scroll indicator if content is wider than screen
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
                                    final scrollOffset = _horizontalScrollController.hasClients
                                        ? _horizontalScrollController.offset
                                        : 0.0;
                                    final maxScrollExtent = _horizontalScrollController.hasClients
                                        ? _horizontalScrollController.position.maxScrollExtent
                                        : 1.0;

                                    final thumbWidth = (visibleWidth / totalWidth) * constraints.maxWidth;
                                    final thumbPosition = maxScrollExtent > 0
                                        ? (scrollOffset / maxScrollExtent) * (constraints.maxWidth - thumbWidth)
                                        : 0.0;

                                    return Positioned(
                                      left: thumbPosition.clamp(0.0, constraints.maxWidth - thumbWidth),
                                      child: Container(
                                        width: thumbWidth,
                                        height: 4.h,
                                        decoration: BoxDecoration(
                                          color: Colors.blue, // Blue color
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

  Widget _buildLeaveTypeCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTotalDaysCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: _getStatusColor(text),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.colors.white
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  double _calculateTotalWidth() {
    return 120.w + 80.w + 100.w + 100.w + 100.w + 100.w + 100.w + 100.w + 130.w + (16.w * 2);
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
              // color: AppTheme.colors.textSecondary,
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
                  // color: AppTheme.colors.textSecondary,
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
                    // size: 20.w,
                    // color: AppTheme.colors.textSecondary,
                  ),
                  isExpanded: true,
                  items: List.generate(2, (index) => (index + 1).toString())
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
                  // shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.colors.black.withOpacity(0.2),
                    width: 1.w,
                  ),
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 20.w,
                  // color: AppTheme.colors.textSecondary,
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
                  // shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.colors.black.withOpacity(0.2),
                    width: 1.w,
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  size: 20.w,
                  // color: AppTheme.colors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

}