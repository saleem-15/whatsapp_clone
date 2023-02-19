import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';

import '../../providers/users_provider.dart';
import '../message_type_enum.dart';

class AudioMessage extends MessageInterface {
  static const AUDIO_KEY = 'audioUrl';
  // static const AUDIO_FILE_NAME_KEY = 'fileName';

  AudioMessage({
    required super.isSent,
    required super.isSeen,
    required super.chatId,
    required super.senderName,
    required super.timeSent,
    super.senderImage,
    required super.senderId,
    this.audioUrl,
    this.audioPath,
  }) : super(type: MessageType.audio);

  String? audioUrl;
  String? audioPath;

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        AUDIO_KEY: audioUrl,
      });
  }

  @override
  factory AudioMessage.fromDoc(DocumentSnapshot doc) {
    // Logger().d(map.data());
    var x = AudioMessage(
      isSent: false,
      isSeen: false,
      chatId: doc.id,
      senderId: doc[MessageInterface.SENDER_ID_KEY],
      senderName: doc[MessageInterface.SENDER_NAME_KEY],
      senderImage: doc[MessageInterface.SENDER_image_KEY],
      audioUrl: doc[AUDIO_KEY],
      timeSent: doc.getDateTime(MessageInterface.CREATED_AT_KEY)!,
    )..messageId = doc.id;

    // Logger().d(x);
    return x;
  }

  AudioMessage.toSend({
    required super.chatId,
    required super.timeSent,
    required this.audioPath,
  }) : super(
          type: MessageType.audio,
          isSeen: false,
          isSent: false,
          senderId: Get.find<UsersProvider>().me.value.uid,
          senderName: Get.find<UsersProvider>().me.value.name,
          senderImage: Get.find<UsersProvider>().me.value.imageUrl,
        );

  factory AudioMessage.fromFileMessage(FileMessage fileMessage) {
    return AudioMessage.toSend(
      chatId: fileMessage.chatId,
      timeSent: fileMessage.timeSent,
      audioPath: fileMessage.filePath,
    )..audioUrl = fileMessage.filePath;
  }

  @override
  String toString() => 'AudioMessage(audioUrl: $audioUrl, ${super.toString()})';

  factory AudioMessage.fromNotificationPayload(Map<String, dynamic> map) {
    return AudioMessage(
      isSent: false,
      isSeen: false,
      chatId: map['chatId'],
      timeSent: map[MessageInterface.CREATED_AT_KEY],
      senderId: map[MessageInterface.SENDER_ID_KEY],
      senderName: map[MessageInterface.SENDER_NAME_KEY],
      senderImage: map[MessageInterface.SENDER_image_KEY],
      audioUrl: map[AUDIO_KEY],
    );
  }
}
