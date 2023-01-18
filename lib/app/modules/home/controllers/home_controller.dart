import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/chats_creater_provider.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'package:whatsapp_clone/utils/contacts.dart';

class HomeController extends GetxController {
  void onMorePressed() {
    Get.toNamed(Routes.SETTINGS_SCREEN);
  }

  void onSearchPressed() async {
    final numbers = await MyContacts.getMyContacts();
    checkMyContactsAreExists(numbers);
  }
}
