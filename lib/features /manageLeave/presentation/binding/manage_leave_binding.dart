// features/profile/presentation/bindings/edit_profile_binding.dart
import 'package:get/get.dart';
import '../controller/manage_leave_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageLeaveController>(() => ManageLeaveController());
  }
}