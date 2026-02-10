import 'package:get/get.dart';
import '../controller/attendance_controller.dart';

class AttendanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceController>(() => AttendanceController());
  }
}