import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/auth_controller.dart';
import 'package:whatsapp_clone/app/modules/auth/screens/signup_screen.dart';
import 'package:whatsapp_clone/app/modules/home/views/home_screen.dart';
import 'package:whatsapp_clone/app/providers/users_provider.dart';
import 'package:whatsapp_clone/fcm_helper.dart';
import 'package:whatsapp_clone/storage/database/database.dart';

import 'app/api/user_api.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'app/providers/chats_provider.dart';
import 'app/providers/groups_provider.dart';
import 'app/providers/messages_provider.dart';
import 'app/providers/private_chats_provider.dart';
import 'storage/my_shared_pref.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MySharedPref.init();
  MySharedPref.setIsMyDocExists(true);
  MySharedPref.setLastUpdated(DateTime.now());

  await Firebase.initializeApp();
  await MyDataBase.openDatabase();
  // await MyDataBase.clearDatabase();

  initControllers();
  FcmHelper.initFcm();

  await UserApi.init();
  UserApi.wathcMyDocChanges();

  // MyContacts.listenToContacts();

  // resetApp();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  runApp(const Main());
}

void initControllers() {
  Get.put(AuthController(), permanent: true);

  Get.lazyPut(() => UsersProvider(), fenix: true);
  Get.lazyPut(() => ChatsProvider(), fenix: true);
  Get.lazyPut(() => PrivateChatsProvider(), fenix: true);
  Get.lazyPut(() => GroupChatsProvider(), fenix: true);
  Get.lazyPut(() => MessagesProvider(), fenix: true);
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
            /// if user == null => the user is not Authenticated
            if (snapshot.data == null) {
              return SignUpScreen();
            }

            return HomeScreen();
          },
        ),
      ),
    );
  }
}

// /// clears all the stored data & signs out (used when developing the app)
// void resetApp() {
//   firebase_auth.FirebaseAuth.instance.signOut();
//   MySharedPref.clearAllData();
// }

// class Application extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _Application();
// }

// class _Application extends State<Application> {
//   // It is assumed that all messages contain a data field with the key 'type'
//   Future<void> setupInteractedMessage() async {
//     // Get any messages which caused the application to open from
//     // a terminated state.
//     RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

//     // If the message also contains a data property with a "type" of "chat",
//     // navigate to a chat screen
//     if (initialMessage != null) {
//       _handleMessage(initialMessage);
//     }

//     // Also handle any interaction when the app is in the background via a
//     // Stream listener
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
//   }

//   void _handleMessage(RemoteMessage message) {
//     if (message.data['type'] == 'chat') {
//       Navigator.pushNamed(
//         context,
//         '/chat',
//         arguments: ChatArguments(message),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     // Run code required to handle interacted messages in an async function
//     // as initState() must not be async
//     setupInteractedMessage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Text("...");
//   }
// }
