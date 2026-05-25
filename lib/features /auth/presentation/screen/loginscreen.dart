import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/button/customButton.dart';
import '../../../../core/widget/custom_text_fields/inputField.dart';
import '../../../../core/widget/custom_text_fields/passwordInputField.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome back text (optional)
              // SizedBox(height: 60.h),
              Center(
                child: Image.asset(
                   AppImages.LOGO,
                  height: 110.h,
                  width: 170.w,
                ),
              ),
              // SizedBox(height: 10.h),
              // Title
              Center(
                child: Text(
                  'Intranet',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Subtitle
              Center(
                child: Text(
                  'Sign in to Explore App',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),

              SizedBox(height: 60.h),

              // Email Section
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  // color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),

            InputField(
                controller: controller.emailController,
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) => controller.emailError.value,
                onChanged: (value) {
                  if (controller.emailError.value != null) {
                    controller.emailError.value = null;
                  }
                },
              ),

              SizedBox(height: 24.h),

              // Password Section
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  // color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),

               PasswordField(
                controller: controller.passwordController,
                hintText: 'Enter your password',
                validator: (value) => controller.passwordError.value,
                onChanged: (value) {
                  if (controller.passwordError.value != null) {
                    controller.passwordError.value = null;
                  }
                },
              ),

              SizedBox(height: 20.h),

              // Remember Me Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Row(
                    children: [
                      Transform.translate(
                        offset: Offset(-4.w, 0), // adjust as needed to reduce gap
                        child: Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.rememberMe.value = value ?? false;
                          },
                          visualDensity: VisualDensity.compact, // optional: tighter layout
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // tighter tap area
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8.r),
                        onTap: () async {
                          await Future.delayed(const Duration(milliseconds: 200)); // 👈 smooth delay
                          // authController.toggleRememberMe();
                          controller.rememberMe.value = !controller.rememberMe.value;
                          },
                        child: Container(
                          padding: EdgeInsets.only(top: 12.w,right: 12.w,bottom: 12.w),
                          child: Text(
                            'Remember me',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                      ),

                    ],
                  ),
                  ),
                  // Forgot Password Button
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.forgotPassword);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.colors.blue,
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(height: 40.h),
              Obx(() => SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.login,
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
                    'Log In',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),

              SizedBox(height: 20.h),
              // Spacer to push content up on keyboard show
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom > 0 ? 100.h : 0),
            ],
          ),
        ),
      ),
    );
  }
}