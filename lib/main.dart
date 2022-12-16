import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/home/views/home_screen.dart';

import 'app/routes/app_pages.dart';
import 'app/storage/my_shared_pref.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  await MySharedPref.init();

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        home: const HomePage(),
        // home: Get.find<AuthController>().isAuthorized ? const MyApp() : const SigninScreen(),
        // const SigninScreen()
      ),
    );
  }
}
