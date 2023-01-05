import 'package:get/get.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

class HomeController extends GetxController {



  void onMorePressed() {
    Get.toNamed(Routes.SETTINGS_SCREEN);
  }
}
