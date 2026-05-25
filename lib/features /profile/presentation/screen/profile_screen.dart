// features/profile/presentation/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.getProfileData();
    });
    return Scaffold(
      backgroundColor: AppTheme.colors.white,
      appBar: DBAppBar(title: "Profile", isLeadingWidget: false),
      body: Obx(() {
        if (controller.isLoading.value) {
          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
          return _buildProfileShimmer();
        }

        if (controller.profile.value == null) {
          return const Center(
            child: Text("No Profile Data Found"),
          );
        }
      return  SafeArea(
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
                  _buildLogoutButton(context),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );

      }),
    );
  }

  Widget _buildProfileHeader() {
    final employee = controller.profile.value?.data?.employee;
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
            width: 140.w,
            height: 110.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppTheme.colors.gray,
              image: employee?.profileImage != null &&
                  employee!.profileImage!.isNotEmpty
                  ? DecorationImage(
                image: NetworkImage(employee!.profileImage!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: employee?.profileImage == null ||
                employee!.profileImage!.isNotEmpty == false
                ? Center(
              child: SvgPicture.asset(
                AppIcons.PROFILE, // your svg image path
                width: 50.w,
                height: 50.h,
              ),
            )
                : null,
          ),
          SizedBox(width: 16.w),

          // Profile Info
          Expanded(
            child: Obx(() {
              final profile = controller.profile.value?.data;
              final employee = profile?.employee;
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
              "${employee?.name ?? ""} ${employee?.lastName ?? ""}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                          employee?.teamName ?? "",
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
              employee?.email ?? "",
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
              employee?.phone ?? "",
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
      final profile = controller.profile.value?.data;
      return Column(
        children: [
          // Leave balances
          _buildLeaveBalances(profile),
          SizedBox(height: 16.h),
          // Tickets summary
          _buildTicketsSummary(profile),
        ],
      );
    });
  }

  Widget _buildLeaveBalances(Data? profile){
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    "${profile?.totalEarnLeave ?? 0}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.blue,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    "${profile?.totalLeaves ?? 0}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTicketsSummary(Data? profile) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Current Appraisal\nPeriod Leaves",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 8.w),
                Text(
                  "${profile?.totalLeavesAppraisal ?? 0}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.blue,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  "${profile?.totalTickets ?? 0}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.blue,
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
      final employee = controller.profile.value?.data?.employee;
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            _buildDetailRow('Employee TIS', employee?.tisId ?? ""),
            _buildDetailRow('Team Name', employee?.teamName ?? ""),
            _buildDetailRow('Father Name', employee?.fatherName ?? ""),
            _buildDetailRow('Mother Name',employee?.motherName ?? ""),
            _buildDetailRow('Address', employee?.address ?? "", isMultiline: true),
            _buildDetailRow('Official Date of Birth', employee?.officialDob?.toString().split(" ").first ?? ""),
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
                        employee?.bloodGroup ?? "",
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
                        employee?.gender ?? "",
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
            _buildDetailRow('Marital Status', employee?.maritalStatus ?? ""),
            _buildDetailRow('Aadhar Number', employee?.aadharNumber ?? ""),
            _buildDetailRow('PAN', employee?.panCard ?? ""),
          ],
        ),
      );
    });
  }

  Widget _buildCompanyDetails() {
    return Obx(() {
      final employee = controller.profile.value?.data?.employee;
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            // _buildDetailRow('HR', profile.hrName),
            // _buildDetailRow('Support Officer', profile.supportOfficer),
            _buildDetailRow('Date Of Joining', employee?.companyDoj?.toString().split(" ").first ?? ""),
            _buildDetailRow('Next Appraisal Date', employee?.nextApprisalDate?.toString().split(" ").first ?? ""),
          ],
        ),
      );
    });
  }

  Widget _buildBankDetails() {
    return Obx(() {
      final employee = controller.profile.value?.data?.employee;
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            _buildDetailRow('Account Holder Name', employee?.accountHolderName ?? ""),
            _buildDetailRow('Account Number', employee?.accountNumber ?? ""),
            _buildDetailRow('Bank Name', employee?.bankName ?? ""),
            _buildDetailRow('Bank Identifier Code', employee?.bankIdentifierCode ?? ""),
            _buildDetailRow('Branch Location', employee?.branchLocation ?? "", isMultiline: true),
            _buildDetailRow('Tax Payer Id', employee?.taxPayerId?.toString() ?? ""),
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

  Widget _buildLogoutButton(context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          controller.showLogoutConfirmation(context);
        },
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

  Widget _buildProfileShimmer() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              children: [

                /// PROFILE HEADER
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [

                      Container(
                        width: 140.w,
                        height: 110.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),

                      SizedBox(width: 16.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              height: 18.h,
                              width: 140.w,
                              color: Colors.white,
                            ),

                            SizedBox(height: 10.h),

                            Container(
                              height: 14.h,
                              width: 100.w,
                              color: Colors.white,
                            ),

                            SizedBox(height: 20.h),

                            Container(
                              height: 14.h,
                              width: double.infinity,
                              color: Colors.white,
                            ),

                            SizedBox(height: 12.h),

                            Container(
                              height: 14.h,
                              width: 160.w,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                /// STATS
                Row(
                  children: [
                    Expanded(child: _buildStatsShimmer()),
                    SizedBox(width: 12.w),
                    Expanded(child: _buildStatsShimmer()),
                  ],
                ),

                SizedBox(height: 12.h),

                Row(
                  children: [
                    Expanded(child: _buildStatsShimmer()),
                    SizedBox(width: 12.w),
                    Expanded(child: _buildStatsShimmer()),
                  ],
                ),

                SizedBox(height: 24.h),

                /// PERSONAL DETAILS
                _buildSectionShimmer(),

                SizedBox(height: 24.h),

                /// COMPANY DETAILS
                _buildSectionShimmer(),

                SizedBox(height: 24.h),

                /// BANK DETAILS
                _buildSectionShimmer(),

                SizedBox(height: 32.h),

                /// BUTTON
                Container(
                  width: double.infinity,
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsShimmer() {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 14.h,
            width: 100.w,
            color: Colors.white,
          ),

          SizedBox(height: 12.h),

          Container(
            height: 18.h,
            width: 40.w,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          width: double.infinity,
          height: 45.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),

        SizedBox(height: 16.h),

        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: List.generate(
              6,
                  (index) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      height: 14.h,
                      width: 120.w,
                      color: Colors.white,
                    ),

                    SizedBox(height: 8.h),

                    Container(
                      height: 16.h,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}