import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../widget/loading.dart';
import '../widget/toast/custom_toast_widget.dart';

class GlobalController extends GetxController {
  void showLoader() {
    Get.dialog(Loading());
  }

  void hideLoader() {
    Get.back();
  }

  void successToast({required String title, required String message}) {
    FToast fToast = FToast();
    fToast.init(Get.overlayContext!);
    fToast.showToast(
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(milliseconds: 3000),
        child: CustomToastWidget(
          title: title,
          message: message,
          toastType: ToastType.SUCCESS,
        ));
  }

  void warningToast({required String title, required String message}) {
    FToast fToast = FToast();
    fToast.init(Get.overlayContext!);
    fToast.showToast(
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(milliseconds: 3000),
        child: CustomToastWidget(
          title: title,
          message: message,
          toastType: ToastType.WARNING,
        ));
  }

  void infoToast({required String title, required String message}) {
    FToast fToast = FToast();
    fToast.init(Get.overlayContext!);
    fToast.showToast(
        toastDuration: Duration(milliseconds: 3000),
        gravity: ToastGravity.BOTTOM,
        child: CustomToastWidget(
          title: title,
          message: message,
          toastType: ToastType.INFO,
        ));
  }

  void errorToast({required String title, required String message}) {
    FToast fToast = FToast();
    fToast.init(Get.overlayContext!);
    fToast.showToast(
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(milliseconds: 3000),
        child: CustomToastWidget(
          title: title,
          message: message,
          toastType: ToastType.ERROR,
        ));
  }

  void onFailure(String message) {
    errorToast(title: "Error", message: message);
  }

  void goToDashboard() {
    Get.offAllNamed(AppRoutes.dashboard);
  }
}
