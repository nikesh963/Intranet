import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/icons.dart';
import '../../theme/app_theme.dart';
import '../spacingWidget.dart';

class CustomToastWidget extends StatelessWidget {
  const CustomToastWidget(
      {super.key,
      required this.title,
      required this.message,
      required this.toastType});

  final String title;
  final String message;
  final ToastType toastType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,
      height: 50.h,
      padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
      decoration: BoxDecoration(
          color: toastType == ToastType.SUCCESS
              ? AppTheme.colors.successGreen
              : toastType == ToastType.INFO
                  ? AppTheme.colors.infoBlue
                  : toastType == ToastType.WARNING
                      ? AppTheme.colors.warningYellow
                      : AppTheme.colors.errorRed,
          borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(
                  toastType == ToastType.SUCCESS
                      ? AppIcons.SUCCESS
                      : toastType == ToastType.ERROR
                          ? AppIcons.ERROR
                          : AppIcons.INFO,
                  width: 16.w,
                ),
                spaceOfW12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      softWrap: true,
                      style: AppTheme.textStyles.textStyle12w500TextStyle,
                    ),
                    message.isNotEmpty
                        ? Text(
                            message,
                            maxLines: 1,
                            softWrap: true,
                            style: AppTheme.textStyles.textStyle8w400TextStyle,
                          )
                        : SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
              padding: EdgeInsets.zero,
              iconSize: appSizes.k16,
              onPressed: () {
                // Get.back();
              },
              icon: Icon(
                Icons.clear,
              ))
        ],
      ),
    );
  }
}

enum ToastType {
  SUCCESS,
  INFO,
  WARNING,
  ERROR,
}
