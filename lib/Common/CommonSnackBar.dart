import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarService {
  static void showCustomSnackBar({
    required String title,
    required String message,
    required IconData icon,
    required Color iconColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 15,
      backgroundColor: Colors.transparent,
      snackStyle: SnackStyle.FLOATING,
      isDismissible: true,
      duration: duration,
      overlayBlur: 0,
      padding: EdgeInsets.zero,
      messageText: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: iconColor, width: 2),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 13),

// TEXT AREA
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 3),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

// Close icon
            GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.close, size: 20, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

// SUCCESS
  static void showSuccessSnackBar(String message) {
    showCustomSnackBar(
      title: "Success",
      message: message,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
    );
  }

// ERROR
  static void showErrorSnackBar(String message) {
    showCustomSnackBar(
      title: "Error",
      message: message,
      icon: Icons.cancel_outlined,
      iconColor: Colors.red,
    );
  }

// INFO
  static void showInfoSnackBar(String message) {
    showCustomSnackBar(
      title: "Info",
      message: message,
      icon: Icons.info_outline,
      iconColor: Colors.blue,
    );
  }

// WARNING
  static void showWarningSnackBar(String message) {
    showCustomSnackBar(
      title: "Warning",
      message: message,
      icon: Icons.warning_amber_rounded,
      iconColor: Colors.orange,
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SnackBarService {
//   static void showSnackBar(String message,String type,Icon sIcon, {Color backgroundColor = Colors.black, Duration duration = const Duration(seconds: 3)}) {
//     Get.snackbar(
//       type, // Title, if you want to leave it blank
//       message,
//       backgroundColor: backgroundColor,
//       colorText: Colors.white,
//       snackPosition: SnackPosition.TOP,
//       duration: duration,
//       icon: sIcon,
//     );
//   }
//
//   static void showSuccessSnackBar(String message) {
//     showSnackBar(message,"Success",Icon(Icons.done,color: Colors.white,), backgroundColor: Colors.green);
//   }
//
//   static void showErrorSnackBar(String message) {
//     showSnackBar(message,"Error",Icon(Icons.error,color: Colors.white,), backgroundColor: Colors.red);
//   }
//
//   static void showInfoSnackBar(String message) {
//     showSnackBar(message,"Info",Icon(Icons.info_outline,color: Colors.white,), backgroundColor: Colors.blue);
//   }
//
//   static void showWarningSnackBar(String message) {
//     showSnackBar(message,"Warning",Icon(Icons.warning,color: Colors.white,), backgroundColor: Colors.orange);
//   }
//
//
// }