import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/message_type_enum.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/models/messages/text_message.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/models/messages/audio_message.dart';
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
    return Obx(
      () => ListView.builder(
        reverse: true,
        itemCount: controller.messagesList.length,
        itemBuilder: (_, index) {
          final message = controller.messagesList[index];

          return Row(
            mainAxisAlignment: message.isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  Key key = Key('${message.databaseId}');
                  switch (message.type) {
                    case MessageType.text:
                      return MessageBubble(
                        key: key,
                        message: message as TextMessage,
                      );
                    case MessageType.image:
                      message as ImageMessage;
                      return ImageMessageBubble(
                        key: key,
                        message: message,
                      );

                    case MessageType.video:
                      message as VideoMessage;
                      return VideoMessageBubble(
                        key: key,
                        message: message,
                        // video: message.videoUrl,
                      );

                    case MessageType.audio:
                      message as AudioMessage;
                      return AudioMessageBubble(
                        key: key,
                        isMyMessage: message.isMyMessage,
                        audioPath: message.audioUrl!,
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
              ),
            ],
          );
        },
      ),
    );
  }
}
