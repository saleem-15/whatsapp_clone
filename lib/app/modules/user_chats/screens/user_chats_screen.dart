import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/user_chats/chats_view_controller.dart';
import 'package:whatsapp_clone/app/modules/user_chats/components/chat_tile.dart';

class ChatsTapView extends StatelessWidget {
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

            return chat.isGroupChat
                ? Column(
                    children: [
                      ChatTile(chatPath: chat.chatPath),
                      const Divider(
                        height: 0,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      ChatTile.user(
                        userId: chat.usersIds[0],
                        chatPath: chat.chatPath,
                      ),
                      const Divider(
                        height: 0,
                      ),
                    ],
                  );
          },
        );
      },
    );
  }
}
