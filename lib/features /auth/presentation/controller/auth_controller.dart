import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Common/AppLogger.dart';
import '../../../../Common/CommonSnackBar.dart';
import '../../../../Common/dataBaseHelper/SharedPrefHelper.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routes/app_pages.dart';

class AuthController extends GetxController {
  final NetworkInfo networkInfo;
  final ApiHelper apiHelper;

  AuthController({
    required this.networkInfo,
    required this.apiHelper,
  });

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // State variables
  final isLoading = false.obs;
  final rememberMe = false.obs;
  final obscurePassword = true.obs;

  // Error messages
  final emailError = Rx<String?>(null);
  final passwordError = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadRememberedData();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> _loadRememberedData() async {
    final shouldRemember = await SharedPrefHelper.getRememberMe();

    if (shouldRemember) {
      final savedEmail = await SharedPrefHelper.getUsername();
      final savedPassword = await SharedPrefHelper.getPassword();

      if (savedEmail != null && savedEmail.isNotEmpty) {
        emailController.text = savedEmail;
        rememberMe.value = true;
      }

      if (savedPassword != null && savedPassword.isNotEmpty) {
        passwordController.text = savedPassword;
      }
    }
  }

  Future<void> _saveRememberedData() async {
    if (rememberMe.value && emailController.text.isNotEmpty) {
      await SharedPrefHelper.saveUsername(emailController.text.trim());
      await SharedPrefHelper.savePassword(passwordController.text);
      await SharedPrefHelper.setRememberMe(true);
    } else {
      await SharedPrefHelper.setRememberMe(false);
      if (!rememberMe.value) {
        await SharedPrefHelper.removeSavedCredentials();
      }
    }
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  bool _validateForm() {
    bool isValid = true;

    // Validate email
    if (emailController.text.isEmpty) {
      emailError.value = 'Email is required';
      SnackBarService.showErrorSnackBar('Email is required');
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Please enter a valid email';
      SnackBarService.showErrorSnackBar('Please enter a valid email');
      isValid = false;
    } else {
      emailError.value = null;
    }

    // Validate password
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
      SnackBarService.showErrorSnackBar('Password is required');
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      SnackBarService.showErrorSnackBar(
          'Password must be at least 6 characters');
      isValid = false;
    } else {
      passwordError.value = null;
    }

    return isValid;
  }

  // Login method
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (!_validateForm()) {
      return;
    }

    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      SnackBarService.showErrorSnackBar('No internet connection');
      return;
    }

    isLoading.value = true;

    try {
      final requestData = {
        'email': email.toLowerCase(),
        'password': password,
      };

      AppLogger.debug("📤 Login request: $requestData");

      final response = await apiHelper.post(
        '/mobile/login',
        data: requestData,
      );

      AppLogger.debug("📥 Login response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        // Check if status is true
        final isSuccess = responseData['status'] == true;

        if (isSuccess) {
          // Extract data from response
          final token = responseData['token']?.toString() ?? '';
          final message = responseData['message']?.toString() ?? 'Login successful';
          final userData = responseData['user'] as Map<String, dynamic>?;

          if (token.isNotEmpty && userData != null) {
            // Extract user information
            final userId = userData['id']?.toString() ?? '';
            final userName = userData['name']?.toString() ?? '';
            final userEmail = userData['email']?.toString() ?? '';
            final userType = userData['type']?.toString() ?? '';
            final isDepartmentAdmin = userData['is_department_admin'] ?? false;
            final employeeEncId = userData['employee_enc_id']?.toString() ?? '';

            // Save all login data
            await _saveLoginData(
              token: token,
              userId: userId,
              userName: userName,
              userEmail: userEmail,
              userType: userType,
              isDepartmentAdmin: isDepartmentAdmin,
              employeeEncId: employeeEncId,
              loginEmail: email,
              loginPassword: password,
            );

            // Save remember me preference
            await _saveRememberedData();

            // Show success message
            SnackBarService.showSuccessSnackBar(message);

            AppLogger.debug("✅ Login successful for user: $userName");

            // Navigate to dashboard
            await Future.delayed(const Duration(milliseconds: 500));
            Get.offAllNamed(AppRoutes.dashboard);
          } else {
            SnackBarService.showErrorSnackBar('Invalid response from server');
          }
        } else {
          // Handle unsuccessful login
          final errorMessage = responseData['message']?.toString() ?? 'Login failed';
          SnackBarService.showErrorSnackBar(errorMessage);
        }
      } else {
        SnackBarService.showErrorSnackBar('Login failed. Please try again.');
      }
    } on DioError catch (e) {
      AppLogger.error("❌ Login DioError: ${e.message}");

      String errorMsg = 'Failed to login. Please check your connection.';

      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null && responseData is Map) {
          errorMsg = responseData['message']?.toString() ?? errorMsg;
        } else if (responseData is String) {
          errorMsg = responseData;
        }
      } else if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        errorMsg = 'Connection timeout. Please try again.';
      } else if (e.type == DioErrorType.connectionError) {
        errorMsg = 'No internet connection.';
      }

      SnackBarService.showErrorSnackBar(errorMsg);
    } catch (e) {
      AppLogger.error("❌ Login error: $e");
      SnackBarService.showErrorSnackBar('An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  // Save login data to SharedPreferences
  Future<void> _saveLoginData({
    required String token,
    required String userId,
    required String userName,
    required String userEmail,
    required String userType,
    required bool isDepartmentAdmin,
    required String employeeEncId,
    required String loginEmail,
    required String loginPassword,
  }) async {
    // Save tokens
    await SharedPrefHelper.saveAccessToken(token);

    // Save user basic info
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
    await prefs.setString('user_name', userName);
    await prefs.setString('user_email', userEmail);
    await prefs.setString('user_type', userType);
    await prefs.setBool('is_department_admin', isDepartmentAdmin);
    await prefs.setString('employee_enc_id', employeeEncId);

    // Save login email
    await SharedPrefHelper.saveUsername(loginEmail);

    // Save password only if remember me is enabled
    if (rememberMe.value) {
      await SharedPrefHelper.savePassword(loginPassword);
    }

    // Save login time
    await SharedPrefHelper().saveLoginTime();

    AppLogger.debug("💾 Login data saved successfully");
  }

  // Get saved user data (for use throughout the app)
  Future<Map<String, dynamic>> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getString('user_id') ?? '',
      'name': prefs.getString('user_name') ?? '',
      'email': prefs.getString('user_email') ?? '',
      'type': prefs.getString('user_type') ?? '',
      'isDepartmentAdmin': prefs.getBool('is_department_admin') ?? false,
      'employeeEncId': prefs.getString('employee_enc_id') ?? '',
    };
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await SharedPrefHelper.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // Logout method
  Future<void> logout(BuildContext context) async {
    isLoading.value = true;

    try {
      // Optional: Call logout API if needed
      // await apiHelper.post('/mobile/logout');

      // Clear all session data
      await SharedPrefHelper.clearLoginDetails(context);

      // Navigate to login screen
      await Future.delayed(const Duration(milliseconds: 300));
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      AppLogger.error("❌ Logout error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}