// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
// import '../../../../core/data/apiEndpoints/api_endpoints.dart';
// import '../../../../core/data/local/shared_preferences_helper.dart';
// import '../../../../core/network/network_info.dart';
// import '../../../../core/routes/app_pages.dart';
// import '../../data/models/login_model.dart';
//
// class AuthController extends GetxController {
//   final SharedPreferenceHelper sharedPreferenceHelper;
//   final NetworkInfo networkInfo;
//   final Dio dio;
//
//   AuthController({
//     required this.sharedPreferenceHelper,
//     required this.networkInfo,
//     required this.dio,
//   });
//
//   // Form controllers
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   // State variables
//   final isLoading = false.obs;
//   final rememberMe = false.obs;
//   final obscurePassword = true.obs;
//
//   // Error messages
//   final emailError = Rx<String?>(null);
//   final passwordError = Rx<String?>(null);
//
//   @override
//   void onInit() {
//     super.onInit();
//     _loadRememberedData();
//   }
//
//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
//
//   Future<void> _loadRememberedData() async {
//     final savedEmail = await sharedPreferenceHelper.getString('remembered_email');
//     final shouldRemember = await sharedPreferenceHelper.getBool('remember_me');
//
//     if (shouldRemember && savedEmail.isNotEmpty) {
//       emailController.text = savedEmail;
//       rememberMe.value = true;
//     }
//   }
//
//   Future<void> _saveRememberedData() async {
//     if (rememberMe.value && emailController.text.isNotEmpty) {
//       await sharedPreferenceHelper.setString('remembered_email', emailController.text);
//       await sharedPreferenceHelper.setBool('remember_me', true);
//     } else {
//       await sharedPreferenceHelper.setString('remembered_email', '');
//       await sharedPreferenceHelper.setBool('remember_me', false);
//     }
//   }
//
//   void togglePasswordVisibility() {
//     obscurePassword.value = !obscurePassword.value;
//   }
//
//   bool _validateForm() {
//     bool isValid = true;
//
//     // Validate email
//     if (emailController.text.isEmpty) {
//       emailError.value = 'Email is required';
//       isValid = false;
//     } else if (!GetUtils.isEmail(emailController.text)) {
//       emailError.value = 'Please enter a valid email';
//       isValid = false;
//     } else {
//       emailError.value = null;
//     }
//
//     // Validate password
//     if (passwordController.text.isEmpty) {
//       passwordError.value = 'Password is required';
//       isValid = false;
//     } else if (passwordController.text.length < 6) {
//       passwordError.value = 'Password must be at least 6 characters';
//       isValid = false;
//     } else {
//       passwordError.value = null;
//     }
//
//     return isValid;
//   }
//
//   Future<void> login() async {
//     if (!_validateForm()) {
//       return;
//     }
//
//     if (isLoading.value) return;
//
//     isLoading.value = true;
//
//     try {
//       // Check internet connection
//       if (!await networkInfo.isConnected) {
//         Get.snackbar(
//           'No Internet',
//           'Please check your internet connection',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         return;
//       }
//
//       // Prepare login data
//       final loginData = LoginRequestModel(
//         email: emailController.text.trim(),
//         password: passwordController.text,
//       );
//
//       // Make API call directly
//       final response = await dio.post(
//         APIEndpoint.login,
//         data: loginData.toJson(),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Parse response
//         final loginResponse = LoginResponseModel.fromJson(response.data);
//
//         // Save auth data
//         await sharedPreferenceHelper.setString('access_token', loginResponse.accessToken);
//         await sharedPreferenceHelper.setString('expires_at', loginResponse.expiresAt);
//         await sharedPreferenceHelper.setString('user_email', emailController.text);
//
//         // Save remember me preference
//         await _saveRememberedData();
//
//         // Clear password
//         passwordController.clear();
//
//         // Navigate to dashboard
//         Get.offAllNamed(AppRoutes.dashboard);
//
//         Get.snackbar(
//           'Success',
//           'Login successful!',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//       } else {
//         // Handle API errors
//         final error = response.data['error'] ?? 'Login failed';
//         Get.snackbar(
//           'Login Failed',
//           error.toString(),
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } on DioException catch (e) {
//       // Handle Dio errors
//       String errorMessage = 'An error occurred';
//       if (e.response != null) {
//         errorMessage = e.response?.data['error'] ?? e.message ?? errorMessage;
//       } else {
//         errorMessage = e.message ?? errorMessage;
//       }
//
//       Get.snackbar(
//         'Error',
//         errorMessage,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       // Handle other errors
//       Get.snackbar(
//         'Error',
//         'An unexpected error occurred',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> logout() async {
//     // Clear auth data
//     await sharedPreferenceHelper.setString('access_token', '');
//     await sharedPreferenceHelper.setString('expires_at', '');
//     await sharedPreferenceHelper.setString('user_email', '');
//
//     // Clear remembered data
//     await sharedPreferenceHelper.setString('remembered_email', '');
//     await sharedPreferenceHelper.setBool('remember_me', false);
//
//     // Navigate to login
//     Get.offAllNamed(AppRoutes.login);
//   }
//
//   Future<bool> isLoggedIn() async {
//     final token = await sharedPreferenceHelper.getString('access_token');
//     return token.isNotEmpty;
//   }
//
//   Future<String?> getToken() async {
//     return await sharedPreferenceHelper.getString('access_token');
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../../Common/CommonSnackBar.dart';
import '../../../../Common/dataBaseHelper/SharedPrefHelper.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../../../core/data/apiEndpoints/api_endpoints.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routes/app_pages.dart';
import '../../data/models/login_model.dart';

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
      SnackBarService.showErrorSnackBar('Password must be at least 6 characters');
      isValid = false;
    } else {
      passwordError.value = null;
    }

    return isValid;
  }

  Future<void> login() async {
    // if (!_validateForm()) {
    //   return;
    // }
    //
    // if (isLoading.value) return;
    //
    // isLoading.value = true;
    //
    // try {
    //   // Check internet connection
    //   if (!await networkInfo.isConnected) {
    //     SnackBarService.showErrorSnackBar('Please check your internet connection');
    //     return;
    //   }
    //
    //   // Prepare login data
    //   final loginData = LoginRequestModel(
    //     email: emailController.text.trim(),
    //     password: passwordController.text,
    //   );
    //
    //   // Use ApiHelper to make API call (token handling is automatic)
    //   final response = await apiHelper.post(
    //     APIEndpoint.login,
    //     data: loginData.toJson(),
    //   );
    //
    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     // Parse response
    //     final loginResponse = LoginResponseModel.fromJson(response.data);
    //
    //     // Note: ApiHelper already saves the access token automatically
    //     // But we need to save refresh token and user email
    //     await SharedPrefHelper.saveRefreshToken(loginResponse.refreshToken);
    //     await SharedPrefHelper.saveUserName(emailController.text.trim());
    //
    //     // Save other user data if available in response
    //     if (response.data['email'] != null) {
    //       await SharedPrefHelper.saveUsername(response.data['email']);
    //     }
    //
    //     if (response.data['role'] != null) {
    //       await SharedPrefHelper.saveUserRole(response.data['role']);
    //     }
    //
    //     // Save remember me preference
    //     await _saveRememberedData();
    //
    //     // Clear password if remember me is false
    //     if (!rememberMe.value) {
    //       passwordController.clear();
    //     }
    //
    //     // Navigate to dashboard
    //     Get.offAllNamed(AppRoutes.dashboard);
    //
    //     SnackBarService.showSuccessSnackBar('Login successful!');
    //   } else {
    //     // Handle API errors
    //     final error = response.data['error'] ?? response.data['message'] ?? 'Login failed';
    //     SnackBarService.showErrorSnackBar(error.toString());
    //   }
    // } on DioError catch (e) {
    //   // Handle Dio errors
    //   String errorMessage = 'An error occurred';
    //
    //   if (e.response != null) {
    //     // Try to get error message from response
    //     errorMessage = e.response?.data['error'] ??
    //         e.response?.data['message'] ??
    //         e.message ??
    //         errorMessage;
    //   } else {
    //     errorMessage = e.message ?? errorMessage;
    //   }
    //
    //   // Check for specific error types
    //   if (e.type == DioErrorType.connectionTimeout ||
    //       e.type == DioErrorType.receiveTimeout ||
    //       e.type == DioErrorType.sendTimeout) {
    //     errorMessage = 'Connection timeout. Please try again.';
    //   } else if (e.type == DioErrorType.connectionError) {
    //     errorMessage = 'Connection error. Please check your internet.';
    //   }
    //
    //   SnackBarService.showErrorSnackBar(errorMessage);
    // } catch (e) {
    //   // Handle other errors
    //   SnackBarService.showErrorSnackBar('An unexpected error occurred');
    // } finally {
    //   isLoading.value = false;
    // }
    Get.offAllNamed(AppRoutes.dashboard);
  }

  Future<void> logout({bool showMessage = true}) async {
    // Clear all auth data using SharedPrefHelper
    await SharedPrefHelper.clearLoginSession();

    // Clear form data
    emailController.clear();
    passwordController.clear();
    rememberMe.value = false;

    // Navigate to login
    Get.offAllNamed(AppRoutes.login);

    // Show logout message
    if (showMessage) {
      SnackBarService.showInfoSnackBar('Logged out successfully');
    }
  }

  Future<bool> isLoggedIn() async {
    return await SharedPrefHelper.isLoggedInOrGuest();
  }

  Future<String?> getToken() async {
    return await SharedPrefHelper.getAccessToken();
  }

  Future<String?> getUserRole() async {
    return await SharedPrefHelper.getUserRole();
  }

  Future<String?> getUsername() async {
    return await SharedPrefHelper.getUsername();
  }

  // Add a method to check token validity
  Future<bool> checkTokenValidity() async {
    try {
      // Make a simple API call to check if token is valid
      final response = await apiHelper.get('auth/validate'); // Your validation endpoint
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Optional: Clear validation errors
  void clearErrors() {
    emailError.value = null;
    passwordError.value = null;
  }

  // Optional: Reset form
  void resetForm() {
    emailController.clear();
    passwordController.clear();
    rememberMe.value = false;
    clearErrors();
  }
}
