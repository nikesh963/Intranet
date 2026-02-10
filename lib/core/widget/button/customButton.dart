import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_theme.dart';

enum ButtonType {
  primary,
  secondary,
  outline,
  danger,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isDisabled;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? customColor;
  final Color? textColor;
  final double? borderRadius;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.padding,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.customColor,
    this.textColor,
    this.borderRadius,
  }) : super(key: key);

  Color _getBackgroundColor(BuildContext context) {
    if (customColor != null) return customColor!;

    switch (type) {
      case ButtonType.primary:
        return AppTheme.colors.blue;
      case ButtonType.secondary:
        return AppTheme.colors.secondaryMedium;
      case ButtonType.outline:
        return Colors.transparent;
      case ButtonType.danger:
        return Colors.red;
      default:
        return AppTheme.colors.primary;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (textColor != null) return textColor!;

    switch (type) {
      case ButtonType.primary:
        return AppTheme.colors.white; // Primary color text for white button
      case ButtonType.secondary:
        return Colors.white;
      case ButtonType.outline:
        return AppTheme.colors.primary;
      case ButtonType.danger:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  Color _getBorderColor(BuildContext context) {
    switch (type) {
      case ButtonType.outline:
        return AppTheme.colors.primary;
      default:
        return Colors.transparent;
    }
  }

  Color _getLoaderColor(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return AppTheme.colors.white;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56.h,
      child: ElevatedButton(
        onPressed: (isDisabled || isLoading) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(context),
          foregroundColor: _getTextColor(context),
          elevation: 4,
          // splashFactory: InkRipple.splashFactory,
            splashFactory: InkRipple.splashFactory,
            overlayColor: Colors.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            side: BorderSide(
              color: _getBorderColor(context),
              width: type == ButtonType.outline ? 1.5.w : 0,
            ),
          ),
          padding: padding ?? EdgeInsets.zero,
          disabledBackgroundColor: _getBackgroundColor(context),
          disabledForegroundColor: _getTextColor(context).withOpacity(0.5),
        ),
        child: isLoading
            ? SizedBox(
          width: 24.w,
          height: 24.h,
          child: CircularProgressIndicator(
            strokeWidth: 2.w,
            color: _getLoaderColor(context),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.colors.white,
                // letterSpacing: 0.5,
              ),
            ),
            if (suffixIcon != null) ...[
              SizedBox(width: 8.w),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}

// Example usage variations:
//
// 1. Primary Button (like in login screen):
// CustomButton(
//   text: 'Sign In',
//   onPressed: () {},
//   type: ButtonType.primary,
// )
//
// 2. Secondary Button:
// CustomButton(
//   text: 'Cancel',
//   onPressed: () {},
//   type: ButtonType.secondary,
// )
//
// 3. Outline Button:
// CustomButton(
//   text: 'Edit Profile',
//   onPressed: () {},
//   type: ButtonType.outline,
// )
//
// 4. Danger Button:
// CustomButton(
//   text: 'Delete Account',
//   onPressed: () {},
//   type: ButtonType.danger,
// )
//
// 5. With Icons:
// CustomButton(
//   text: 'Continue with Google',
//   onPressed: () {},
//   type: ButtonType.outline,
//   prefixIcon: Icon(Icons.g_translate, size: 20.w),
// )
//
// 6. Custom Size:
// CustomButton(
//   text: 'Save',
//   onPressed: () {},
//   width: 120.w,
//   height: 48.h,
// )