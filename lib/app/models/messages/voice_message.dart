import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import '../message_type.dart';

class AudioMessage extends MessageInterface {
  AudioMessage({
    required super.isSent,
    required super.isSeen,
    required super.chatId,
    required super.senderName,
    required super.timeSent,
    super.senderImage,
    required super.senderId,
    this.text,
    required this.audio,
  }) : super(type: MessageType.audio);

  String audio;
  String? text;

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'text': text,
        'voice': audio,
      });
  }

  @override
  factory AudioMessage.fromDoc(DocumentSnapshot<Object?> map) {
    return AudioMessage(
      isSent: false,
      isSeen: false,
      // isSent: map['isSent'],
      // isSeen: map['isSeen'],
      chatId: map.id,
      senderId: map['senderId'],
      senderName: map['senderName'],
      senderImage: map['senderImage'],
      audio: map['audio'],
      text: map['text'],

      timeSent: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  @override
  factory AudioMessage.toSend({required String chatId, String? text, required String audio}) {
    return AudioMessage(
      isSent: false,
      isSeen: false,
      chatId: chatId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      senderName: MySharedPref.getUserName!,
      senderImage: MySharedPref.getUserImage,
      timeSent: DateTime.now(),
      text: text,
      audio: audio,
    );
  }
}
