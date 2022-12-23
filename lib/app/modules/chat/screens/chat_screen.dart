import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/helpers/message_bubble_settings.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key})
      : controller = Get.put(ChatScreenController()),
        super(key: key);

  final ChatScreenController controller;

  @override
  Widget build(BuildContext context) {
    Rx<ChatBacground> chatBackgroundType = MessageBubbleSettings.backgroundType;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: controller.onAppBarPressed,
          child: Row(
            children: [
              Hero(
                tag: controller.chat.image!,
                child: CircleAvatar(
                  backgroundImage: controller.chat.imageProvider,
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
                    controller.chat.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
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
            children: const [
              // Expanded(
              //   child: Messages(
              //     chatId: chatId,
              //   ),
              // ),
              // ChatTextField(
              //   chatId: controller.chat.id,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
