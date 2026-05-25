import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Common/dataBaseHelper/SharedPrefHelper.dart';
import '../../../../core/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();

    await Future.delayed(const Duration(milliseconds: 2000));

    // Check if user has a valid token
    final hasValidToken = await _checkIfUserHasValidToken();

    if (hasValidToken) {
      // User has token, navigate to dashboard
      Get.offAllNamed(AppRoutes.dashboard);
      // Get.offAllNamed(AppRoutes.home);
    } else {
      // No token, go to welcome screen
      Get.offAllNamed(AppRoutes.login);
      // Get.offAllNamed(AppRoutes.home);
    }
  }

  Future<bool> _checkIfUserHasValidToken() async {
    try {
      // Get access token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      // Also check if token exists in SharedPrefHelper
      final tokenFromHelper = await SharedPrefHelper.getAccessToken();

      // Consider token valid if it exists and is not empty
      return (token != null && token.isNotEmpty) ||
          (tokenFromHelper != null && tokenFromHelper.isNotEmpty);
    } catch (e) {
      print('Error checking token: $e');
      return false;
    }
  }

  // Alternative method using SharedPrefHelper only
  Future<bool> _checkIfUserHasValidTokenAlternative() async {
    try {
      final token = await SharedPrefHelper.getAccessToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      print('Error checking token: $e');
      return false;
    }
  }
}
