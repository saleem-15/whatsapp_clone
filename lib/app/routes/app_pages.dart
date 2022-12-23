import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/chat/screens/chat_screen.dart';

import '../modules/auth/screens/otp_screen.dart';
import '../modules/auth/screens/signin_screen.dart';
import '../modules/auth/screens/signup_screen.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_screen.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SigninScreen(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: _Paths.OTP_SCREEN,
      page: () => const OTPScreen(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () =>  ChatScreen(),
    ),
  ];
}
