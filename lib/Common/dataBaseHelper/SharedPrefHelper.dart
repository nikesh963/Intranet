import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/routes/app_pages.dart';


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

  static Future<String> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_type') ?? '';
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

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name') ?? '';
  }

  // Save user role
  static Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role);
  }

// Get user role
  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role');
  }

  static Future<void> clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
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
                      HapticFeedback.selectionClick(); // small vibration
                      await Future.delayed(const Duration(milliseconds: 300));

                      // // 👇 clear shared prefs and logout
                      // final prefs = await SharedPreferences.getInstance();
                      // await prefs.clear();
                      final prefs = await SharedPreferences.getInstance();

                      // ✅ Clear only login/session data, keep onboarding + install info
                      await prefs.remove('accessToken');
                      await prefs.remove('refreshToken');
                      await prefs.remove('user_id');
                      await prefs.remove('user_role');
                      await prefs.remove('user_email');

                      print("🚪 Logged out. Cleared login, preserved onboarding + install.");

                      Get.offNamedUntil(
                          AppRoutes.login, (Route<dynamic> route) => false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        // color: AppTheme.colors.settingred,
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
                        // color: AppTheme.colors.noblue,
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
