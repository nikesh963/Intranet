import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../../features /auth/presentation/binding/auth_binding.dart';
import '../../features /auth/presentation/screen/create_new_password_screen.dart';
import '../../features /auth/presentation/screen/forgot_password_screen.dart';
import '../../features /auth/presentation/screen/loginscreen.dart';
import '../../features /auth/presentation/screen/verify_otp_screen.dart';
import '../../features /dashboard/presentation/controller/dashboard_controller.dart';
import '../../features /dashboard/presentation/screen/dashboard_screen.dart';
import '../../features /home/presentation/controller/home_controller.dart';
import '../../features /home/presentation/screen/home_screen.dart';
import '../../features /profile/editprofile/presentation/binding/edit_profile_binding.dart';
import '../../features /profile/editprofile/presentation/screen/edit_profile_screen.dart';
import '../../features /splash/presentation/screen/splash_screen.dart';
import '../../features /ticket_reply/presentation/binding/reply_binding.dart';
import '../../features /ticket_reply/presentation/screen/reply_screen.dart';
part 'app_routes.dart';

class GetRouter {
  static List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      // binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      // binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.verifyOtp,
      page: () => VerifyOtpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.createNewPassword,
      page: () => CreateNewPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.reply,

      page: () => TicketReplyScreen(
        ticketId: Get.arguments,
      ),

      binding: ReplyBinding(),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => Dashboard(),
      binding: BindingsBuilder(() {
        // Initialize ALL controllers here, not just DashboardController
        print("📦 Dashboard Binding: Initializing all controllers");

        // Initialize all feature controllers with permanent flag
        Get.put(HomeController(), permanent: true);
        // Get.put(CartController(), permanent: true);
        // Get.put(WishlistController(), permanent: true);
        // Get.put(ProfileController(), permanent: true);

        // Also initialize DashboardController
        Get.put(DashboardController(), permanent: true);
      }),
    ),
  ];
}
