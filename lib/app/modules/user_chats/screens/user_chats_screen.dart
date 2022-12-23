import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/user_chats/controllers/chats_view_controller.dart';
import 'package:whatsapp_clone/app/modules/user_chats/components/chat_tile.dart';

class ChatsTapView extends GetView<ChatsViewController> {
  const ChatsTapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatsViewController>(
      builder: (controller) {
        final myChats = controller.myChatsList;

        if (myChats.isEmpty) {
          return const Center(
            child: Text('There is no chats'),
          );
        }
        return ListView.builder(
          itemCount: myChats.length,
          itemBuilder: (context, index) {
            //
            final chat = myChats[index].value;

            return ChatTile(
              chat: chat,
            );
          },
        );
      },
    );
  }
}
