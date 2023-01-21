import 'dart:developer';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/api/chats_provider.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

class ChatsViewController extends GetxController {
  ///this list is displayed in [ChatsTapView]
  ///
  ///it can be filtered to display the search results
  RxList<Rx<Chat>> chatsList = <Rx<Chat>>[].obs;

  ///this is un filtered list holds all chats
  List<Rx<Chat>> allChatsList = <Rx<Chat>>[].obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    final chats = await ChatsProvider.getAllMyChats();
    log('chats: ${chats.length}');
    final rxChatObjects = chats.map((e) => e.obs);
    allChatsList = rxChatObjects.toList();
    chatsList.addAll(rxChatObjects);
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
