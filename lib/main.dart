// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/otp_form_controller.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/signin_controller.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/signup_controller.dart';
import 'package:whatsapp_clone/app/modules/auth/screens/signup_screen.dart';

import 'app/modules/auth/screens/otp_screen.dart';
import 'app/modules/user_chats/chats_view_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/storage/my_shared_pref.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  await MySharedPref.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  Get.lazyPut(() => SigninController(), fenix: true);
  Get.lazyPut(() => SignupController(), fenix: true);
  Get.lazyPut(() => OTPScreenController(), fenix: true);
  Get.lazyPut(() => ChatsViewController(), fenix: true);

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   getPages: AppPages.routes,
    //   debugShowCheckedModeBanner: false,
    //   home: ScreenUtilInit(
    //     builder: (context, child) => Theme(
    //       data: MyTheme.getThemeData(),
    //       child: Directionality(
    //         textDirection: TextDirection.ltr,
    //         child: PixelPerfect.extended(
    //           child: const SigninScreen(),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "whatsapp",
        getPages: AppPages.routes,
        builder: (context, widget) {
          return Theme(
            data: MyTheme.getThemeData(),
            child: MediaQuery(
              // but we want our app font to still the same and dont get affected
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            ),
          );
        },
        home: const SignUpScreen(),
        // const OTPScreen(),
        // home: Get.find<AuthController>().isAuthorized ? const MyApp() : const SigninScreen(),
        // const SigninScreen()
      ),
    );
  }
}
