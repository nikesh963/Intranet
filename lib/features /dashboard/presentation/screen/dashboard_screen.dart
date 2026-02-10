import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../core/theme/app_theme.dart';
import '../controller/dashboard_controller.dart';
import '../widegets/navigation_item.dart';


class Dashboard extends GetView<DashboardController> {
  final int? initialIndex;
  final String? targetRoute;

  Dashboard({super.key, this.initialIndex,this.targetRoute});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardController());
    if (initialIndex != null &&
        controller.selectedTabIndex.value != initialIndex) {
      controller.updateSelectedTabIndex(initialIndex!);
    }
    if (targetRoute != null) {
      Future.delayed(Duration.zero, () {
        Get.toNamed(targetRoute!);
      });
    }
    return Obx(
          () => Scaffold(
        extendBody: true,
        // backgroundColor: Colors.transparent, // ADD THIS LINE
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        resizeToAvoidBottomInset: true,

        body: controller.tabScreens.isNotEmpty
            ? AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: controller.tabScreens[controller.selectedTabIndex.value],
        )
            : const Center(child: CircularProgressIndicator()),

        bottomNavigationBar: controller.tabIconList.isNotEmpty
            ? SafeArea(
          child: Container(
            margin: EdgeInsets.only(bottom: 15.w,left: 15.w,right: 15.w),
            height: 66.h,
            // padding: EdgeInsets.only(bottom: 0.h, top: 0.h),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(60.r),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 3,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding:   EdgeInsets.symmetric(horizontal: 3.h,vertical: 3.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  controller.tabIconList.length,
                      (index) {
                    return Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(), // 👈 ripple is circular
                        onTap: () async {
                          await Future.delayed(const Duration(milliseconds: 300)); // 👈 smooth delay
                          if (controller.selectedTabIndex.value != index) {
                            controller.updateSelectedTabIndex(index);
                          }
                        },
                        borderRadius: BorderRadius.circular(30.r),
                        child: NavigationItem(
                          icon: controller.tabIconList[index],
                          label: _getLabelForIndex(index),
                          isSelected: controller.selectedTabIndex.value == index,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        )
            : SizedBox.shrink(),



          ),
    );
  }
  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Attendance';
      case 2:
        return 'Manage';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }
}
class NavBarPainter extends CustomPainter {
  final Color backgroundColor;

  NavBarPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final path = Path();

    // Tweaked values to match image proportions
    double dipWidth = 120.r;   // wider center curve
    double dipDepth = 98.r;    // deeper dip
    const double dipEdgeSmooth = 15.0; // smoother dip edge
    const double topCornerRadius = 14.0; // rounded top left & right

    // Start from bottom-left corner
    path.moveTo(0, size.height);
    path.lineTo(0, topCornerRadius);

    // Top-left corner rounding
    path.quadraticBezierTo(
      0, 0, // control
      topCornerRadius, 0, // end
    );

    // Left flat area until dip start
    path.lineTo((size.width / 2) - (dipWidth / 2) - dipEdgeSmooth, 0);

    // Left dip curve
    path.quadraticBezierTo(
      (size.width / 2) - (dipWidth / 2), 0,
      (size.width / 2) - (dipWidth / 2) + 10, 15,
    );

    // Bottom dip curve (smooth circular shape)
    path.quadraticBezierTo(
      size.width / 2, dipDepth,
      (size.width / 2) + (dipWidth / 2) - 10, 15,
    );

    // Right dip curve
    path.quadraticBezierTo(
      (size.width / 2) + (dipWidth / 2), 0,
      (size.width / 2) + (dipWidth / 2) + dipEdgeSmooth, 0,
    );

    // Flat right area
    path.lineTo(size.width - topCornerRadius, 0);

    // Top-right corner rounding
    path.quadraticBezierTo(
      size.width, 0,
      size.width, topCornerRadius,
    );

    // Complete shape
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Shadow & paint
    canvas.drawShadow(path, Colors.black.withOpacity(0.25), 6, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
