
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.white,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image.asset(
          AppImages.LOGO,
        ),
      )),
    );
  }
}
