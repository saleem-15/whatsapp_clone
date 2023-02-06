import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import '../message_type_enum.dart';

class TextMessage extends MessageInterface {
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
  factory TextMessage.fromDoc(DocumentSnapshot<Object?> map) {
    return TextMessage(
      isSent: false,
      isSeen: false,
      // isSent: map['isSent'],
      // isSeen: map['isSeen'],
      chatId: map.id,
      senderId: map['senderId'],
      senderName: map['senderName'],
      senderImage: map['senderImage'],
      text: map['text'],
      timeSent: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  ///parameters are => chatId
  @override
  factory TextMessage.toSend({required String chatId, required String text}) {
    return TextMessage(
      isSent: false,
      isSeen: false,
      chatId: chatId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      senderName: MySharedPref.getUserName!,
      senderImage: MySharedPref.getUserImage,
      timeSent: DateTime.now(),
      text: text,
    );
  }

  @override
  String toString() =>
      'Text Message(chatId: $chatId, timeSent: $timeSent, text: $text, senderName: $senderName)';

  factory TextMessage.fromNotificationPayload(Map<String, dynamic> map) {
    return TextMessage(
      isSent: false,
      isSeen: false,
      chatId: map['chatId'],
      senderName: map[MessageInterface.SENDER_NAME_KEY],
      timeSent: map[MessageInterface.CREATED_AT_KEY],
      senderId: map[MessageInterface.SENDER_ID_KEY],
      text: map[MessageInterface.TEXT_KEY],
    );
  }
}
