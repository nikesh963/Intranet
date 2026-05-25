import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/button/customButton.dart';
import '../../../../core/widget/app_bar/custom_app_bar.dart';

import '../controller/verify_otp_controller.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});

  final VerifyOtpController controller =
  Get.find<VerifyOtpController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: DBAppBar(
        title: "OTP Verification",
        isLeadingWidget: false,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 30.h,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 40.h),

            Text(
              "Verify OTP",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              "Enter the 6 digit OTP sent to your email.",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 40.h),

            Pinput(
              controller: controller.otpController,
              length: 6,

              defaultPinTheme: PinTheme(
                width: 55.w,
                height: 55.h,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppTheme.colors.blue,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),

            Center(
              child: Obx(() => TextButton(
                onPressed: controller.isResending.value
                    ? null
                    : controller.resendOtp,

                child: controller.isResending.value
                    ? CircularProgressIndicator()
                    : Text(
                  "Resend OTP",
                  style: TextStyle(
                    color: AppTheme.colors.blue,
                  ),
                ),
              )),
            ),

            SizedBox(height: 40.h),

            // Obx(() => CustomButton(
            //   onPressed: controller.isLoading.value
            //       ? null
            //       : controller.verifyOtp,
            //   buttonText: "Verify OTP",
            //   isLoading: controller.isLoading.value,
            //   buttonWidth: Get.width,
            // )),
            Obx(() => SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.verifyOtp,
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
                  'Verify OTP',
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
    );
  }
}