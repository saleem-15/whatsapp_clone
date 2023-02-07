// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import 'package:whatsapp_clone/app/models/messages/audio_message.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/storage/database/models/message.dart';
import 'package:whatsapp_clone/utils/exceptions/message_exceptions.dart';

import '../message_type_enum.dart';
import 'file_message.dart';
import 'text_message.dart';
import 'video_message.dart';

abstract class MessageInterface {
  static const SENDER_NAME_KEY = 'senderName';
  static const CHAT_ID_KEY = 'chatId';
  static const SENDER_ID_KEY = 'senderId';
  static const SENDER_image_KEY = 'senderImage';
  static const CREATED_AT_KEY = 'createdAt';
  static const TEXT_KEY = 'text';
  static const MESSAGE_TYPE_KEY = 'type';

  MessageInterface({
    required this.isSent,
    required this.isSeen,
    required this.chatId,
    required this.senderId,
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

  String senderId;
  String? senderImage;
  String senderName;

  bool get isMyMessage {
    return senderId == FirebaseAuth.instance.currentUser!.uid;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      SENDER_ID_KEY: senderId,
      SENDER_NAME_KEY: senderName,
      SENDER_image_KEY: senderImage,
      MESSAGE_TYPE_KEY: type.name,
      CREATED_AT_KEY: Timestamp.now(),
    };
  }

  factory MessageInterface.toSend(String chatId, Map<String, dynamic> parameters) {
    throw UnimplementedError();
  }

  factory MessageInterface.fromFirestoreDoc(DocumentSnapshot doc) {
    assert(doc.exists);

    switch (msgTypeEnumfromString(doc['type'])) {
      case MessageType.text:
        return TextMessage.fromDoc(doc);

      case MessageType.image:
        return ImageMessage.fromDoc(doc);

      case MessageType.video:
        return VideoMessage.fromDoc(doc);

      case MessageType.file:
        return FileMessage.fromDoc(doc);

      case MessageType.audio:
        Logger().w('-------Audio Message------');

        return AudioMessage.fromDoc(doc);

      default:
        Logger().e('Invalid Message type ${doc['type']}');

        throw MessageException.invalidMessageType(doc);
    }
  }
  factory MessageInterface.fromNotificationPayload(Map<String, dynamic> map) {
    switch (msgTypeEnumfromString(map['type'])) {
      case MessageType.text:
        return TextMessage.fromNotificationPayload(map);

      case MessageType.image:
        return ImageMessage.fromNotificationPayload(map);

      case MessageType.video:
        return VideoMessage.fromNotificationPayload(map);

      case MessageType.file:
        return FileMessage.fromNotificationPayload(map);

      case MessageType.audio:
        Logger().w('-------Audio Message------');

        return AudioMessage.fromNotificationPayload(map);

      default:
        Logger().e('Invalid Message type ${map['type']}');

        throw MessageException.invalidMessageType(map);
    }
  }

  factory MessageInterface.fromDB(MessageDB message) {
    switch (message.type) {
      case MessageType.text:
        return TextMessage(
          chatId: message.chatId,
          text: message.text!,
          timeSent: message.timeSent,
          isSeen: message.isSeen,
          isSent: message.isSent,
          senderId: message.sender.value!.uid,
          senderName: message.sender.value!.name,
          senderImage: message.sender.value!.imageUrl,
        );
      case MessageType.image:
        return ImageMessage(
          chatId: message.chatId,
          text: message.text!,
          timeSent: message.timeSent,
          //
          isSeen: message.isSeen,
          isSent: message.isSent,
          //
          senderId: message.sender.value!.uid,
          senderName: message.sender.value!.name,
          senderImage: message.sender.value!.imageUrl,
          //
          imageUrl: message.contentFilePath!,
          imageName: message.fileName!,
        );
      case MessageType.video:
        return VideoMessage(
          chatId: message.chatId,
          text: message.text!,
          timeSent: message.timeSent,
          //
          isSeen: message.isSeen,
          isSent: message.isSent,
          //
          senderId: message.sender.value!.uid,
          senderName: message.sender.value!.name,
          senderImage: message.sender.value!.imageUrl,
          //
          videoUrl: message.contentFilePath!,
          videoName: message.fileName!,
        );
      case MessageType.file:
        return FileMessage(
          chatId: message.chatId,
          timeSent: message.timeSent,
          //
          isSeen: message.isSeen,
          isSent: message.isSent,
          //
          senderId: message.sender.value!.uid,
          senderName: message.sender.value!.name,
          senderImage: message.sender.value!.imageUrl,
          //
          downloadUrl: message.contentFilePath!,
          fileName: '',
          fileSize: '',
        );
      case MessageType.audio:
        return AudioMessage(
          chatId: message.chatId,
          timeSent: message.timeSent,
          //
          isSeen: message.isSeen,
          isSent: message.isSent,
          //
          senderId: message.sender.value!.uid,
          senderName: message.sender.value!.name,
          senderImage: message.sender.value!.imageUrl,
          //
          audioUrl: message.contentFilePath!,
        );

      default:
        throw MessageException.invalidMessageType();
    }
  }

  @override
  String toString() =>
      'chatId: $chatId, type: $type, senderId: $senderId, senderName: $senderName, senderImage: $senderImage, timeSent: $timeSent';
}
