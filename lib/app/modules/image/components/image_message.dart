import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/modules/chat/components/messages/media_message_size.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/my_image.dart';
import 'package:whatsapp_clone/utils/helpers/message_bubble_settings.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

///this is documentaion
class ImageMessageBubble extends GetView<ChatScreenController> {
  ImageMessageBubble({
    super.key,
    required this.message,
  }) : displayedSize = MediaMessageSize.calculateMediaSize(
          messageHeight: message.height.toDouble(),
          messageWidth: message.width.toDouble(),
        );

  final ImageMessage message;

  /// the calculated video size
  late final Size displayedSize;
  final double borderRadius = 15;

  @override
  Widget build(BuildContext context) {
    Logger().i('''
image message: sender: ${message.senderName}
image actual size: (${message.width},${message.height})
Image Message Bubble ${displayedSize.toString()}''');
    return GestureDetector(
      onTap: () => controller.onImagePressed(message),
      child: Container(
        margin: MessageBubbleSettings.messageMargin(
          isMyMessage: message.isMyMessage,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
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
                SizedBox.fromSize(
                  size: displayedSize,
                  child: Hero(
                    tag: message.databaseId,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: SavedNetworkImage(
                        chatId: message.chatId,
                        imageFilePath: message.imagePath,
                        imageUrl: message.imageUrl,
                        timeSent: message.timeSent,
                        onImageDownloaded: (image) => controller.onImageDownloaded(message, image),
                      ),
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
              Container(
                /// the caption must have the wirth of the image
                width: displayedSize.width,
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                child: Text(
                  message.text!,
                  style: MessageBubbleSettings.messageTextStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
