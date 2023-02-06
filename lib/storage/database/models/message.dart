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
import '../../../app/models/messages/message_interface.dart';

part 'message.g.dart';

@Collection(accessor: 'messages')
class MessageDB {
  MessageDB();
  Id id = Isar.autoIncrement;

  late final String chatId;

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

  ///file name (stored in the device ) ex: photo.png
  String? fileName;

  ///Special Attributes for each  Message type is stored here\
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

  factory MessageDB.fromMessageInterface(MessageInterface message) {
    switch (message.type) {
      case MessageType.text:
        message as TextMessage;
        return MessageDB()
          ..type = MessageType.text
          ..chatId = message.chatId
          ..text = message.text
          ..timeSent = message.timeSent
          //
          ..isSeen = message.isSeen
          ..isSent = message.isSent;
      //

      case MessageType.image:
        message as ImageMessage;
        return MessageDB()
          ..type = MessageType.image
          ..chatId = message.chatId
          ..text = message.text
          ..timeSent = message.timeSent
          //
          ..isSeen = message.isSeen
          ..isSent = message.isSent

          //
          ..fileURl = message.imageUrl
          ..fileName = message.imageName
          ..contentFilePath = message.imageUrl;

      case MessageType.video:
        message as VideoMessage;
        return MessageDB()
          ..type = MessageType.video
          ..chatId = message.chatId
          ..text = message.text
          ..timeSent = message.timeSent
          //
          ..isSeen = message.isSeen
          ..isSent = message.isSent

          //
          ..fileURl = message.videoUrl
          ..fileName = message.videoName
          ..setSpecialMessageAttributes({
            VideoMessage.VIDEO_WIDTH_KEY: message.width,
            VideoMessage.VIDEO_HEIGHT_KEY: message.height,
          });
      case MessageType.file:
        message as FileMessage;
        return MessageDB()
          ..type = MessageType.file
          ..chatId = message.chatId
          ..timeSent = message.timeSent
          //
          ..isSeen = message.isSeen
          ..isSent = message.isSent

          //
          ..contentFilePath = message.file
          ..fileName = message.fileName
          ..setSpecialMessageAttributes({
            ///file size
            FileMessage.FILE_SIZE_KEY: message.fileSize,
          });
      case MessageType.audio:
        message as AudioMessage;
        return MessageDB()
          ..type = MessageType.audio
          ..chatId = message.chatId
          ..timeSent = message.timeSent
          //
          ..isSeen = message.isSeen
          ..isSent = message.isSent
          //
          ..contentFilePath = message.audioUrl;
      // ..fileName = message.;

      default:
        throw MessageException.invalidMessageType();
    }
  }
}
