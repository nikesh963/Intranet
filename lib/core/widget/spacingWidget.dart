import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//------------------- Paddings -------------------

final paddingAll20 = EdgeInsets.all(20.r);
final paddingAll16 = EdgeInsets.all(16.r);
final paddingAll12 = EdgeInsets.all(12.r);
final paddingAll8 = EdgeInsets.all(8.r);

//------------------- Horizontal Spacing -------------------
final spaceOfW2 = SizedBox(width: 2.w);
final spaceOfW4 = SizedBox(width: 4.w);
final spaceOfW8 = SizedBox(width: 8.w);
final spaceOfW12 = SizedBox(width: 12.w);
final spaceOfW16 = SizedBox(width: 16.w);
final spaceOfW20 = SizedBox(width: 20.w);

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width.w,
  );
}

//------------------- Vertical Spacing -------------------
final spaceOfH2 = SizedBox(height: 2.h);
final spaceOfH4 = SizedBox(height: 4.h);
final spaceOfH8 = SizedBox(height: 8.h);
final spaceOfH12 = SizedBox(height: 12.h);
final spaceOfH16 = SizedBox(height: 16.h);
final spaceOfH20 = SizedBox(height: 20.h);
Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height.h,
  );
}
