import 'package:get/get.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

class HelpScreenController extends GetxController {
  void onAppInfoTilePressed() {
    Get.toNamed(Routes.APP_INFO_SCREEN);
    // FirebaseAuth.instance.currentUser!.delete();
  }

  void onPrivacyPolicyInfoTilePressed() {
    Get.toNamed(Routes.PRIVACY_POLICY_SCREEN);
  }

  void onTermsAndConditionsTilePressed() {
    Get.toNamed(Routes.TERMS_AND_CONDITIONS_SCREEN);
  }
}
