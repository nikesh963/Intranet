// features/profile/presentation/bindings/edit_profile_binding.dart
import 'package:get/get.dart';
import '../controller/reply_controller.dart';


class ReplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketReplyController>(() => TicketReplyController(Get.arguments,));
  }
}