import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/message_type_enum.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/app/models/messages/text_message.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/models/messages/voice_message.dart';
import 'package:whatsapp_clone/app/modules/chat/components/messages/file_message.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';
import 'messages/audio_message.dart';
import '../../image/components/image_message.dart';
import 'messages/message_bubble.dart';
import '../../video/components/video_message_bubble.dart';

class Messages extends GetView<ChatScreenController> {
  const Messages({required this.chatId, super.key});

  final String chatId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageInterface>>(
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

            if (index == messages.length) {
              log('last message');
            }

            switch (message.type) {
              case MessageType.text:
                return MessageBubble(
                  message: message as TextMessage,
                );
              case MessageType.photo:
                return ImageMessageBubble(
                  message: message as ImageMessage,
                );

              case MessageType.video:
                return VideoMessageBubble(
                  message: message as VideoMessage,
                  video: message.videoUrl,
                );

              case MessageType.audio:
                return AudioMessageBubble(
                  isMyMessage: message.isMyMessage,
                  audioPath: (message as AudioMessage).audio,
                  timeSent: Utils.formatDate(message.timeSent),
                );
              case MessageType.file:
                return FileMessageBubble(message: message as FileMessage);

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
