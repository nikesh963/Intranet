import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../../Common/CommonSnackBar.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routes/app_pages.dart';

class VerifyOtpController extends GetxController {

  // final ApiHelper apiHelper;
  //
  // VerifyOtpController({
  //   required this.apiHelper,
  // });
  final ApiHelper apiHelper = ApiHelper();
  final NetworkInfo networkInfo = Get.find<NetworkInfo>();

  final otpController = TextEditingController();

  final isLoading = false.obs;
  final isResending = false.obs;

  late String email;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments["email"];
  }

  Future<void> verifyOtp() async {

    final otp = otpController.text.trim();

    if(otp.isEmpty){
      SnackBarService.showErrorSnackBar("Please enter OTP");
      return;
    }

    if(otp.length != 6){
      SnackBarService.showErrorSnackBar("Please enter valid OTP");
      return;
    }

    try{

      isLoading.value = true;

      final response = await apiHelper.post(
        '/mobile/verify-otp',
        data: {
          "email" : email,
          "otp" : otp,
        },
      );

      if(response.statusCode == 200 || response.statusCode == 201){

        SnackBarService.showSuccessSnackBar(
          response.data["message"] ?? "OTP verified",
        );

        Get.toNamed(
          AppRoutes.createNewPassword,
          arguments: {
            "email" : email,
            "otp" : otp,
          },
        );
      }

    } on DioException catch(e){

      SnackBarService.showErrorSnackBar(
        e.response?.data["message"] ??
            "OTP verification failed",
      );

    } catch(e){

      SnackBarService.showErrorSnackBar(
        "Something went wrong",
      );

    } finally{
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {

    try{

      isResending.value = true;

      await apiHelper.post(
        '/mobile/resend-otp',
        data: {
          "email" : email,
        },
      );

      SnackBarService.showSuccessSnackBar(
        "OTP resent successfully",
      );

    } catch(e){

      SnackBarService.showErrorSnackBar(
        "Failed to resend OTP",
      );

    } finally{
      isResending.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}