import 'dart:developer';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chat_interface.dart';
import 'package:whatsapp_clone/app/modules/user_chats/service/chats_provider.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

class ChatsViewController extends GetxController {
  RxList<Rx<Chat>> myChatsList = <Rx<Chat>>[].obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    final chats = await ChatsProvider.getAllMyChats();
    log('chats: ${chats.length}');
    myChatsList.addAll(chats.map((e) => e.obs));
  }

  void onChatTilePressed(Chat chat) {
    Get.toNamed(
      Routes.CHAT_SCREEN,
      arguments: chat,
    );
  }
  

  getUserbyId(String senderId) {
    return 'wtf';
  }
}
