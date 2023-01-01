import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/my_image.dart';
import 'package:whatsapp_clone/utils/helpers/message_bubble_settings.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

///this is documentaion
class ImageMessageBubble extends GetView<ChatScreenController> {
  const ImageMessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ImageMessage message;

  final double borderRadius = 15;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          onTap: () => controller.onImagePressed(message),
          child: Container(
            // height: 100,
            width: 300,
            margin: MessageBubbleSettings.messageMargin(
              isMyMessage: message.isMyMessage,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
              color: message.isMyMessage
                  ? MessageBubbleSettings.myMessageColor
                  : MessageBubbleSettings.othersMessageColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Sender Name (shown if its not my message)
                if (!message.isMyMessage)
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 8, top: 3),
                    child: Text(
                      message.senderName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                /// image && time sent
                Stack(
                  children: [
                    /// The image
                    Hero(
                      tag: message.imageUrl,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius),
                        child: NetworkOrLocalImage(
                          chatId: message.chatId,
                          fileName: message.imageName,
                          imageUrl: message.imageUrl,
                        ),
                      ),
                    ),

                    /// time sent
                    Positioned(
                      bottom: 5,
                      right: 8,
                      child: Text(
                        Utils.formatDate(message.timeSent),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),

                /// Text (shown if there is any)
                if (message.text != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                    child: Text(
                      message.text!,
                      style: MessageBubbleSettings.messageTextStyle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
