// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/message_type_enum.dart';
import 'package:whatsapp_clone/app/models/messages/audio_message.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/models/messages/text_message.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/utils/exceptions/message_exceptions.dart';

import '../../../app/models/messages/file_message.dart';
import '../../../app/models/messages/message.dart';

part 'message.g.dart';

@Collection(accessor: 'messages')
class MessageDB {
  MessageDB();
  Id id = Isar.autoIncrement;

  late final String chatId;

  @Index(unique: true, replace: true)

  ///This id is assigned from firbase
  ///so it will be null untill firebase respnds with the id value
  String? messageId;

  ///* This field helps to identify the message type
  @enumerated
  late final MessageType type;

  String? text;

  final sender = IsarLink<User>();

  // bool get isMyMessage => senderId == FirebaseAuth.instance.currentUser!.uid;
  //these attributes matters when i am the sender of the message

  bool isSent = false;
  bool isSeen = false;

  late final DateTime timeSent;

  /// the file path stored in the device (image,video,audio,file)
  String? contentFilePath;

  ///the download url for the file (image,video,audio,file)
  String? fileURl;

  /// Special Attributes for each  Message type is stored here\
  /// stored as json, use [setSpecialMessageAttributes] & [getSpecialMessageAttributes]
  /// to set and get this field.
  String? specialMessageAttributes;

  void setSpecialMessageAttributes(Map<String, dynamic> messageAttributes) {
    specialMessageAttributes = json.encode(messageAttributes);
  }

  Map<String, dynamic>? getSpecialMessageAttributes() {
    if (specialMessageAttributes == null) {
      return null;
    }
    return jsonDecode(specialMessageAttributes!);
  }

  factory MessageDB.fromMessageInterface(Message message) {
    switch (message.type) {
      case MessageType.text:
        message as TextMessage;
        return MessageDB()
          ..messageId = message.messageId
          ..chatId = message.chatId
          ..type = MessageType.text
          ..text = message.text
          ..timeSent = message.timeSent
          //
          ..isSeen = message.isSeen
          ..isSent = message.isSent;
      //

      case MessageType.image:
        message as ImageMessage;
        return MessageDB()
          ..messageId = message.messageId
          ..chatId = message.chatId
          ..type = MessageType.image
          ..text = message.text
          ..timeSent = message.timeSent
          //
          ..isSeen = message.isSeen
          ..isSent = message.isSent

          //
          ..fileURl = message.imageUrl
          ..contentFilePath = message.imagePath
          ..setSpecialMessageAttributes({
            ImageMessage.IMAGE_WIDTH_KEY: message.width,
            ImageMessage.IMAGE_HEIGHT_KEY: message.height,
          });

      case MessageType.video:
        message as VideoMessage;
        return MessageDB()
          ..messageId = message.messageId
          ..chatId = message.chatId
          ..type = MessageType.video
          ..text = message.text
          ..timeSent = message.timeSent
          //
          ..isSeen = message.isSeen
          ..isSent = message.isSent

          //
          ..fileURl = message.videoUrl
          ..contentFilePath = message.videoPath
          ..setSpecialMessageAttributes({
            VideoMessage.VIDEO_WIDTH_KEY: message.width,
            VideoMessage.VIDEO_HEIGHT_KEY: message.height,
          });
      case MessageType.file:
        message as FileMessage;
        return MessageDB()
          ..messageId = message.messageId
          ..chatId = message.chatId
          ..type = MessageType.file
          ..timeSent = message.timeSent
          //
          ..isSeen = message.isSeen
          ..isSent = message.isSent

          //
          ..fileURl = message.downloadUrl
          ..contentFilePath = message.filePath
          ..setSpecialMessageAttributes({
            ///file size
            FileMessage.FILE_SIZE_KEY: message.fileSize,
          });
      case MessageType.audio:
        message as AudioMessage;
        return MessageDB()
          ..messageId = message.messageId
          ..chatId = message.chatId
          ..type = MessageType.audio
          ..timeSent = message.timeSent
          //
          ..isSeen = message.isSeen
          ..isSent = message.isSent
          //
          ..fileURl = message.audioUrl
          ..contentFilePath = message.audioPath;

      default:
        throw MessageException.invalidMessageType();
    }
  }
}
