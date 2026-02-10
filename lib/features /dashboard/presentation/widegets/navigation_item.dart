
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_theme.dart';

class NavigationItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final int? badgeCount;

  const NavigationItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 80.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 14.w),
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.colors.blue
                    : Colors.transparent, // Light gray transparent
                shape: BoxShape.circle,
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: AppTheme.colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon with badge
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        icon,
                        height: 18.h,
                        width: 18.w,
                        colorFilter: ColorFilter.mode(
                          isSelected
                              ? AppTheme.colors.white
                              : AppTheme.colors.blue,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
