// features/profile/presentation/controllers/edit_profile_controller.dart

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/edit_profile_model.dart';

class EditProfileController extends GetxController {
  final Rx<EditProfileModel> currentProfile = EditProfileModel().obs;
  final Rx<EditProfileModel> editedProfile = EditProfileModel().obs;

  final RxBool isLoading = false.obs;
  final RxString selectedImagePath = ''.obs;
  final Rx<File?> profileImageFile = Rx<File?>(null);

  // Original profile to track changes
  late EditProfileModel originalProfile;

  @override
  void onInit() {
    super.onInit();
    // In real app, load from API
    _loadProfileData();
  }

  void _loadProfileData() {
    // For demo, using default data
    currentProfile.value = EditProfileModel();
    editedProfile.value = EditProfileModel();
    originalProfile = EditProfileModel();
  }

  void updateField(String fieldName, String value) {
    editedProfile.value = editedProfile.value.copyWith(
      // Personal Details
      motherName: fieldName == 'motherName' ? value : editedProfile.value.motherName,
      phone: fieldName == 'phone' ? value : editedProfile.value.phone,
      height: fieldName == 'height' ? value : editedProfile.value.height,
      weight: fieldName == 'weight' ? value : editedProfile.value.weight,
      alternateContact: fieldName == 'alternateContact' ? value : editedProfile.value.alternateContact,
      emergencyContact: fieldName == 'emergencyContact' ? value : editedProfile.value.emergencyContact,
      emergencyContactPerson: fieldName == 'emergencyContactPerson' ? value : editedProfile.value.emergencyContactPerson,
      maritalStatus: fieldName == 'maritalStatus' ? value : editedProfile.value.maritalStatus,
      passportNumber: fieldName == 'passportNumber' ? value : editedProfile.value.passportNumber,
      temporaryAddress: fieldName == 'temporaryAddress' ? value : editedProfile.value.temporaryAddress,

      // Social Profiles
      techinfiniSkypeId: fieldName == 'techinfiniSkypeId' ? value : editedProfile.value.techinfiniSkypeId,
      facebookUrl: fieldName == 'facebookUrl' ? value : editedProfile.value.facebookUrl,
      twitterUrl: fieldName == 'twitterUrl' ? value : editedProfile.value.twitterUrl,
      googlePlusUrl: fieldName == 'googlePlusUrl' ? value : editedProfile.value.googlePlusUrl,
      linkedInUrl: fieldName == 'linkedInUrl' ? value : editedProfile.value.linkedInUrl,
    );
  }

  Future<void> pickProfileImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        profileImageFile.value = file;
        selectedImagePath.value = file.path;
        editedProfile.value = editedProfile.value.copyWith(
          profileImagePath: file.path,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool get hasChanges {
    return editedProfile.value.hasChanges(originalProfile) ||
        profileImageFile.value != null;
  }

  Future<void> updateProfile() async {
    if (!hasChanges) {
      Get.snackbar(
        'No Changes',
        'No changes detected to update',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Update current profile with edited values
      currentProfile.value = editedProfile.value;

      // Update original profile to new state
      originalProfile = editedProfile.value.copyWith();

      // Reset image file
      profileImageFile.value = null;

      Get.back();
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetChanges() {
    editedProfile.value = originalProfile.copyWith();
    profileImageFile.value = null;
    selectedImagePath.value = '';
  }

  // Helper method to check if field is editable
  bool isFieldEditable(String fieldName) {
    final editableFields = [
      'motherName',
      'phone',
      'height',
      'weight',
      'alternateContact',
      'emergencyContact',
      'emergencyContactPerson',
      'maritalStatus',
      'passportNumber',
      'temporaryAddress',
      'techinfiniSkypeId',
      'facebookUrl',
      'twitterUrl',
      'googlePlusUrl',
      'linkedInUrl',
    ];

    return editableFields.contains(fieldName);
  }
}