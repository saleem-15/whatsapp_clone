import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

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
    required this.audioUrl,
  }) : super(type: MessageType.audio);

  String audioUrl;

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        AUDIO_KEY: audioUrl,
      });
  }

  @override
  factory AudioMessage.fromDoc(DocumentSnapshot map) {
    Logger().w('-------------');

    // Logger().d(map.data());
    var x = AudioMessage(
      isSent: false,
      isSeen: false,
      chatId: map.id,
      senderId: map[MessageInterface.SENDER_ID_KEY],
      senderName: map[MessageInterface.SENDER_NAME_KEY],
      senderImage: map[MessageInterface.SENDER_image_KEY],
      audioUrl: map[AUDIO_KEY],
      timeSent: map.getDateTime(MessageInterface.CREATED_AT_KEY)!,
    );
    Logger().d(x);
    return x;
  }

  @override
  factory AudioMessage.toSend({
    required String chatId,
    required String audioUrl,
    required String fileName,
  }) {
    var x = AudioMessage(
      isSent: false,
      isSeen: false,
      chatId: chatId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      senderName: MySharedPref.getUserName!,
      senderImage: MySharedPref.getUserImage,
      timeSent: DateTime.now(),
      audioUrl: audioUrl,
    );
    Logger().d(x);
    return x;
  }

  factory AudioMessage.fromFileMessage(FileMessage fileMessage) {
    return AudioMessage.toSend(
      chatId: fileMessage.chatId,
      audioUrl: fileMessage.fileName,
      fileName: fileMessage.fileName,
    );
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
