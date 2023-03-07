import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/auth_controller.dart';
import 'package:whatsapp_clone/app/modules/auth/screens/signup_screen.dart';
import 'package:whatsapp_clone/app/modules/home/views/home_screen.dart';
import 'package:whatsapp_clone/app/providers/users_provider.dart';
import 'package:whatsapp_clone/storage/database/database.dart';
import 'package:whatsapp_clone/utils/ui/custom_snackbar.dart';

import 'app/api/user_api.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'app/providers/chats_provider.dart';
import 'app/providers/groups_provider.dart';
import 'app/providers/messages_provider.dart';
import 'app/providers/contacts_provider.dart';
import 'utils/notifications/fcm_helper.dart';
import 'storage/my_shared_pref.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  // // await UsersDao.setMyData(User.normal(
  // //   uid: 'tUtOnV9Zp8QvU9xI7CHxGGD5XjC3',
  // //   name: 'Saleem',
  // //   phoneNumber: '+970567244416',
  // //   imageUrl: 'https://cloud.ctbuh.org/people/color/10909-giovanni-vigano.jpg',
  // //   lastUpdated: DateTime.now(),
  // //   bio: '',
  // // ));
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await MySharedPref.init();
  MySharedPref.setIsMyDocExists(true);

  await Firebase.initializeApp();

  initFirebaseCrashlytics();

  try {
    await MyDataBase.openDatabase();
  } on IsarError catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: e.message,
      duration: const Duration(seconds: 10),
    );
  }

  await initControllers();

  // FlutterNativeSplash.remove();

  runApp(const Main());
}

void initFirebaseCrashlytics() {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

Future<void> initControllers() async {
  final authController = AuthController(
    onAuthorized: () async {
      Logger().wtf('is Authorized: ${firebase_auth.FirebaseAuth.instance.currentUser != null}');

      await Get.putAsync(
        () async {
          final usersProvider = UsersProvider();
          await usersProvider.init();
          return usersProvider;
        },
      );

      UserApi.wathcMyDocChanges();
      await FcmHelper.initFcm();
      Logger().wtf('fcm initilized');
      FcmHelper.setupInteractedMessage();
    },
    onUnAuthorized: () {
      Logger().wtf('is Authorized: ${firebase_auth.FirebaseAuth.instance.currentUser != null}');

      Get.delete<UsersProvider>();
      UserApi.stopWathcingMyDocChanges();
    },
  );

  Get.put(authController, permanent: true);
  // await Get.putAsync(() async {
  //   final usersProvider = UsersProvider();
  //   await usersProvider.init();
  //   return usersProvider;
  // }, permanent: true);
  // Get.lazyPut(() => UsersProvider(), fenix: true);
  Get.lazyPut(() => ChatsProvider(), fenix: true);
  Get.lazyPut(() => ContactsProvider(), fenix: true);
  Get.lazyPut(() => GroupChatsProvider(), fenix: true);
  Get.lazyPut(() => MessagesProvider(), fenix: true);
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Chatty",
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
        home: const App(),
        //    FlutterSplashScreen(
        //     setNextScreenAsyncCallback: () async {
        //       await initApp();
        //       return const App();
        //     },
        //     defaultNextScreen: const App(),

        //     ///splash screen scaffold color
        //     backgroundColor: Colors.white,
        //     splashScreenBody: const SplashScreen(),
        //   ),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<firebase_auth.User?> snapshot) {
        /// if user == null => the user is not Authenticated
        // return SignUpScreen();
        if (snapshot.data == null) {
          return SignUpScreen();
        }

        return HomeScreen();
      },
    );
  }
}

// void main(){
//   runApp(MaterialApp(
//     home: MyApp(),
//   ));
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {

//   Future<Widget> loadFromFuture() async {

//   // <fetch data from server. ex. login>

//      return Future.value(AfterSplash());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  SplashScreen(
//       navigateAfterFuture: loadFromFuture(),
//       title: const Text('Welcome In SplashScreen',
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 20.0
//       ),),
//       image: Image.network('https://i.imgur.com/TyCSG9A.png'),
//       backgroundColor: Colors.white,
//       styleTextUnderTheLoader: const TextStyle(),
//       photoSize: 100.0,
//       onClick: ()=>print("Flutter Egypt"),
//       loaderColor: Colors.red
//     );
//   }
// }

// class AfterSplash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//       title: const Text("Welcome In SplashScreen Package"),
//       automaticallyImplyLeading: false
//       ),
//       body: const Center(
//         child: Text("Done!",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 30.0
//         ),),

//       ),
//     );
//   }
// }

/// clears all the stored data & signs out (used when developing the app)
Future<void> resetApp() async {
  await firebase_auth.FirebaseAuth.instance.signOut();
  await MySharedPref.clearAllData();
}

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
