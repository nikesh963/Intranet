// features/profile/presentation/controllers/edit_profile_controller.dart

import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Common/CommonSnackBar.dart';
import '../../../../../Common/dataBaseHelper/SharedPrefHelper.dart';
import '../../../../../Common/helper/ApiHelper.dart';
import '../../../model/profile_model.dart';
import '../../../presentation/controller/profile_controller.dart';


class EditProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper();

  final Rx<Employee?> employee = Rx<Employee?>(null);
  final ProfileController profileController =
  Get.find<ProfileController>();
  final RxBool isLoading = false.obs;

  final RxString selectedImagePath = ''.obs;
  final Rx<File?> profileImageFile = Rx<File?>(null);

  /// Controllers
  final TextEditingController motherNameController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  final TextEditingController heightController =
  TextEditingController();

  final TextEditingController weightController =
  TextEditingController();

  final TextEditingController alternateContactController =
  TextEditingController();

  final TextEditingController emergencyContactController =
  TextEditingController();

  final TextEditingController emergencyPersonController =
  TextEditingController();

  final TextEditingController passportController =
  TextEditingController();

  final TextEditingController temporaryAddressController =
  TextEditingController();

  final TextEditingController skypeController =
  TextEditingController();

  final TextEditingController facebookController =
  TextEditingController();

  final TextEditingController twitterController =
  TextEditingController();

  final TextEditingController googleController =
  TextEditingController();

  final TextEditingController linkedinController =
  TextEditingController();

  final RxString maritalStatus = ''.obs;

  String originalData = '';

  @override
  void onInit() {
    super.onInit();
    loadProfileData();

    /// TEXTFIELD LISTENERS
    motherNameController.addListener(checkForChanges);
    phoneController.addListener(checkForChanges);
    heightController.addListener(checkForChanges);
    weightController.addListener(checkForChanges);
    alternateContactController.addListener(checkForChanges);
    emergencyContactController.addListener(checkForChanges);
    emergencyPersonController.addListener(checkForChanges);
    passportController.addListener(checkForChanges);
    temporaryAddressController.addListener(checkForChanges);
    skypeController.addListener(checkForChanges);
    facebookController.addListener(checkForChanges);
    twitterController.addListener(checkForChanges);
    googleController.addListener(checkForChanges);
    linkedinController.addListener(checkForChanges);

    /// RX LISTENERS
    ever(maritalStatus, (_) => checkForChanges());
    ever(selectedImagePath, (_) => checkForChanges());

  }

  Future<void> loadProfileData() async {
    try {
      isLoading.value = true;

      final employeeEncId =
      await SharedPrefHelper.getEmployeeEncId();

      final response = await _apiHelper.get(
        "/mobile/employee/$employeeEncId",
      );

      final profile = Profile.fromJson(response.data);

      employee.value = profile.data?.employee;

      final emp = employee.value;

      if (emp == null) return;

      motherNameController.text = emp.motherName ?? '';
      phoneController.text = emp.phone ?? '';
      heightController.text = emp.height ?? '';
      weightController.text = emp.weight ?? '';
      alternateContactController.text =
          emp.alternateContactNumber?.toString() ?? '';
      emergencyContactController.text =
          emp.emergencyContactNumber ?? '';
      emergencyPersonController.text =
          emp.emergencyContactPersonName ?? '';
      passportController.text =
          emp.passportNumber ?? '';
      temporaryAddressController.text =
          emp.temporaryAddress ?? '';
      skypeController.text =
          emp.skypeId?.toString() ?? '';
      facebookController.text =
          emp.facebookProfileUrl?.toString() ?? '';
      twitterController.text =
          emp.twitterProfileUrl?.toString() ?? '';
      googleController.text =
          emp.googlePlusProfileUrl?.toString() ?? '';
      linkedinController.text =
          emp.linkedinProfileUrl?.toString() ?? '';

      maritalStatus.value = emp.maritalStatus ?? '';

      originalData = _generateCurrentDataString();
      checkForChanges();
    } catch (e) {
      debugPrint("PROFILE LOAD ERROR => $e");

      // Get.snackbar(
      //   "Error",
      //   "Failed to load profile",
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
      SnackBarService.showErrorSnackBar(
        "Failed to load profile",
      );
    } finally {
      isLoading.value = false;
    }
  }

  String _generateCurrentDataString() {
    return '''
${motherNameController.text}
${phoneController.text}
${heightController.text}
${weightController.text}
${alternateContactController.text}
${emergencyContactController.text}
${emergencyPersonController.text}
${passportController.text}
${temporaryAddressController.text}
${skypeController.text}
${facebookController.text}
${twitterController.text}
${googleController.text}
${linkedinController.text}
${maritalStatus.value}
${selectedImagePath.value}
''';
  }

  // bool get hasChanges {
  //   return originalData != _generateCurrentDataString();
  // }

  final RxBool hasChanges = false.obs;
  void checkForChanges() {
    hasChanges.value =
        originalData != _generateCurrentDataString();
  }
  Future<void> pickProfileImage() async {
    try {
      FilePickerResult? result =
      await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        File file = File(result.files.single.path!);

        profileImageFile.value = file;
        selectedImagePath.value = file.path;
      }
    } catch (e) {
      // Get.snackbar(
      //   "Error",
      //   "Failed to pick image",
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
      SnackBarService.showErrorSnackBar(
        "Failed to pick image",
      );
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      final int? employeeId = employee.value?.id;

      if (employeeId == null) {
        // Get.snackbar(
        //   "Error",
        //   "Employee ID not found",
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        // );
        SnackBarService.showErrorSnackBar(
          "Employee ID not found",
        );
        return;
      }

      dio.FormData formData = dio.FormData.fromMap({
        "mother_name": motherNameController.text,
        "phone": phoneController.text,
        "height": heightController.text,
        "weight": weightController.text,
        "alternate_contact_number":
        alternateContactController.text,
        "emergency_contact_number":
        emergencyContactController.text,
        "emergency_contact_person_name":
        emergencyPersonController.text,
        "marital_status": maritalStatus.value,
        "passport_number": passportController.text,
        "temporary_address":
        temporaryAddressController.text,
        "skype_id": skypeController.text,
        "facebook_profile_url":
        facebookController.text,
        "twitter_profile_url":
        twitterController.text,
        "google_plus_profile_url":
        googleController.text,
        "linkedin_profile_url":
        linkedinController.text,
      });

      /// Profile Image
      if (profileImageFile.value != null) {
        formData.files.add(
          MapEntry(
            "profile_image",
            await dio.MultipartFile.fromFile(
              profileImageFile.value!.path,
              filename:
              profileImageFile.value!.path.split('/').last,
            ),
          ),
        );
      }

      final response = await _apiHelper.postFormData(
        "/mobile/employee/$employeeId/update-profile",
        formData,
      );

      debugPrint("UPDATE RESPONSE => ${response.data}");

      originalData = _generateCurrentDataString();
      await profileController.getProfileData();
      Get.back();

      // Get.snackbar(
      //   "Success",
      //   "Profile updated successfully",
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
      SnackBarService.showSuccessSnackBar(
        "Profile updated successfully",
      );
    } catch (e) {
      debugPrint("UPDATE ERROR => $e");

      // Get.snackbar(
      //   "Error",
      //   "Failed to update profile",
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
      SnackBarService.showErrorSnackBar(
        "Failed to update profile",
      );
    } finally {
      isLoading.value = false;
    }
  }
}