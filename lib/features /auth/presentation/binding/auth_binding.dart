// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
// import 'package:intranet/core/data/local/shared_preferences_helper.dart';
// import 'package:intranet/core/network/network_info.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../controller/auth_controller.dart';
//
// class AuthBinding extends Bindings {
//   @override
//   void dependencies() {
//     // Get instances
//     final sharedPreferences = Get.find<SharedPreferences>();
//     final sharedPreferenceHelper = SharedPreferenceHelper(sharedPreferences);
//     final networkInfo = Get.find<NetworkInfo>();
//     final dio = Get.find<Dio>();
//
//     // Initialize Controller with dependencies
//     Get.lazyPut(() => AuthController(
//       sharedPreferenceHelper: sharedPreferenceHelper,
//       networkInfo: networkInfo,
//       dio: dio,
//     ));
//   }
// }

import 'package:get/get.dart';
import 'package:intranet/core/network/network_info.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Get instances
    final networkInfo = Get.find<NetworkInfo>();
    final apiHelper = ApiHelper(); // Create ApiHelper instance

    // Initialize Controller with dependencies
    Get.lazyPut(() => AuthController(
      networkInfo: networkInfo,
      apiHelper: apiHelper, // Pass ApiHelper instead of Dio
    ));
  }
}