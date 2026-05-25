import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/binding/core_binding.dart';
import 'core/data/local/local_preference.dart';
import 'core/data/local/shared_preferences_helper.dart';
import 'core/routes/app_pages.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top], // Only bottom nav bar
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPreferences, permanent: true);
  Get.put<SharedPreferenceHelper>(SharedPreferenceHelper(Get.find()),
      permanent: true);
  Get.put<LocalPreference>(LocalPreference(Get.find()), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ScreenUtilInit(
      designSize: const Size(456, 900),

      minTextAdapt: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates:   [
          MonthYearPickerLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        supportedLocales: const [
          Locale('en'),
        ],
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
        title: 'Intranet',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        initialBinding: CoreBinding(),
        initialRoute: AppRoutes.splash,
        getPages: GetRouter.routes,
        // home: MapSample(),

      ),
    );
  }
}
