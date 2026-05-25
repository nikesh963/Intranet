// features/profile/presentation/screens/edit_profile_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widget/app_bar/custom_app_bar.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  // final EditProfileController controller = Get.put(EditProfileController());
  final EditProfileController controller = Get.find<EditProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.white,
      appBar: DBAppBar(
        title: "Edit Profile",
        isLeadingWidget: false,
        // leadingCallback: () {
        //   if (controller.hasChanges) {
        //     _showDiscardChangesDialog();
        //   } else {
        //     Get.back();
        //   }
        // },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            final profile = controller.employee.value;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  // Profile Image Section
                  _buildProfileImageSection(),
                  SizedBox(height: 24.h),

                  // Name Section (Non-editable)
                  _buildSectionTitle('Name'),
                  _buildNonEditableRow('First Name', profile?.name ?? ''),
                  _buildNonEditableRow('Last Name', profile?.lastName ?? ''),

                  SizedBox(height: 24.h),

                  // Personal Details Section
                  _buildSectionTitle('Personal Details'),
                  _buildNonEditableRow('Employee TIS', profile?.tisId ?? ''),
                  _buildNonEditableRow('Team Name', profile?.teamName ?? ''),
                  _buildNonEditableRow(
                    'Father Name',
                    profile?.fatherName ?? "",
                  ),
                  _buildEditableTextField(
                    label: 'Mother Name',
                    controller: controller.motherNameController,
                  ),
                  _buildEditableTextField(
                    label: 'Phone',
                    controller: controller.phoneController,
                  ),
                  _buildNonEditableRow('Personal Email Id', profile?.personalEmail ?? ''),
                  _buildNonEditableRow(
                    'Official Date of Birth*',
                    profile?.officialDob?.toString().split(" ").first ?? "",
                  ),
                  _buildNonEditableRow('Blood Group', profile?.bloodGroup ?? ''),
                  _buildEditableTextField(
                    label: 'Height',
                    controller: controller.heightController,
                  ),
                  _buildEditableTextField(
                    label: 'Weight',
                    controller: controller.weightController,
                  ),
                  _buildNonEditableRow('Aadhar Number', profile?.aadharNumber??""),
                  // _buildEditableTextField('Alternate Contact Number', profile.alternateContact, 'alternateContact'),
                  // _buildEditableTextField('Emergency Contact Number', profile.emergencyContact, 'emergencyContact'),
                  // _buildEditableTextField('Emergency Contact Person Name', profile.emergencyContactPerson, 'emergencyContactPerson'),
                  _buildNonEditableRow('Gender', profile?.gender??""),
                  _buildEditableDropdown(),
                  _buildNonEditableRow('PAN', profile?.panCard ?? ''),
                  // _buildEditableTextField('Passport Number', profile.passportNumber, 'passportNumber'),
                  _buildNonEditableRow('Election Card Number', profile?.electionCardNumber??""),
                  _buildNonEditableRow('Driving Licence Number', profile?.drivingLicenceNumber ?? ''),
                  _buildNonEditableRow('Permanent Address',profile?.address ?? '', isMultiline: true),
                  _buildEditableTextField(
                    label: 'Temporary Address',
                    controller: controller.temporaryAddressController,
                    isMultiline: true,
                  ),

                  SizedBox(height: 24.h),

                  // Company Details Section
                  _buildSectionTitle('Company Details'),
                  // _buildNonEditableRow('HR', profile.hrName),
                  // _buildNonEditableRow('Support Officer', profile.supportOfficer),
                  // _buildNonEditableRow('Designation', profile.designation),
                  _buildNonEditableRow(
                    'Date Of Joining',
                    profile?.companyDoj?.toString().split(" ").first ?? "",
                  ),
                  _buildNonEditableRow(
                    'Previous Appraisal Due',
                    profile?.prevApprisalDate?.toString().split(" ").first ?? "",
                  ),
                  _buildNonEditableRow(
                    'Next Appraisal Due',
                    profile?.nextApprisalDate?.toString().split(" ").first ?? "",
                  ),
                  _buildNonEditableRow(
                    'Allowed leaves',
                    profile?.allowedApprisalPeriodLeaves?.toString() ?? "",
                  ),

                  SizedBox(height: 24.h),

                  // Bank Account Details Section
                  _buildSectionTitle('Bank Account Details'),
                  _buildNonEditableRow('Account Holder Name', profile?.accountHolderName??""),
                  _buildNonEditableRow('Account Number', profile?.accountNumber??""),
                  _buildNonEditableRow('Bank Name', profile?.bankName??""),
                  _buildNonEditableRow('Bank Identifier Code', profile?.bankIdentifierCode??""),
                  _buildNonEditableRow('Branch Location', profile?.branchLocation??"", isMultiline: true),
                  _buildNonEditableRow('Tax Payer Id', profile?.taxPayerId??""),

                  SizedBox(height: 24.h),

                  // Social Profiles Section
                  // _buildSectionTitle('Social Profiles'),
                  // _buildEditableTextField('TechInfini Skype ID', profile.techinfiniSkypeId, 'techinfiniSkypeId'),
                  // _buildEditableTextField('Facebook Profile URL', profile.facebookUrl, 'facebookUrl'),
                  // _buildEditableTextField('Twitter Profile URL', profile.twitterUrl, 'twitterUrl'),
                  // _buildEditableTextField('Google Plus Profile URL', profile.googlePlusUrl, 'googlePlusUrl'),
                  // _buildEditableTextField('LinkedIn Profile URL', profile.linkedInUrl, 'linkedInUrl'),

                  SizedBox(height: 32.h),

                  // Update Button
                  _buildUpdateButton(),
                  SizedBox(height: 16.h),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildProfileImageSection() {
    return Center(
      child: Stack(
        children: [
          Obx(() {
            final imagePath = controller.selectedImagePath.value;
            final profile = controller.employee.value;


            Widget imageWidget;

            if (imagePath.isNotEmpty) {
              imageWidget = ClipRRect(
                borderRadius: BorderRadius.circular(75.r),
                child: Image.file(
                  File(imagePath),
                  width: 150.w,
                  height: 150.h,
                  fit: BoxFit.cover,
                ),
              );
            } else if ((profile?.profileImage ?? '').isNotEmpty) {
              imageWidget = ClipRRect(
                borderRadius: BorderRadius.circular(75.r),
                child: Image.network(
                  profile!.profileImage!,
                  width: 150.w,
                  height: 150.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Icon(
                      Icons.person,
                      size: 60.w,
                      color: Colors.white,
                    );
                  },
                ),
              );
            }else {
              imageWidget = Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.colors.gray,
                ),
                child: Icon(
                  Icons.person,
                  size: 60.w,
                  color: Colors.white,
                ),
              );
            }

            return Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.colors.blue,
                  width: 3.w,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75.r),
                child: imageWidget,
              ),
            );
          }),

          // Camera Icon Button
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: controller.pickProfileImage,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppTheme.colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3.w,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 20.w,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppTheme.colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppTheme.colors.blue,
        ),
      ),
    );
  }

  Widget _buildNonEditableRow(String label, String value, {bool isMultiline = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
              maxLines: isMultiline ? 3 : 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableTextField({
    required String label,
    required TextEditingController controller,
    bool isMultiline = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
          TextField(
            controller: controller,
            maxLines: isMultiline ? 3 : 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              contentPadding: EdgeInsets.all(12.w),
            ),
            // onChanged: (_) {
            //   controller.selection = controller.selection;
            // },
          ),
        ],
      ),
    );
  }
  Widget _buildEditableDropdown() {
    final List<String> maritalOptions = [
      'Single',
      'Married',
      'Divorced',
      'Widowed',
      'Unmarried',
    ];

    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Marital Status",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 4.h),

            PopupMenuButton<String>(
              color: Colors.white,
              offset: Offset(0, 5.h),

              constraints: BoxConstraints(
                minWidth: 150.w,
                maxWidth: 300.w,
                maxHeight: 300.h,
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),

              elevation: 8,

              menuPadding: EdgeInsets.all(12.w),

              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 14.h,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.maritalStatus.value.isNotEmpty
                          ? controller.maritalStatus.value
                          : 'Select Marital Status',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color:
                        controller.maritalStatus.value.isNotEmpty
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),

                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),

              itemBuilder: (BuildContext context) {
                return maritalOptions.map((status) {
                  return PopupMenuItem<String>(
                    value: status,

                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),

                    child: Text(status),
                  );
                }).toList();
              },

              onSelected: (String value) {
                controller.maritalStatus.value = value;
              },
            ),
          ],
        ),
      );
    });
  }
  Widget _buildUpdateButton() {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          // onPressed: controller.hasChanges && !controller.isLoading.value
          // onPressed: !controller.isLoading.value
          //     ? () => controller.updateProfile()
          //     : null,
          onPressed: controller.hasChanges.value &&
              !controller.isLoading.value
              ? () => controller.updateProfile()
              : null,
          style: ElevatedButton.styleFrom(
            // backgroundColor: controller.hasChanges ? AppTheme.colors.blue : Colors.grey[400],
            backgroundColor: controller.hasChanges.value
                ? AppTheme.colors.blue
                : Colors.grey[400],
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
          ),
          child: controller.isLoading.value
              ? SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              : Text(
            'Update Profile',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }

  void _showDiscardChangesDialog() {
    Get.defaultDialog(
      title: 'Discard Changes?',
      middleText: 'You have unsaved changes. Are you sure you want to discard them?',
      textConfirm: 'Discard',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        // controller.resetChanges();
        Get.back();
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}