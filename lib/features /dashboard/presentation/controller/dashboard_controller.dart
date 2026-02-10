
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/icons.dart';
import '../../../ManageTicket/presentation/screen/manage_tickets_screen.dart';
import '../../../attendanceList/presentation/screen/attendance_list_screen.dart';
import '../../../home/presentation/screen/home_screen.dart';
import '../../../manageLeave/presentation/screen/manage_leave_screen.dart';
import '../../../profile/presentation/screen/profile_screen.dart';


class DashboardController extends GetxController {

  final RxInt _selectedTabIndex = 0.obs;
  final RxList<String> tabIconList = <String>[].obs;
  final RxList<dynamic> tabScreens = <dynamic>[].obs;
  RxInt get selectedTabIndex => _selectedTabIndex;
  final PageController pageController = PageController();

  late final bool goToProfile;

  Future<void> updateSelectedTabIndex(int index) async {
    if (index == -1) {
      _selectedTabIndex.value = -1;
    } else {
      _selectedTabIndex.value = index;
    }
  }
  RxString userStatus = ''.obs;
  @override
  void onInit() {
    super.onInit();
    // _loadUserRole();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserRole();
    });
  }



  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString("userRole");

    String? userDataString = prefs.getString("userData");
    Map<String, dynamic>? userData;

    if (userDataString != null && userDataString.isNotEmpty) {
      userData = json.decode(userDataString);
    }
    tabIconList.assignAll([
      AppIcons.HOME,
      AppIcons.ATTENDANCE,
      AppIcons.MANAGE,
      AppIcons.LEAVE,
      AppIcons.PROFILE,
    ]);
    tabScreens.assignAll([
      HomeScreen(),
      AttendanceScreen(),
      ManageTicketsScreen(),
      ManageLeaveScreen(),
      ProfileScreen()
    ]);
  }
}


