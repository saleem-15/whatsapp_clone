import 'package:firebase_auth/firebase_auth.dart' hide User;

import 'package:get/get.dart';
import 'package:whatsapp_clone/storage/database/database.dart';

import '../../../../config/routes/app_pages.dart';

class AuthController extends GetxController {
  late bool isAuthenticated;

  AuthController({this.onAuthorized, this.onUnAuthorized});

  /// A callback function that is called when the app changes its authentication state to `Authenticated`.
  ///
  /// This function will be called immediately when the app starts if the user is already logged in.
  void Function()? onAuthorized;

  /// A callback function that is called when the app changes its authentication state to `Unauthenticated`.
  ///
  /// This function will be called immediately when the app starts if the user is not logged in.
  void Function()? onUnAuthorized;

  @override
  void onInit() {
    super.onInit();

    isAuthenticated = FirebaseAuth.instance.currentUser != null;
  }

  @override
  void onReady() {
    /// listen to changes on the auth state and update [isAuthenticated] variable accordingly.
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        isAuthenticated = false;
        onUnAuthorized?.call();
      } else {
        isAuthenticated = true;
        onAuthorized?.call();
      }
    });
    super.onReady();
  }

  ///logs the user out.\
  ///`Note: it clears all the data (Messages,Chats,etc...)`
  Future<void> logout([bool navigateToSignInPage = true]) async {
    await FirebaseAuth.instance.signOut();
    await MyDataBase.clearDatabase();

    if (navigateToSignInPage) {
      Get.offAllNamed(Routes.SIGN_IN);
    }
  }

  deleteAccount() {
    FirebaseAuth.instance.currentUser!.delete();
  }
}
