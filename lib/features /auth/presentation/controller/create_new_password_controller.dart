import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../../Common/CommonSnackBar.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routes/app_pages.dart';

class CreateNewPasswordController extends GetxController {

  // final ApiHelper apiHelper;
  //
  // CreateNewPasswordController({
  //   required this.apiHelper,
  // });
  final ApiHelper apiHelper = ApiHelper();
  final NetworkInfo networkInfo = Get.find<NetworkInfo>();

  final newpasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;

  late String email;
  late String otp;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments["email"];
    otp = Get.arguments["otp"];
  }

  Future<void> resetPassword() async {

    final password = newpasswordController.text.trim();
    final confirmPassword =
    confirmPasswordController.text.trim();

    if(password.isEmpty){
      SnackBarService.showErrorSnackBar(
        "Please enter password",
      );
      return;
    }

    if(password.length < 6){
      SnackBarService.showErrorSnackBar(
        "Password should be minimum 6 characters",
      );
      return;
    }

    if(confirmPassword.isEmpty){
      SnackBarService.showErrorSnackBar(
        "Please enter confirm password",
      );
      return;
    }

    if(password != confirmPassword){
      SnackBarService.showErrorSnackBar(
        "Passwords do not match",
      );
      return;
    }

    try{

      isLoading.value = true;

      final response = await apiHelper.post(
        '/mobile/reset-password',
        data: {
          "email" : email,
          "otp" : otp,
          "password" : password,
          "password_confirmation" : confirmPassword,
        },
      );

      if(response.statusCode == 200 || response.statusCode == 201){

        SnackBarService.showSuccessSnackBar(
          response.data["message"] ??
              "Password reset successful",
        );

        // Get.offAllNamed(AppRoutes.login);
        FocusManager.instance.primaryFocus?.unfocus();

        await Future.delayed(const Duration(milliseconds: 100));

        Get.offAllNamed(AppRoutes.login);
      }

    } on DioException catch(e){

      SnackBarService.showErrorSnackBar(
        e.response?.data["message"] ??
            "Password reset failed",
      );

    } catch(e){

      SnackBarService.showErrorSnackBar(
        "Something went wrong",
      );

    } finally{
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    newpasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}