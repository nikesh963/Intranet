part of 'app_pages.dart';

class AppRoutes {
  //------------ Authentication Routes ------------
  static String splash = '/';
  static String welcome = '/welcome';
  static String login = '/login';
  static String createAccount = '/createAccount';
  static const forgotPassword = '/forgot-password';
  static const verifyOtp = '/verify-otp';
  static const createNewPassword = '/create-new-password';

  //------------ Home Routes ------------
  static String dashboard = '/dashboard';
  static String home = '/home';

  //------------ Profile Routes ------------
  static String editProfile = '/editProfile';
  static String address = '/address';
  static String addAddress = '/addAddress';
  static String updateAddress = '/updateAddress';
  static String webView = '/webView';
  static String reply = '/reply';

  //------------ Products Routes ------------
  static String collection = '/collection';
  static String productDetails = '/productDetails';
  static String searchProducts = '/searchProducts';

  //------------ Hamburg Menu Routes ------------
  static String contactUs = '/contactUs';
  static String customerSupport = '/customerSupport';
  static String returnExchange = '/returnExchange';
  static String productWarranty = '/productWarranty';
  static String orderCancellation = '/orderCancellation';
  static String paymentMethods = '/paymentMethods';
  static String faq = '/faq';

  //------------ Order Routes ------------
  static String orderHistory = '/orderHistory';
  static String orderDetails= '/orderDetails';

  //------------ Cart Routes ------------
  static String cart = '/cart';

  //------------ Delivery Partner ------------
  static String deliveryPartnerOrderQueueScreen = '/deliveryPartnerOrderQueueScreen';
  static String deliveryPartnerOrderDetailsScreen = '/deliveryPartnerOrderDetailsScreen';
}
