import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_theme.dart';
import '../../constants/icons.dart';
import '../spacingWidget.dart';

class CustomAlertPopup extends StatelessWidget {
  const CustomAlertPopup(
      {super.key,
      required this.title,
      required this.content,
      required this.onConfirm});
  final String title;
  final String content;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: [
          SvgPicture.asset(
            AppIcons.SUCCESS,
            height: 44.sp,
            width: 44.sp,
          ),
          spaceOfH12,
          Text(
            title,
            style: AppTheme.textStyles.textStyle22w500TextStyle.copyWith(
                color: AppTheme.colors.primary, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Text(
        content,
        style: AppTheme.textStyles.textStyle14w400TextStyle
            .copyWith(color: AppTheme.colors.black),
      ),
      actions: [
        CupertinoButton(
            onPressed: onConfirm,
            color: AppTheme.colors.primary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
            child: Text(
              "Continue",
              style: AppTheme.textStyles.textStyle18w400TextStyle
                  .copyWith(color: AppTheme.colors.white),
            )),
      ],
    );
  }
}
