import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/icons.dart';
import '../../theme/app_theme.dart';
import '../icon/custom_icon.dart';

class DBAppBar extends StatelessWidget implements PreferredSizeWidget {
   DBAppBar({
    super.key,
    required this.title,
    this.isLeadingWidget = true,
    this.action,
    this.onTapOnBack,
  });

  final String title;
  final bool isLeadingWidget;
  final List<Widget>? action;
  VoidCallback? onTapOnBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 8.r),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 70.h,
          centerTitle: true,
          leading: isLeadingWidget
              ? CustomIcon(
                  icon: AppIcons.BACK_ARROW,
                  onTap:onTapOnBack ?? () {
                    Get.back();
                  },
                )
              : null,
          title: Text(
            title,
            style: AppTheme.textStyles.textStyle26w500TextStyle
                .copyWith(color: AppTheme.colors.black),
          ),
          actions: action,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 70.h);
}
