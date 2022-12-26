import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/message.dart';
import 'package:whatsapp_clone/app/models/message_type.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';
import 'audio_message.dart';
import 'image_message.dart';
import 'message_bubble.dart';
import 'video_message.dart';

class Messages extends GetView<ChatScreenController> {
  const Messages({required this.chatId, super.key});

  final String chatId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: controller.getMessagesStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final messages = snapshot.data!;
        log('num of masseges: ${messages.length}');

        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (_, index) {
            final message = messages[index];

            switch (message.type) {
              case MessageType.text:
                return MessageBubble(
                  message: message,
                );
              case MessageType.photo:
                return ImageMessageBubble(
                  message: message,
                );

              case MessageType.video:
                return VideoMessageBubble(
                  message: message,
                  video: message.video!,
                );

              case MessageType.audio:
                return AudioMessage(
                  isMyMessage: message.isMyMessage,
                  audioPath: messages[index].audio!,
                  timeSent: Utils.formatDate(message.timeSent),
                );

              default:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 170,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(child: Text('unknown message type')),
                    ),
                  ],
                );
            }
          },
        );
      },
    );
  }
}
