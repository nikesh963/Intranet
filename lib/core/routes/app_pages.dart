import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../../features /auth/presentation/binding/auth_binding.dart';
import '../../features /auth/presentation/screen/loginscreen.dart';
import '../../features /dashboard/presentation/screen/dashboard_screen.dart';
import '../../features /profile/editprofile/presentation/binding/edit_profile_binding.dart';
import '../../features /profile/editprofile/presentation/screen/edit_profile_screen.dart';
part 'app_routes.dart';

class GetRouter {
  static List<GetPage> routes = [
    // GetPage(
    //     name: AppRoutes.splash,
    //     page: () => const SplashScreen(),
    //     binding: SplashBinding()),
    GetPage(
        name: AppRoutes.login,
        page: () => LoginScreen(),
        binding: AuthBinding()),
    GetPage(
        name: AppRoutes.editProfile,
        page: () => EditProfileScreen(),
        binding: EditProfileBinding()),

    GetPage(name: AppRoutes.dashboard, page: () => Dashboard(), bindings: [
      // CartBinding(),
      // ProfileBinding(),
      // DashboardBinding(),
      // HamburgMenuBinding(),
      // HomeBinding(),
      // OrderBinding(),
      // NotificationBinding()
    ]),
  ];
}
