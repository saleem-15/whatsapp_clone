import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chat_interface.dart';
import 'package:whatsapp_clone/app/models/message.dart';
import 'package:whatsapp_clone/app/modules/chat/services/chatting_provider.dart';

import 'chat_text_field_controller.dart';

class ChatScreenController extends GetxController {
  late final Chat chat;

  @override
  void onInit() {
    super.onInit();
    Get.put(ChatTextFieldController());

    chat = Get.arguments;
  }

  Stream<List<Message>> getMessagesStream() {
    ChattingProvider.getMessagesStream(chat.id).listen((event) {
      log('messages stream$event');
      log('messages num: ${event.docs.length}');
    });

    return ChattingProvider.getMessagesStream(chat.id).map((event) {
      final messageDocs = event.docs;

      final List<Message> messages = [];

      for (QueryDocumentSnapshot messageDoc in messageDocs) {
        messages.add(Message.fromDoc(messageDoc));
      }

      log('messages num: ${messages.length}');
      return messages;
    });
  }

  void onAppBarPressed() {
    // Get.to(
    //   () => UserDetailsScreen(
    //     name: widget.name,
    //     image: widget.image,
    //     chatPath: widget.chatPath,
    //     isGroup: isGroupChat,
    //   ),
    // );
  }

  String getUserbyId(senderId) {
    return '';
  }
}
