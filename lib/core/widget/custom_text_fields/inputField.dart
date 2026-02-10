
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_theme.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final int? maxLines;
  final String hintText;
  final bool autofocus;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onClear;
  final void Function(String)? onSubmitted;
  final AutovalidateMode? autoValidateMode;
  final TextCapitalization textCapitalization;

  const InputField({
    super.key,
    this.validator,
    this.maxLines = 1,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  InputFieldState createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      cursorColor: AppTheme.colors.primary,
      textAlignVertical: TextAlignVertical.center,
      textCapitalization: widget.textCapitalization,
      minLines: 1,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
          contentPadding: REdgeInsets.all(appSizes.k20),
          errorMaxLines: 1,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12.0),
          hintText: widget.hintText,
          hintStyle: AppTheme.textStyles.textStyle18w400TextStyle.copyWith(color: Colors.black45),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide(
              color: widget.readOnly == false
                  ?Colors.black12
                  : Colors.transparent,
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
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      autovalidateMode: widget.autoValidateMode,
      validator: widget.validator,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}
