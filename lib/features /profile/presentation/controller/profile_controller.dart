import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Common/dataBaseHelper/SharedPrefHelper.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../model/profile_model.dart';

class ProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper();

  final Rx<Profile?> profile = Rx<Profile?>(null);

  final RxBool isLoading = false.obs;
  final RxBool isEditing = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  Future<void> getProfileData() async {
    try {
      isLoading.value = true;

      /// Get employee enc id from local storage
      final employeeEncId = await SharedPrefHelper.getEmployeeEncId();

      if (employeeEncId.isEmpty) {
        Get.snackbar(
          "Error",
          "Employee ID not found",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      /// API Call
      final response = await _apiHelper.get(
        "/mobile/employee/$employeeEncId",
      );

      /// Parse Response
      profile.value = Profile.fromJson(response.data);

      debugPrint("PROFILE RESPONSE => ${response.data}");
    } catch (e) {
      debugPrint("PROFILE ERROR => $e");

      Get.snackbar(
        "Error",
        "Failed to load profile",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleEditMode() {
    isEditing.value = !isEditing.value;
  }

  void showLogoutConfirmation(BuildContext context) {
    SharedPrefHelper.clearLoginDetails(context);
  }

  void _performLogout() {
    Get.offAllNamed('/login');

    Get.snackbar(
      'Success',
      'Logged out successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}