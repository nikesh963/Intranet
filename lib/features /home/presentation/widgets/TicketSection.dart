// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/constants/icons.dart';
// import '../../../../core/routes/app_pages.dart';
// import '../../../../core/theme/app_theme.dart';
// import '../controller/home_controller.dart';
//
// class Ticketsection extends StatelessWidget {
//   Ticketsection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.find<HomeController>();
//     final ScrollController _horizontalScrollController = ScrollController();
//     final ValueNotifier<bool> _isScrollingNotifier = ValueNotifier<bool>(false);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(bottom: 16.h,left: 16.w),
//           child: Text(
//             "Tickets",
//             style: TextStyle(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.r),
//             // boxShadow: [
//             //   BoxShadow(
//             //     color: Colors.black.withOpacity(0.05),
//             //     blurRadius: 4,
//             //     offset: const Offset(0, 2),
//             //   ),
//             // ],
//           ),
//           child: Column(
//             children: [
//               NotificationListener<ScrollNotification>(
//                 onNotification: (notification) {
//                   if (notification is ScrollStartNotification ||
//                       notification is ScrollUpdateNotification) {
//                     _isScrollingNotifier.value = true;
//                   } else if (notification is ScrollEndNotification) {
//                     Future.delayed(Duration(milliseconds: 500), () {
//                       _isScrollingNotifier.value = false;
//                     });
//                   }
//                   return false;
//                 },
//                 child: Obx(() {
//                   return SingleChildScrollView(
//                     controller: _horizontalScrollController,
//                     scrollDirection: Axis.horizontal,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Table Header
//                         Container(
//                           width: _calculateTotalWidth(),
//                           padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
//                           decoration: BoxDecoration(
//                             color: AppTheme.colors.gray,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(8.r),
//                               topRight: Radius.circular(8.r),
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               _buildHeaderCell("Employee", 120.w),
//                               _buildHeaderCell("RO", 80.w),
//                               _buildHeaderCell("Leave Type", 100.w),
//                               _buildHeaderCell("Applied On", 100.w),
//                               _buildHeaderCell("Start Date", 100.w),
//                               _buildHeaderCell("End Date", 100.w),
//                               _buildHeaderCell("Total Days", 100.w),
//                               _buildHeaderCell("Status", 100.w),
//                               _buildHeaderCell("Last Updated By", 130.w),
//                             ],
//                           ),
//                         ),
//
//                         // Table Body
//                         Column(
//                           children: controller.leaveTickets.asMap().entries.map((entry) {
//                             final index = entry.key;
//                             final ticket = entry.value;
//
//                             return Container(
//                               width: _calculateTotalWidth(),
//                               padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                   bottom: index == controller.leaveTickets.length - 1
//                                       ? BorderSide.none
//                                       : BorderSide(
//                                     color: AppTheme.colors.gray,
//                                     width: 1,
//                                   ),
//                                 ),
//                               ),
//                               child: Row(
//                                 children: [
//                                   _buildDataCell(ticket.employee, 120.w),
//                                   _buildDataCell(ticket.ro, 80.w),
//                                   _buildLeaveTypeCell(ticket.leaveType, 100.w),
//                                   _buildDataCell(ticket.appliedOn, 100.w),
//                                   _buildDataCell(ticket.startDate, 100.w),
//                                   _buildDataCell(ticket.endDate, 100.w),
//                                   _buildTotalDaysCell(ticket.totalDays, 100.w),
//                                   _buildStatusCell(ticket.status, 100.w),
//                                   // _buildDataCell(ticket.lastUpdatedBy, 130.w),
//                                   _buildDataCell(ticket.lastUpdatedBy, 130.w, padding: EdgeInsets.only(left: 18.w)),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//
//               // Blue Scroll Indicator at the bottom
//               Container(
//                 height: 6.h,
//                 margin: EdgeInsets.symmetric(vertical: 8.h),
//                 child: LayoutBuilder(
//                   builder: (context, constraints) {
//                     final totalWidth = _calculateTotalWidth();
//                     final visibleWidth = MediaQuery.of(context).size.width - 32.w; // Screen width minus padding
//
//                     // Only show scroll indicator if content is wider than screen
//                     if (totalWidth <= visibleWidth) {
//                       return SizedBox.shrink();
//                     }
//
//                     return ValueListenableBuilder<bool>(
//                       valueListenable: _isScrollingNotifier,
//                       builder: (context, isScrolling, child) {
//                         return AnimatedOpacity(
//                           opacity: isScrolling ? 1.0 : 0.7,
//                           duration: Duration(milliseconds: 300),
//                           child: Container(
//                             width: constraints.maxWidth,
//                             child: Stack(
//                               children: [
//                                 // Background track
//                                 Container(
//                                   width: constraints.maxWidth,
//                                   height: 3.h,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[200],
//                                     borderRadius: BorderRadius.circular(1.5.r),
//                                   ),
//                                 ),
//
//                                 // Blue scroll thumb
//                                 AnimatedBuilder(
//                                   animation: _horizontalScrollController,
//                                   builder: (context, child) {
//                                     final scrollOffset = _horizontalScrollController.hasClients
//                                         ? _horizontalScrollController.offset
//                                         : 0.0;
//                                     final maxScrollExtent = _horizontalScrollController.hasClients
//                                         ? _horizontalScrollController.position.maxScrollExtent
//                                         : 1.0;
//
//                                     final thumbWidth = (visibleWidth / totalWidth) * constraints.maxWidth;
//                                     final thumbPosition = maxScrollExtent > 0
//                                         ? (scrollOffset / maxScrollExtent) * (constraints.maxWidth - thumbWidth)
//                                         : 0.0;
//
//                                     return Positioned(
//                                       left: thumbPosition.clamp(0.0, constraints.maxWidth - thumbWidth),
//                                       child: Container(
//                                         width: thumbWidth,
//                                         height: 4.h,
//                                         decoration: BoxDecoration(
//                                           color: Colors.blue, // Blue color
//                                           borderRadius: BorderRadius.circular(2.r),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.blue.withOpacity(0.3),
//                                               blurRadius: 2,
//                                               offset: Offset(0, 1),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//   Widget  _buildHeaderCell(String text, double width) {
//     return SizedBox(
//       width: width,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.w),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget _buildDataCell(String text, double width) {
//   //   return SizedBox(
//   //     width: width,
//   //     child: Padding(
//   //       padding: EdgeInsets.symmetric(horizontal: 8.w),
//   //       child: Text(
//   //         text,
//   //         style: TextStyle(
//   //           fontSize: 14.sp,
//   //           fontWeight: FontWeight.w400,
//   //         ),
//   //         overflow: TextOverflow.ellipsis,
//   //       ),
//   //     ),
//   //   );
//   // }
//   Widget _buildDataCell(String text, double width, {EdgeInsetsGeometry? padding}) {
//     return SizedBox(
//       width: width,
//       child: Padding(
//         padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w400,
//           ),
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLeaveTypeCell(String text, double width) {
//     return SizedBox(
//       width: width,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4.r),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTotalDaysCell(String text, double width) {
//     return SizedBox(
//       width: width,
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatusCell(String text, double width) {
//     return SizedBox(
//       width: width,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
//         decoration: BoxDecoration(
//           color: _getStatusColor(text),
//           borderRadius: BorderRadius.circular(4.r),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: AppTheme.colors.white
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
//
//   double _calculateTotalWidth() {
//     return 120.w + 80.w + 100.w + 100.w + 100.w + 100.w + 100.w + 100.w + 130.w + (16.w * 2);
//   }
// // Helper methods for styling
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'approved':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'rejected':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
//
//
//   Widget _buildPagination() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // Text: "1 of 13 Pages"
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: Text(
//             "1 of 13 Pages",
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               // color: AppTheme.colors.textSecondary,
//             ),
//           ),
//         ),
//
//         // Right side: Page selector and arrows
//         Row(
//           children: [
//             // "Page" text
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//               child: Text(
//                 "Page",
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w400,
//                   // color: AppTheme.colors.textSecondary,
//                 ),
//               ),
//             ),
//             SizedBox(width: 8.w),
//
//             // Page number dropdown/input
//             Container(
//               width: 45.w,
//               height: 35.h,
//               padding: EdgeInsets.only(left: 8.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4.r),
//                 border: Border.all(
//                   color: AppTheme.colors.black.withOpacity(0.2),
//                   width: 1.w,
//                 ),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   value: "1",
//                   icon: Icon(
//                     Icons.arrow_drop_down,
//                     // size: 20.w,
//                     // color: AppTheme.colors.textSecondary,
//                   ),
//                   isExpanded: true,
//                   items: List.generate(2, (index) => (index + 1).toString())
//                       .map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(
//                         value,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     // Handle page change
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(width: 16.w),
//
//             // Back arrow
//             GestureDetector(
//               onTap: () {
//                 // Handle previous page
//               },
//               child: Container(
//                 padding: EdgeInsets.all(8.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   // shape: BoxShape.circle,
//                   border: Border.all(
//                     color: AppTheme.colors.black.withOpacity(0.2),
//                     width: 1.w,
//                   ),
//                 ),
//                 child: Icon(
//                   Icons.arrow_back,
//                   size: 20.w,
//                   // color: AppTheme.colors.textSecondary,
//                 ),
//               ),
//             ),
//             SizedBox(width: 8.w),
//
//             // Forward arrow
//             GestureDetector(
//               onTap: () {
//                 // Handle next page
//               },
//               child: Container(
//                 padding: EdgeInsets.all(8.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   // shape: BoxShape.circle,
//                   border: Border.all(
//                     color: AppTheme.colors.black.withOpacity(0.2),
//                     width: 1.w,
//                   ),
//                 ),
//                 child: Icon(
//                   Icons.arrow_forward,
//                   size: 20.w,
//                   // color: AppTheme.colors.textSecondary,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
// }
