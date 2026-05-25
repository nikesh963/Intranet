// import 'dart:developer';
// import 'package:get/get.dart';
// import '../../../../Common/helper/ApiHelper.dart';
// import '../../../../core/constants/icons.dart';
// import '../../../../core/network/network_info.dart';
// import '../../model/home_model.dart';
//
// class HomeController extends GetxController {
//
//   final RxInt selectedTab = 0.obs;
//   var currentBannerIndex = 0.obs;
//
//   // Banner images
//   final List<String> bannerImages = [
//    AppImages.LOGO,
//    AppImages.LOGO,
//    AppImages.LOGO,
//     // AppImages.BANNER,
//     // AppImages.BANNER,
//   ];
//   final RxList<LeaveTicket> leaveTickets = <LeaveTicket>[
//     LeaveTicket(
//       employee: 'John Doe',
//       ro: 'RO001',
//       leaveType: 'Loss Of Pay(LOP)',
//       appliedOn: '2023-12-15',
//       startDate: '2023-12-20',
//       endDate: '2023-12-22',
//       totalDays: '3',
//       status: 'Approved',
//       lastUpdatedBy: 'Admin',
//     ),
//     LeaveTicket(
//       employee: 'Jane Smith',
//       ro: 'RO002',
//       leaveType: 'Loss Of Pay(LOP)',
//       appliedOn: '2023-12-14',
//       startDate: '2023-12-16',
//       endDate: '2023-12-17',
//       totalDays: '2',
//       status: 'Pending',
//       lastUpdatedBy: 'Manager',
//     ),
//     LeaveTicket(
//       employee: 'Bob Johnson',
//       ro: 'RO003',
//       leaveType: 'Earned',
//       appliedOn: '2023-12-10',
//       startDate: '2023-12-25',
//       endDate: '2023-12-31',
//       totalDays: '7',
//       status: 'Approved',
//       lastUpdatedBy: 'HR',
//     ),
//     LeaveTicket(
//       employee: 'Alice Brown',
//       ro: 'RO004',
//       leaveType: 'Earned',
//       appliedOn: '2023-12-01',
//       startDate: '2024-01-01',
//       endDate: '2024-04-01',
//       totalDays: '90',
//       status: 'Approved',
//       lastUpdatedBy: 'HR Manager',
//     ),
//     LeaveTicket(
//       employee: 'Charlie Wilson',
//       ro: 'RO005',
//       leaveType: 'Earned',
//       appliedOn: '2023-12-18',
//       startDate: '2023-12-19',
//       endDate: '2023-12-19',
//       totalDays: '1',
//       status: 'Rejected',
//       lastUpdatedBy: 'Supervisor',
//     ),
//     LeaveTicket(
//       employee: 'David Miller',
//       ro: 'RO006',
//       leaveType: 'Earned',
//       appliedOn: '2023-12-12',
//       startDate: '2023-12-28',
//       endDate: '2023-12-29',
//       totalDays: '2',
//       status: 'Pending',
//       lastUpdatedBy: 'Team Lead',
//     ),
//     LeaveTicket(
//       employee: 'Eva Davis',
//       ro: 'RO007',
//       leaveType: 'Earned',
//       appliedOn: '2023-12-05',
//       startDate: '2024-01-15',
//       endDate: '2024-01-30',
//       totalDays: '16',
//       status: 'Approved',
//       lastUpdatedBy: 'HR',
//     ),
//     LeaveTicket(
//       employee: 'Frank Thomas',
//       ro: 'RO008',
//       leaveType: 'Earned',
//       appliedOn: '2023-12-16',
//       startDate: '2023-12-18',
//       endDate: '2023-12-20',
//       totalDays: '3',
//       status: 'Approved',
//       lastUpdatedBy: 'Manager',
//     ),
//   ].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
// }
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Common/AppLogger.dart';
import '../../../../Common/CommonSnackBar.dart';
import '../../../../Common/dataBaseHelper/SharedPrefHelper.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/network/network_info.dart';
import '../../model/home_model.dart';
import '../../model/profile_model.dart';

class HomeController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper();
  final NetworkInfo networkInfo = Get.find<NetworkInfo>();

  final RxInt selectedTab = 0.obs;
  var currentBannerIndex = 0.obs;

  // Loading states
  final isLoading = false.obs;
  final isLeaveTicketsLoading = false.obs;

  // Employee Profile Data
  final employeeProfile = Rxn<EmployeeProfile>();
  final employeeData = Rxn<Data>();
  final employeeDetails = Rxn<Employee>();
  final userDetails = Rxn<User>();

  // Summary Data
  final totalEarnLeave = 0.0.obs;
  final totalLeaves = 0.0.obs;
  final totalLeavesAppraisal = 0.0.obs;
  final totalTickets = 0.obs;

  // Recent Leaves List
  final recentLeaves = <RecentLeaf>[].obs;

  // Banner images (static for now)
  final List<String> bannerImages = [
    AppImages.LOGO,
    AppImages.LOGO,
    AppImages.LOGO,
  ];

  // Employee enc ID (will be fetched from SharedPreferences after login)
  String employeeEncId = '';

  @override
  void onInit() {
    super.onInit();
    _loadEmployeeEncId();
  }

  @override
  void onReady() {
    super.onReady();
    fetchEmployeeProfile();
  }

  // Load employee encrypted ID from SharedPreferences
  Future<void> _loadEmployeeEncId() async {
    try {
      employeeEncId = await SharedPrefHelper.getEmployeeEncId();
      AppLogger.debug("📱 Loaded Employee Enc ID: $employeeEncId");

      if (employeeEncId.isNotEmpty) {
        fetchEmployeeProfile();
      } else {
        AppLogger.error("❌ Employee Enc ID not found");
        // Optionally navigate back to login
      }
    } catch (e) {
      AppLogger.error("❌ Error loading employee enc ID: $e");
    }
  }

  // Fetch Employee Profile Data
  Future<void> fetchEmployeeProfile() async {
    if (employeeEncId.isEmpty) {
      AppLogger.error("❌ Cannot fetch profile: Employee Enc ID is empty");
      return;
    }

    isLoading.value = true;

    try {
      // Check network connectivity
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        SnackBarService.showErrorSnackBar('No internet connection');
        isLoading.value = false;
        return;
      }

      final response = await _apiHelper.get(
        '/mobile/employee/$employeeEncId',
      );

      AppLogger.debug("📥 Employee Profile Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        // Check if success is true
        final isSuccess = responseData['success'] == true;

        if (isSuccess) {
          // Parse the response
          final employeeProfileData = EmployeeProfile.fromJson(responseData);
          employeeProfile.value = employeeProfileData;

          if (employeeProfileData.data != null) {
            final data = employeeProfileData.data!;
            employeeData.value = data;

            // Set summary data
            totalEarnLeave.value = data.totalEarnLeave ?? 0;
            totalLeaves.value = data.totalLeaves ?? 0;
            totalLeavesAppraisal.value = data.totalLeavesAppraisal ?? 0;
            totalTickets.value = data.totalTickets ?? 0;

            // Set employee details
            employeeDetails.value = data.employee;
            userDetails.value = data.user;

            // Set recent leaves
            if (data.recentLeaves != null && data.recentLeaves!.isNotEmpty) {
              recentLeaves.value = data.recentLeaves!;
              AppLogger.debug("📋 Recent Leaves Count: ${recentLeaves.length}");
            } else {
              recentLeaves.clear();
              AppLogger.debug("📋 No recent leaves found");
            }

            // Save additional user data to SharedPreferences if needed
            await _saveAdditionalUserData(data);

            AppLogger.debug("✅ Employee profile fetched successfully");
            AppLogger.debug("📊 Total Earn Leave: ${totalEarnLeave.value}");
            AppLogger.debug("📊 Total Leaves: ${totalLeaves.value}");
            AppLogger.debug("📊 Total Tickets: ${totalTickets.value}");
          }
        } else {
          final errorMessage = responseData['message']?.toString() ?? 'Failed to load profile';
          SnackBarService.showErrorSnackBar(errorMessage);
          AppLogger.error("❌ API returned success=false: $errorMessage");
        }
      } else {
        SnackBarService.showErrorSnackBar('Failed to load profile data');
        AppLogger.error("❌ HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      AppLogger.error("❌ Error fetching employee profile: $e");
      SnackBarService.showErrorSnackBar('Failed to load profile data');
    } finally {
      isLoading.value = false;
    }
  }

  // Save additional user data to SharedPreferences
  Future<void> _saveAdditionalUserData(Data data) async {
    try {
      // Save employee details if needed
      if (data.employee != null) {
        final emp = data.employee!;
        await SharedPrefHelper.saveUserName(emp.name ?? '');
        // await SharedPrefHelper.saveUserEmail(emp.email ?? '');
        await SharedPrefHelper.saveUserRole(data.user?.type ?? '');

        // Save department and designation if needed
        // Add these methods to SharedPrefHelper if you need them
      }

      AppLogger.debug("💾 Additional user data saved");
    } catch (e) {
      AppLogger.error("❌ Error saving additional user data: $e");
    }
  }

  // Refresh data (pull to refresh)
  Future<void> refreshData() async {
    AppLogger.debug("🔄 Refreshing employee profile data");
    await fetchEmployeeProfile();
  }

  // Get employee name
  String getEmployeeName() {
    if (employeeDetails.value != null) {
      return employeeDetails.value!.name ?? 'User';
    }
    if (userDetails.value != null) {
      return userDetails.value!.name ?? 'User';
    }
    return 'User';
  }

  // Get employee email
  String getEmployeeEmail() {
    if (employeeDetails.value != null) {
      return employeeDetails.value!.email ?? '';
    }
    if (userDetails.value != null) {
      return userDetails.value!.email ?? '';
    }
    return '';
  }

  // Get profile image URL
  String getProfileImage() {
    return employeeDetails.value?.profileImage ?? '';
  }

  // Format date for display
  String formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  // Get status color
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Get total pages for pagination
  int getTotalPages() {
    return recentLeaves.isEmpty ? 1 : ((recentLeaves.length / 10).ceil());
  }

  @override
  void onClose() {
    super.onClose();
  }
}