import 'package:firebase_auth/firebase_auth.dart' hide User;

import 'package:get/get.dart';
import 'package:whatsapp_clone/storage/database/database.dart';

class AuthController extends GetxController {
  late bool isAuthorized;

  @override
  void onInit() {
    super.onInit();

    isAuthorized = FirebaseAuth.instance.currentUser != null;
  }

  Future<void> logout() async {
    // Get.until((_) => Get.currentRoute == Routes.HOME);
    await FirebaseAuth.instance.signOut();

    await MyDataBase.clearDatabase();
  }

  deleteAccount() {
    FirebaseAuth.instance.currentUser!.delete();
  }
}
