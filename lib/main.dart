// ignore_for_file: unused_import

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/models/messages/text_message.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/auth_controller.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/otp_form_controller.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/signin_controller.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/signup_controller.dart';
import 'package:whatsapp_clone/app/modules/auth/screens/signup_screen.dart';
import 'package:whatsapp_clone/app/modules/home/views/home_screen.dart';
import 'package:whatsapp_clone/app/modules/user_chats/service/chats_provider.dart';
import 'package:whatsapp_clone/storage/database/models/chat.dart';
import 'package:whatsapp_clone/utils/contacts.dart';
import 'package:whatsapp_clone/utils/ui/custom_snackbar.dart';

import 'app/models/messages/file_message.dart';
import 'app/models/messages/video_message.dart';
import 'app/models/messages/audio_message.dart';
import 'app/modules/auth/screens/otp_screen.dart';
import 'app/modules/auth/services/auth_provider.dart';
import 'app/modules/settings/user_provider.dart';
import 'app/modules/user_chats/controllers/chats_view_controller.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'storage/my_shared_pref.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPref.init();
  await UserProvider.init();

  Get.put(AuthController());
  // MyContacts.listenToContacts();

  // final isar = await Isar.open([
  //   // UserSchema,
  //   ChatSchema,
  // ]);

  // await isar.writeTxn(() async {
  //   // insert & update
  //   // await isar.imageMessages.watchLazy(fireImmediately: true);

  // });

  // resetApp();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

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
        home: StreamBuilder(
          stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<firebase_auth.User?> snapshot) {
            // log('-----Auth state changed');

            /// if user == null => the user is not Authenticated
            ///
            if (snapshot.data == null) {
              // if (FirebaseAuth.instance.currentUser == null) {
              // log('--------Not Authorized!');
              return SignUpScreen();
            }

            // log('-----Authorized');
            return HomeScreen();
          },
        ),
      ),
    );
  }
}

/// clears all the stored data & signs out (used when developing the app)
void resetApp() {
  firebase_auth.FirebaseAuth.instance.signOut();
  MySharedPref.clearAllData();
}
