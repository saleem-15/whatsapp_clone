import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/messages/message.dart';

import '../../providers/users_provider.dart';
import '../message_type_enum.dart';

class TextMessage extends Message {
  TextMessage({
    required super.isSent,
    required super.isSeen,
    required super.chatId,
    required super.senderName,
    required super.timeSent,
    super.senderImage,
    required super.senderId,
    required this.text,
  }) : super(type: MessageType.text);

  String text;

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'text': text,
      });
  }

  @override
  factory TextMessage.fromDoc(DocumentSnapshot doc) {
    return TextMessage(
      isSent: false,
      isSeen: false,
      chatId: doc.id,
      senderId: doc['senderId'],
      senderName: doc['senderName'],
      senderImage: doc['senderImage'],
      text: doc['text'],
      timeSent: (doc['createdAt'] as Timestamp).toDate(),
    )..messageId = doc.id;
  }

  ///parameters are => chatId
  @override
  factory TextMessage.toSend({required String chatId, required String text}) {
    final user = Get.find<UsersProvider>().me.value;

    return TextMessage(
      isSent: false,
      isSeen: false,
      chatId: chatId,
      senderId: user.uid,
      senderName: user.name,
      senderImage: user.imageUrl,
      timeSent: DateTime.now(),
      text: text,
    );
  }

  @override
  String toString() =>
      'Text Message(chatId: $chatId, timeSent: $timeSent, text: $text, senderName: $senderName)';

  factory TextMessage.fromNotificationPayload(Map<String, dynamic> map) {
    var x = TextMessage(
      isSent: false,
      isSeen: false,
      senderImage: map[Message.SENDER_image_KEY],
      chatId: map[Message.CHAT_ID_KEY],
      senderName: map[Message.SENDER_NAME_KEY],
      timeSent: DateTime.parse(map[Message.CREATED_AT_KEY]),
      senderId: map[Message.SENDER_ID_KEY],
      text: map[Message.TEXT_KEY],
    )..messageId = map[Message.MESSAGE_ID_KEY];

    return x;
  }
}
