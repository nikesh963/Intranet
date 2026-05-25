import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/app_bar/custom_app_bar.dart';
import '../../../../core/widget/button/customButton.dart';

import '../../../../core/widget/custom_text_fields/passwordInputField.dart';

import '../controller/create_new_password_controller.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({super.key});

  final CreateNewPasswordController controller =
  Get.find<CreateNewPasswordController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: DBAppBar(
        title: "New Password",
        isLeadingWidget: false,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 40.h,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 40.h),

              Text(
                "Create New Password",
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.h),

              Text(
                "Create your new password.",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 40.h),

              Text(
                "New Password",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 8.h),

              PasswordField(
                hintText: "Enter new password", onChanged: (String p1) {  },
              ),

              SizedBox(height: 24.h),

              Text(
                "Confirm Password",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 8.h),

              PasswordField(
                controller: controller.confirmPasswordController,
                hintText: "Confirm password", onChanged: (String p1) {  },
              ),

              SizedBox(height: 50.h),

              // Obx(() => CustomButton(
              //   onPressed: controller.isLoading.value
              //       ? null
              //       : controller.resetPassword,
              //   buttonText: "Save Password",
              //   isLoading: controller.isLoading.value,
              //   buttonWidth: Get.width,
              // )),
              Obx(() => SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.resetPassword,
                  // onPressed:  controller.login,
                  // onPressed:(){
                  //   Get.offAllNamed(AppRoutes.dashboard);
                  // },

                  // controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.colors.blue,
                    foregroundColor: AppTheme.colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.w,
                      color: AppTheme.colors.white,
                    ),
                  )
                      : Text(
                    'Save Password',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),

            ],
          ),
        ),
      ),
    );
  }
}