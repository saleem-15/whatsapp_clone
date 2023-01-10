import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';

import '../message_type_enum.dart';
import 'file_message.dart';
import 'text_message.dart';
import 'video_message.dart';

abstract class MessageInterface {
  MessageInterface({
    required this.isSent,
    required this.isSeen,
    required this.chatId,
    this.senderId,
    this.senderImage,
    required this.senderName,
    required this.timeSent,
    required this.type,
  });

  ///These 2 fields are used when I am the message sender
  bool isSent = false;
  bool isSeen = false;

  final String chatId;
  final MessageType type;
  final DateTime timeSent;


  String? senderId;
  String? senderImage;
  String senderName;

  bool get isMyMessage => senderId == FirebaseAuth.instance.currentUser!.uid;


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'senderName': senderName,
      'senderImage': senderImage,
      'type': type.name,
      'createdAt': Timestamp.now(),
    };
  }

  factory MessageInterface.toSend(String chatId, Map<String, dynamic> parameters) {
    throw UnimplementedError();
  }

  factory MessageInterface.fromDoc(DocumentSnapshot map) {
    switch (msgTypeEnumfromString(map['type'])) {
      case MessageType.text:
        return TextMessage.fromDoc(map);

      case MessageType.photo:
        return ImageMessage.fromDoc(map);

      case MessageType.video:
        return VideoMessage.fromDoc(map);

      case MessageType.file:
        return FileMessage.fromDoc(map);

      default:
        throw 'Unknown type: ${map["type"]}';
    }
  }
}
