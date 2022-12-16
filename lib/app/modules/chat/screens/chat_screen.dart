import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/chat/screens/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/modules/chat/components/chat_text_field.dart';
import 'package:whatsapp_clone/app/modules/chat/components/messages.dart';
import 'package:whatsapp_clone/helpers/message_bubble_settings.dart';
import 'package:whatsapp_clone/helpers/utils.dart';

class ChatScreen extends GetView<ChatScreenController> {
  ChatScreen({
    Key? key,
    required this.chatPath,
    required this.name,
    required this.image,
    required this.userId,
  }) : super(key: key);

  final String chatPath;
  final String name;
  final String image;
  final String? userId;

  String? lastSeen;

  @override
  Widget build(BuildContext context) {
    final bool isGroupChat = Utils.getCollectionId(chatPath) == 'Group_chats' ? true : false;
    Rx<ChatBacground> chatBackgroundType = MessageBubbleSettings.backgroundType;
    log('image path: $image');
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: controller.onAppBarPressed,
          child: Row(
            children: [
              Hero(
                tag: image,
                child: CircleAvatar(
                  backgroundImage: FileImage(File(image)),
                  maxRadius: 20,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  // if (!isGroupChat)
                  //   GetBuilder<ChatScreenController>(
                  //     builder: (controller) => FutureBuilder(
                  //       future: controller.getLastTimeOnline(userId!),
                  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //         if (snapshot.connectionState == ConnectionState.waiting) {
                  //           // if (lastSeen == null) {
                  //           return Text(
                  //             'Connecting ...',
                  //             style: TextStyle(color: Colors.grey[200], fontSize: 12),
                  //           );

                  //           // }
                  //           //    return Text(
                  //           //   lastSeen!,
                  //           //   style: TextStyle(color: Colors.grey[200], fontSize: 12),
                  //           // );
                  //         }

                  //         return Text(
                  //           snapshot.data,
                  //           style: TextStyle(color: Colors.grey[200], fontSize: 12),
                  //         );
                  //       },
                  //     ),
                  //   ),
                ],
              ),
            ],
          ),
        ),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(
            () => Positioned.fill(
              child: chatBackgroundType.value == ChatBacground.image
                  ? Image.asset(
                      MessageBubbleSettings.chatBackgroundImage.value,
                      fit: BoxFit.cover,
                    )
                  : Ink(
                      color: MessageBubbleSettings.chatBackgroundColor.value,
                    ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Messages(
                  chatPath: chatPath,
                ),
              ),
              ChatTextField(
                chatPath: chatPath,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
