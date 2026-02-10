import 'package:get/get.dart';
import '../../../../Common/helper/ApiHelper.dart';
import '../../../../core/network/network_info.dart';
import '../controller/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    final networkInfo = Get.find<NetworkInfo>();
    final apiHelper = ApiHelper(); // Create ApiHelper instance

    Get.lazyPut(() => HomeController(
      // networkInfo: networkInfo,
      // apiHelper: apiHelper, // Pass ApiHelper instead of Dio
    ));
    // Get.lazyPut<HomeController>(() => HomeController());
  }
}