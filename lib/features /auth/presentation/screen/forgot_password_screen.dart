import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/button/customButton.dart';
import '../../../../core/widget/custom_text_fields/inputField.dart';
import '../../../../core/widget/app_bar/custom_app_bar.dart';

import '../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordController controller =
  Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: DBAppBar(
        title: "Forgot Password",
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

              Center(
                child: Image.asset(
                  AppImages.LOGO,
                  height: 110.h,
                  width: 170.w,
                ),
              ),

              SizedBox(height: 40.h),

              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.h),

              Text(
                "Enter your registered email address to receive OTP.",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 40.h),

              Text(
                "Email",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 8.h),

              InputField(
                controller: controller.emailController,
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 50.h),

              // Obx(() => CustomButton(
              //   onPressed: controller.isLoading.value
              //       ? null
              //       : controller.sendOtp,
              //   buttonText: "Next",
              //   isLoading: controller.isLoading.value,
              //   buttonWidth: Get.width,
              //
              // )),
              Obx(() => SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.sendOtp,
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
                    'Next',
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