import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/app/modules/auth/screens/signin_screen.dart';
import 'package:whatsapp_clone/app/modules/auth/screens/signup_screen.dart';
import 'package:whatsapp_clone/app/modules/chat/screens/chat_screen.dart';
import 'package:whatsapp_clone/app/modules/home/views/home_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SigninScreen(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: _Paths.OTP_SCREEN,
      page: () => OTPScreen(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () => ChatScreen(),
    ),
  ];
}
