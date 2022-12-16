import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chat.dart';
import 'package:whatsapp_clone/app/modules/chat/screens/chat_screen.dart';

class ChatsViewController extends GetxController {
  var myChatsList = <Rx<Chat>>[].obs;

  void onChatTilePressed() {
    // Get.to(
    //   () => ChatScreen(chatPath: chatPath, image: image, name: name, userId: userId),
    //   transition: Transition.fadeIn,
    //   duration: const Duration(milliseconds: 400),
    //   curve: Curves.easeIn,
    // );
  }
}
