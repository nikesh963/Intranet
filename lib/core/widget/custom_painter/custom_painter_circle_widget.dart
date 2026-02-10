import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_theme.dart';

class CustomPainterCircle extends StatelessWidget {
  const CustomPainterCircle({
    super.key,
    required this.circleSize,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.onlyBorder = false,
  });
  final double circleSize;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final bool onlyBorder;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top?.h,
      bottom: bottom?.h,
      left: left?.w,
      right: right?.w,
      child: Container(
        height: circleSize.w,
        width: circleSize.w,
        decoration: BoxDecoration(
            color: onlyBorder ? null : AppTheme.colors.secondaryLight,
            shape: BoxShape.circle,
            border:
                Border.all(color: AppTheme.colors.secondaryLight, width: 3.sp)),
      ),
    );
  }
}
