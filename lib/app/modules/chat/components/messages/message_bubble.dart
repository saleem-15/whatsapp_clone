// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:whatsapp_clone/app/models/messages/text_message.dart';
import 'package:whatsapp_clone/utils/helpers/message_bubble_settings.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final TextMessage message;

  @override
  Widget build(BuildContext context) {
    final messageMaxWidth = MediaQuery.of(context).size.width - 40;
    final List<bool> c = _calcLastLineEnd(context, messageMaxWidth - 10, message.text);
    final Rx<bool> isNeedPAdding = c[0].obs;
    final Rx<bool> isNeedNewLine = c[1].obs;
    final hasEmoji = Utils.hasEmoji(message.text);

    var fontSize = MessageBubbleSettings.fontSize;
    return Row(
      mainAxisAlignment: message.isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: MessageBubbleSettings.messageMargin(
            isMyMessage: message.isMyMessage,
          ),
          constraints: BoxConstraints(maxWidth: messageMaxWidth),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     color: const Color.fromARGB(255, 199, 197, 197).withOpacity(0.8),
            //     spreadRadius: 1,
            //     blurRadius: 2,
            //     offset: const Offset(0, 1), // changes position of shadow
            //   ),
            // ],
            borderRadius: BorderRadius.only(
              topRight: message.isMyMessage ? Radius.zero : const Radius.circular(20),
              topLeft: message.isMyMessage ? const Radius.circular(20) : Radius.zero,
              bottomRight: const Radius.circular(20),
              bottomLeft: const Radius.circular(20),
            ),
            color: message.isMyMessage
                ? MessageBubbleSettings.myMessageColor
                : MessageBubbleSettings.othersMessageColor,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!message.isMyMessage)

                    /// sender Name
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        message.senderName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.only(
                        bottom: isNeedNewLine.value ? 20 : 0,
                        right: isNeedPAdding.value || hasEmoji ? 55 : 0,
                      ),

                      /// text
                      child: Text(
                        message.text,
                        style: MessageBubbleSettings.messageTextStyle,
                      ),
                    ),
                  ),
                ],
              ),

              /// time sent
              Positioned(
                bottom: -3,
                right: 0,
                child: Text(
                  Utils.formatDate(message.timeSent),
                  style: MessageBubbleSettings.timeSentTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<bool> _calcLastLineEnd(BuildContext context, double maxWidth, String msg) {
    // self-defined constraint
    final constraints = BoxConstraints(
      maxWidth: maxWidth, // maxwidth calculated
      minHeight: 30.0,
      minWidth: 80.0,
    );
    final richTextWidget = Text.rich(TextSpan(text: msg)).build(context) as RichText;
    final renderObject = richTextWidget.createRenderObject(context);
    renderObject.layout(constraints);
    final boxes = renderObject.getBoxesForSelection(
        TextSelection(baseOffset: 0, extentOffset: TextSpan(text: msg).toPlainText().length));
    bool needPadding = false, needNextline = false;
    if (boxes.length < 2 && boxes.last.right < 630) needPadding = true;
    if (boxes.length < 2 && boxes.last.right > 630) needNextline = true;
    if (boxes.length > 1 && boxes.last.right > 630) needNextline = true;
    return [needPadding, needNextline];
  }
}
