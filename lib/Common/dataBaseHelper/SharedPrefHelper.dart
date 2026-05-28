import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/routes/app_pages.dart';
import '../../core/theme/app_theme.dart';
import '../../features /dashboard/presentation/controller/dashboard_controller.dart';
import '../../features /home/presentation/controller/home_controller.dart';


class SharedPrefHelper {
  static Future<Map<String, dynamic>> getLoginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString('accessToken') ?? '',
      'refreshToken': prefs.getString('refreshToken') ?? '',
    };
  }

  static const _usernameKey = 'username';

  static Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  static const _companyNameKey = 'company_name';

  static Future<void> saveCompanyName(String companyName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_companyNameKey, companyName);
  }

  static Future<String?> getCompanyName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_companyNameKey);
  }

  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  static Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', token);
  }

  Future<void> saveLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('login_time', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<void> clearLoginSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  static Future<void> saveLastTokenRefreshTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_refresh_time', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<int?> getLastTokenRefreshTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('last_refresh_time');
  }

  static Future<void> saveUserType(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_type', userType);
  }

  static const _savedPasswordKey = 'saved_password';
  static const _rememberMeKey = 'remember_me';

  // ✅ Save password
  static Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_savedPasswordKey, password);
  }

  // ✅ Get password
  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_savedPasswordKey);
  }

  // ✅ Remember me flag
  static Future<void> setRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, value);
  }

  static Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }

  // ✅ Remove saved username/password when remember me is off
  static Future<void> removeSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_savedPasswordKey);
  }

  static const String guestKey = 'is_guest';

  static Future<bool> isLoggedInOrGuest() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = await SharedPrefHelper.getAccessToken();
    final isGuest = prefs.getBool(guestKey) ?? false;
    return (accessToken != null && accessToken.isNotEmpty) || isGuest;
  }


  static Future<void> saveUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', userName);
  }

  static Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role);
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role');
  }

  static Future<void> clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }
  static const _userNameKey = 'user_name';
  static const _userEmailKey = 'user_email';
  static const _userTypeKey = 'user_type';
  static const _isDepartmentAdminKey = 'is_department_admin';
  static const _employeeEncIdKey = 'employee_enc_id';
  static const _userIdKey = 'user_id';

  static Future<void> saveUserData({
    required String userId,
    required String userName,
    required String userEmail,
    required String userType,
    required bool isDepartmentAdmin,
    required String employeeEncId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userNameKey, userName);
    await prefs.setString(_userEmailKey, userEmail);
    await prefs.setString(_userTypeKey, userType);
    await prefs.setBool(_isDepartmentAdminKey, isDepartmentAdmin);
    await prefs.setString(_employeeEncIdKey, employeeEncId);
  }

  // Get user ID
  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey) ?? '';
  }

// Get user name
  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey) ?? '';
  }

// Get user email
  static Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey) ?? '';
  }

// Get user type
  static Future<String> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey) ?? '';
  }

// Get department admin status
  static Future<bool> getIsDepartmentAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDepartmentAdminKey) ?? false;
  }

// Get employee encrypted ID
  static Future<String> getEmployeeEncId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_employeeEncIdKey) ?? '';
  }
  // Clear user data (called during logout)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userTypeKey);
    await prefs.remove(_isDepartmentAdminKey);
    await prefs.remove(_employeeEncIdKey);
  }

  static Future<void> clearLoginDetails(BuildContext context) async {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        title: Column(
          children: [
            Text(
              'Are you sure?',

              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                // fontFamily: AppFonts.GTAMERICA,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'Are you sure you want to log out?',
              // LocaleKeys.logoutConfirmation.tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                // fontFamily: AppFonts.GTAMERICA,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// ✅ YES button
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () async {
                      HapticFeedback.selectionClick();
                      await Future.delayed(const Duration(milliseconds: 300));

                      final prefs = await SharedPreferences.getInstance();

                      /// save persistent values
                      final rememberMe = prefs.getBool('remember_me');
                      final username = prefs.getString('username');
                      final password = prefs.getString('saved_password');

                      /// clear everything
                      await prefs.clear();

                      /// restore remember me data
                      if (rememberMe != null) {
                        await prefs.setBool('remember_me', rememberMe);
                      }

                      if (username != null) {
                        await prefs.setString('username', username);
                      }

                      if (password != null) {
                        await prefs.setString('saved_password', password);
                      }

                      /// delete controllers
                      Get.delete<DashboardController>(force: true);
                      Get.delete<HomeController>(force: true);

                      print("🚪 Full logout completed");

                      /// go to login
                      Get.offAllNamed(AppRoutes.login);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: AppTheme.colors.blue.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.h),
                        child: Text(
                          "YES",
                          // LocaleKeys.yes.tr.toUpperCase(),
                          style: TextStyle(
                            // color: AppTheme.colors.yesred,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            // fontFamily: AppFonts.GTAMERICA,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 32.w),

              /// ❌ NO button
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () async {
                      HapticFeedback.selectionClick(); // small vibration
                      await Future.delayed(const Duration(milliseconds: 300));
                      Get.back(); // close dialog
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: AppTheme.colors.red.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.h),
                        child: Text(
                          "NO",
                          // LocaleKeys.no.tr.toUpperCase(),
                          style: TextStyle(
                            // color: AppTheme.colors.setingblue,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            // fontFamily: AppFonts.GTAMERICA,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
