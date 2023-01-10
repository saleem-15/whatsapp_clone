import 'package:firebase_auth/firebase_auth.dart' hide User;

import 'package:get/get.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

class AuthController extends GetxController {
  late bool isAuthorized;

  @override
  void onInit() {
    super.onInit();

    isAuthorized = FirebaseAuth.instance.currentUser != null;
  }

  Future<void> logout() async {
    Get.until((_) => Get.currentRoute == Routes.HOME);
    await FirebaseAuth.instance.signOut();
    MySharedPref.deleteUser();
  }

  deleteAccount() {
    FirebaseAuth.instance.currentUser!.delete();
  }
}
