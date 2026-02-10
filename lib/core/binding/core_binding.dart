
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../data/remote/dio_client.dart';
import '../network/network_info.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() async {
    // Network
    Get.put<InternetConnectionChecker>(InternetConnectionChecker(),
        permanent: true);
    Get.put<NetworkInfo>(NetworkInfoImpl(Get.find()), permanent: true);
    Get.put<Dio>(Dio(), permanent: true);
    Get.put<DioClient>(DioClient(dio: Get.find(), preference: Get.find()),
        permanent: true);
  }
}
