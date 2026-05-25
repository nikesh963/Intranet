import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../../Common/CommonSnackBar.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {

  // final ApiHelper apiHelper;
  final ApiHelper apiHelper = ApiHelper();
  final NetworkInfo networkInfo = Get.find<NetworkInfo>();
  // ForgotPasswordController({
  //   required this.apiHelper,
  // });

  final emailController = TextEditingController();

  final isLoading = false.obs;

  Future<void> sendOtp() async {

    final email = emailController.text.trim().toLowerCase();

    if(email.isEmpty){
      SnackBarService.showErrorSnackBar("Please enter email");
      return;
    }

    if(!GetUtils.isEmail(email)){
      SnackBarService.showErrorSnackBar("Please enter valid email");
      return;
    }

    try{

      isLoading.value = true;

      final response = await apiHelper.post(
        '/mobile/forgot-password',
        data: {
          "email" : email,
        },
      );

      if(response.statusCode == 200 || response.statusCode == 201){

        SnackBarService.showSuccessSnackBar(
          response.data["message"] ?? "OTP sent successfully",
        );

        Get.toNamed(
          AppRoutes.verifyOtp,
          arguments: {
            "email" : email,
          },
        );

      }

    } on DioException catch(e){

      SnackBarService.showErrorSnackBar(
        e.response?.data["message"] ??
            "Failed to send OTP",
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
    emailController.dispose();
    super.onClose();
  }
}