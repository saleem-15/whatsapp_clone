import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import '../message_type_enum.dart';
import 'file_message.dart';

class ImageMessage extends MessageInterface {
  /// json fields names (to ensure that i always (send) and (recieve) the right field name)
  static const IMAGE_NAME_KEY = 'imageName';
  static const IMAGE_URL_KEY = 'imageUrl';

  ImageMessage({
    required super.isSent,
    required super.isSeen,
    required super.chatId,
    required super.senderName,
    required super.timeSent,
    super.senderImage,
    required super.senderId,
    this.text,
    required this.imageUrl,
    required this.imageName,
  }) : super(type: MessageType.image);

  String imageUrl;
  String imageName;
  String? text;

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'text': text,
        IMAGE_URL_KEY: imageUrl,
        IMAGE_NAME_KEY: imageName,
      });
  }

  @override
  factory ImageMessage.fromDoc(DocumentSnapshot<Object?> map) {
    return ImageMessage(
      isSent: false,
      isSeen: false,
      // isSent: map['isSent'],
      // isSeen: map['isSeen'],
      chatId: map.id,
      senderId: map['senderId'],
      senderName: map['senderName'],
      senderImage: map['senderImage'],
      imageUrl: map[IMAGE_URL_KEY],
      imageName: map[IMAGE_NAME_KEY],
      text: map['text'],
      timeSent: map.getDateTime('createdAt')!,
    );
  }

  ///parameters are => chatId
  @override
  factory ImageMessage.toSend({
    required String chatId,
    required String? text,
    required String imageUrl,
    required String imageName,
  }) {
    return ImageMessage(
      isSent: false,
      isSeen: false,
      chatId: chatId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      senderName: MySharedPref.getUserName!,
      senderImage: MySharedPref.getUserImage,
      timeSent: DateTime.now(),
      text: text,
      imageUrl: imageUrl,
      imageName: imageName,
    );
  }

  factory ImageMessage.fromFileMessage(FileMessage fileMessage) {
    return ImageMessage.toSend(
      chatId: fileMessage.chatId,
      text: null,
      imageName: fileMessage.file,
      imageUrl: fileMessage.fileName,
    );
  }

  factory ImageMessage.fromNotificationPayload(Map<String, dynamic> map) {
    return ImageMessage(
      isSent: false,
      isSeen: false,
      chatId: map['chatId'],
      timeSent: map[MessageInterface.CREATED_AT_KEY],
      senderId: map[MessageInterface.SENDER_ID_KEY],
      senderName: map[MessageInterface.SENDER_NAME_KEY],
      senderImage: map[MessageInterface.SENDER_image_KEY],
      imageUrl: map[IMAGE_URL_KEY],
      imageName: map[IMAGE_NAME_KEY],
      text: map[MessageInterface.TEXT_KEY],
    );
  }
}
