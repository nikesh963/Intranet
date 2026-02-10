import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/icons.dart';
import '../theme/app_theme.dart';

class CustomSortByWidget extends StatelessWidget {
   CustomSortByWidget({super.key, required this.alphabeticalAZ, required this.alphabeticalZA, required this.newToOld, required this.oldToNew, required this.highToLow, required this.lowToHigh});

 final VoidCallback alphabeticalAZ;
 final VoidCallback alphabeticalZA;
 final VoidCallback newToOld;
 final VoidCallback oldToNew;
 final VoidCallback highToLow;
 final VoidCallback lowToHigh;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset(0, 30),
      color: AppTheme.colors.white,
      child: SvgPicture.asset(AppImages.SORTBY),


      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(

            height: 24.h,
            onTap: alphabeticalAZ,
            child: Text(
              "Alphabetical A-Z",
              style: AppTheme.textStyles.textStyle12w400TextStyle,
            ),
          ),
          PopupMenuItem(
            height: 24.h,
            onTap: alphabeticalZA,
            child: Text(
              "Alphabetical Z-A",
              style: AppTheme.textStyles.textStyle12w400TextStyle,
            ),
          ),
          PopupMenuItem(
            height: 24.h,
            onTap: newToOld,
            child: Text(
              "Newest to Oldest",
              style: AppTheme.textStyles.textStyle12w400TextStyle,
            ),
          ),
          PopupMenuItem(
            height: 24.h,
            onTap:oldToNew,
            child: Text(
              "Oldest to Newest",
              style: AppTheme.textStyles.textStyle12w400TextStyle,
            ),
          ),
          PopupMenuItem(
            height: 24.h,
            onTap: highToLow,
            child: Text(
              "Price High to Low",
              style: AppTheme.textStyles.textStyle12w400TextStyle,
            ),
          ),
          PopupMenuItem(
            height: 24.h,
            onTap: lowToHigh,
            child: Text(
              "Price Low to High",
              style: AppTheme.textStyles.textStyle12w400TextStyle,
            ),
          ),
        ];
      },
    );
  }
}
