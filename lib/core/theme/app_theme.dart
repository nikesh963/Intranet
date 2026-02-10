import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTheme {
  static AppColors colors = AppColors();
  static AppTextStyles textStyles = AppTextStyles();

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: colors.scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        surfaceTintColor: AppTheme.colors.scaffoldBackgroundColor,
        backgroundColor: AppTheme.colors.scaffoldBackgroundColor,
      ));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(color: colors.white));
}

final class AppSizes {
  // Font size
  double k8 = 8.sp;
  double k10 = 10.sp;
  double k12 = 12.sp;
  double k14 = 14.sp;
  double k16 = 16.sp;
  double k18 = 18.sp;
  double k20 = 20.sp;
  double k22 = 22.sp;
  double k24 = 24.sp;
  double k26 = 26.sp;
}

final appSizes = AppSizes();

class AppTextStyles {
  TextStyle textStyle8w400TextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: appSizes.k8,
  );
  TextStyle textStyle10w400TextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: appSizes.k10,
  );
  TextStyle textStyle12w400TextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: appSizes.k12,
  );
  TextStyle textStyle14w400TextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: appSizes.k14,
  );
  TextStyle textStyle16w400TextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: appSizes.k16,
  );
  TextStyle textStyle18w400TextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: appSizes.k18,
  );
  TextStyle textStyle20w400TextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: appSizes.k20,
  );
  TextStyle textStyle22w400TextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: appSizes.k22,
  );
  TextStyle textStyle24w400TextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: appSizes.k24,
  );
  TextStyle textStyle36w400TextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 36.sp,
  );

  TextStyle textStyle8w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: appSizes.k8,
  );
  TextStyle textStyle10w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: appSizes.k10,
  );
  TextStyle textStyle12w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: appSizes.k12,
  );
  TextStyle textStyle14w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: appSizes.k14,
  );
  TextStyle textStyle16w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: appSizes.k16,
  );
  TextStyle textStyle18w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: appSizes.k18,
  );
  TextStyle textStyle20w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: appSizes.k20,
  );
  TextStyle textStyle22w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: appSizes.k22,
  );
  TextStyle textStyle24w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: appSizes.k24,
  );
  TextStyle textStyle26w500TextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: appSizes.k26,
      color: AppTheme.colors.black);

  TextStyle textStyle38w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 38.sp,
  );

  TextStyle textStyle36w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 36.sp,
  );
  TextStyle textStyle44w500TextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 44.sp,
  );

  TextStyle textStyle16w700TextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: appSizes.k16,
  );
}
