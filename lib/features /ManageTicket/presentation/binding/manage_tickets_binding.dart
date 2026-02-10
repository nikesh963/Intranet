// features/tickets/presentation/bindings/manage_tickets_binding.dart
import 'package:get/get.dart';
import '../controller/manage_ticket_controller.dart';


class ManageTicketsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageTicketsController());
  }
}