import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_theme.dart';

// ignore: must_be_immutable
class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final void Function(String) onChanged;
  PasswordField({
    super.key,
    this.validator,
    this.controller,
    required this.hintText,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    required this.onChanged,
  });

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      cursorColor: AppTheme.colors.primary,
      maxLines: 1,
      decoration: InputDecoration(
          contentPadding: REdgeInsets.all(appSizes.k20),
          errorMaxLines: 1,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12.0),
          hintText: widget.hintText,
          hintStyle: AppTheme.textStyles.textStyle18w400TextStyle,
          // filled: true,
          // fillColor: AppTheme.colors.secondaryMedium,
          suffixIcon: GestureDetector(
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppTheme.colors.primary,
            ),
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1.sp,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide(
              color: Colors.red,
              width: 3.sp,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide(
              color: Colors.red,
              width: 3.sp,
            ),
          )),
      onChanged: widget.onChanged,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      autovalidateMode: widget.autoValidateMode,
      validator: widget.validator,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
