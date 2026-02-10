// features/profile/presentation/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/app_bar/custom_app_bar.dart';
import '../../model/profile_model.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // final ProfileController controller = Get.find<ProfileController>();
  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.white,
      appBar: DBAppBar(title: "Profile", isLeadingWidget: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                // Profile Header
                _buildProfileHeader(),
                SizedBox(height: 16.h),

                // Stats Section
                _buildStatsSection(),
                SizedBox(height: 24.h),

                // Personal Details Section
                _buildSectionTitle('Personal Details'),
                _buildPersonalDetails(),
                SizedBox(height: 24.h),

                // Company Details Section
                _buildSectionTitle('Company Details'),
                _buildCompanyDetails(),
                SizedBox(height: 24.h),

                // Bank Details Section
                _buildSectionTitle('Bank Account Details'),
                _buildBankDetails(),
                SizedBox(height: 32.h),

                // Logout Button
                _buildLogoutButton(),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.colors.gray,
              image: DecorationImage(
                image: AssetImage(AppImages.LOGO),
                fit: BoxFit.values[1],
              ),
            ),
          ),
          SizedBox(width: 16.w),

          // Profile Info
          Expanded(
            child: Obx(() {
              final profile = controller.profile.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Edit Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            profile.employeeName,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            profile.designation,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed:(){
                          Get.toNamed(AppRoutes.editProfile);
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 20.w,
                          color: AppTheme.colors.blue,
                        ),
                      ),
                    ],
                  ),
                  // Designation


                  Divider(height: 14.h, thickness: 1),

                  // Email
                  Row(
                    children: [
                      Icon(Icons.email_outlined, size: 16.w, color: Colors.grey),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          profile.email,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Phone
                  Row(
                    children: [
                      Icon(Icons.phone_outlined, size: 16.w, color: Colors.grey),
                      SizedBox(width: 8.w),
                      Text(
                        profile.phoneNumber,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Obx(() {
      final profile = controller.profile.value;
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            // Leave balances
            _buildLeaveBalances(profile),
            SizedBox(height: 16.h),
            // Tickets summary
            _buildTicketsSummary(profile),
          ],
        ),
      );
    });
  }

  Widget _buildLeaveBalances(ProfileModel profile) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Leave Balance",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "${profile.totalLeaveBalance}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Leaves",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "${profile.totalLeaves}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTicketsSummary(ProfileModel profile) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Current Appraisal\nPeriod Leaves",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "${profile.currentAppraisalPeriodLeaves}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Tickets",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "${profile.totalTickets}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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

  Widget _buildPersonalDetails() {
    return Obx(() {
      final profile = controller.profile.value;
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            _buildDetailRow('Employee TIS', profile.employeeTIS),
            _buildDetailRow('Team Name', profile.teamName),
            _buildDetailRow('Father Name', profile.fatherName),
            _buildDetailRow('Mother Name', profile.motherName),
            _buildDetailRow('Address', profile.address, isMultiline: true),
            _buildDetailRow('Official Date of Birth', profile.officialDOB),
            // SizedBox(height: 16.h),
            // Text(
            //   'Official Date of Birth',
            //   style: TextStyle(
            //     fontSize: 14.sp,
            //     fontWeight: FontWeight.w600,
            //     color: Colors.grey[600],
            //   ),
            // ),
            // SizedBox(height: 8.h),
            // _buildDetailRow('', profile.officialDOB),

            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Blood Group',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        profile.bloodGroup,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        profile.gender,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            _buildDetailRow('Marital Status', profile.maritalStatus),
            _buildDetailRow('Aadhar Number', profile.aadharNumber),
            _buildDetailRow('PAN', profile.panNumber),
          ],
        ),
      );
    });
  }

  Widget _buildCompanyDetails() {
    return Obx(() {
      final profile = controller.profile.value;
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            _buildDetailRow('HR', profile.hrName),
            _buildDetailRow('Support Officer', profile.supportOfficer),
            _buildDetailRow('Date Of Joining', profile.dateOfJoining),
            _buildDetailRow('Next Appraisal Date', profile.nextAppraisalDate),
          ],
        ),
      );
    });
  }

  Widget _buildBankDetails() {
    return Obx(() {
      final profile = controller.profile.value;
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            _buildDetailRow('Account Holder Name', profile.accountHolderName),
            _buildDetailRow('Account Number', profile.accountNumber),
            _buildDetailRow('Bank Name', profile.bankName),
            _buildDetailRow('Bank Identifier Code', profile.bankIdentifierCode),
            _buildDetailRow('Branch Location', profile.branchLocation, isMultiline: true),
            _buildDetailRow('Tax Payer Id', profile.taxPayerId),
          ],
        ),
      );
    });
  }

  Widget _buildDetailRow(String label, String value, {bool isMultiline = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          if (label.isNotEmpty) SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            maxLines: isMultiline ? 3 : 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12.h),
          Divider(height: 1, color: Colors.grey[200]),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.showLogoutConfirmation,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.colors.blue,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Logout',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}