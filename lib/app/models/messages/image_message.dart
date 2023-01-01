import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import '../message_type.dart';

class ImageMessage extends MessageInterface {
  /// json fields names (to ensure that i always (send) and (recieve) the right field name)
  static const image_name = 'imageName';
  static const image_url = 'imageUrl';

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
  }) : super(type: MessageType.photo);

  String imageUrl;
  String imageName;
  String? text;

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'text': text,
        image_url: imageUrl,
        image_name: imageName,
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
      imageUrl: map[image_url],
      imageName: map[image_name],
      text: map['text'],
      timeSent: (map['createdAt'] as Timestamp).toDate(),
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
}
