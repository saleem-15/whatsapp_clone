import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/providers/chats_provider.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

class ChatsViewController extends GetxController {
  ///this list is displayed in [ChatsTapView]
  ///
  ///it can be filtered to display the search results
  RxList<Rx<Chat>> get chatsList => Get.find<ChatsController>().chats;

  ///this is un filtered list holds all chats
  List<Rx<Chat>> allChatsList = <Rx<Chat>>[].obs;

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  void onChatTilePressed(Chat chat) {
    Get.toNamed(
      Routes.CHAT_SCREEN,
      arguments: chat,
    );
  }

}
