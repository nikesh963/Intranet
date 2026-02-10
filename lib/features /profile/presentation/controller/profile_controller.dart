
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/profile_model.dart';

class ProfileController extends GetxController {
  final Rx<ProfileModel> profile = ProfileModel().obs;

  final RxBool isLoading = false.obs;
  final RxBool isEditing = false.obs;

  @override
  void onInit() {
    super.onInit();
    // In real app, you would fetch profile data from API here
    // _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    isLoading.value = true;
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));

      // Update with real data from API
      profile.value = ProfileModel(
        // Set data from API response
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load profile data',
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

  void showLogoutConfirmation() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        _performLogout();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  void _performLogout() {
    // Perform logout logic here
    // Clear tokens, navigate to login, etc.
    Get.offAllNamed('/login'); // Adjust based on your routing
    Get.snackbar(
      'Success',
      'Logged out successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // Future method to update profile (for when editing is implemented)
  Future<void> updateProfile(ProfileModel updatedProfile) async {
    isLoading.value = true;
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));

      profile.value = updatedProfile;
      isEditing.value = false;

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}