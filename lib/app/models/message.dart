// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import 'message_type.dart';

class Message {
  bool isSent = false;
  bool isSeen = false;

  final String chatId;

  String? senderId;
  String? senderImage;
  String senderName;

  bool get isMyMessage => senderId == FirebaseAuth.instance.currentUser!.uid;

  final DateTime timeSent;

  final String? text;

  final MessageType type;

  String? image; //the file path stored in the device

  String? video; //the file path stored in the device

  String? audio; //the file path stored in the device

  String? file; //the file path stored in the device

  Message({
    this.type = MessageType.text,
    required this.senderId,
    required this.chatId,
    required this.text,
    required this.senderImage,
    required this.senderName,
    required this.timeSent,
  });
  Message._generic({
    this.type = MessageType.text,
    required this.senderId,
    required this.chatId,
    required this.text,
    required this.video,
    required this.audio,
    required this.image,
    required this.file,
    required this.senderImage,
    required this.senderName,
    required this.timeSent,
  });

  Message.image({
    this.type = MessageType.photo,
    required this.chatId,
    required this.senderId,
    this.text,
    required this.image,
    required this.senderImage,
    required this.senderName,
    required this.timeSent,
  });

  Message.video({
    this.type = MessageType.video,
    required this.chatId,
    this.text,
    required this.video,
    required this.senderId,
    required this.senderImage,
    required this.senderName,
    required this.timeSent,
  });
  Message.file({
    this.type = MessageType.file,
    required this.chatId,
    this.text,
    required this.file,
    required this.senderId,
    required this.senderImage,
    required this.senderName,
    required this.timeSent,
  });

  Message.audio({
    this.type = MessageType.audio,
    required this.chatId,
    this.text,
    required this.audio,
    required this.senderId,
    required this.senderImage,
    required this.senderName,
    required this.timeSent,
  });

  factory Message.fromDoc(DocumentSnapshot map) {
    final messageType = msgTypeEnumfromString(map['type']);

    return Message._generic(
      // isSent: map['isSent'],
      // isSeen: map['isSeen'],
      chatId: map.id,
      senderId: map['senderId'],
      senderName: map['senderName'],
      senderImage: map['senderImage'],
      text: map['text'],
      type: messageType,
      image: messageType == MessageType.photo ? map['image'] : null,
      video: messageType == MessageType.video ? map['video'] : null,
      audio: messageType == MessageType.audio ? map['audio'] : null,
      file: messageType == MessageType.file ? map['file'] : null,
      timeSent: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'createdAt': Timestamp.now(),
      'senderId': senderId,
      'senderName': senderName,
      'senderImage': senderImage,
      'type': type.name,
      if (image != null) 'image': image,
      if (video != null) 'video': video,
      if (audio != null) 'audio': audio,
      if (file != null) 'file': file,
    };
  }

  /// this factory is useful when sending a message
  /// Note: You have to change the appropriate field (according to message type)
  ///
  factory Message.toSend({
    required MessageType msgType,
    required String chatId,
    String? text,
    String? image,
    String? video,
    String? audio,
    String? file,
  }) {
    return Message._generic(
      chatId: chatId,
      type: msgType,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      senderName: MySharedPref.getUserName!,
      senderImage: MySharedPref.getUserImage,
      timeSent: DateTime.now(),
      text: text,
      image: image,
      video: video,
      audio: audio,
      file: file,
    );
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId &&
        other.text == text &&
        other.type == type &&
        other.image == image &&
        other.video == video &&
        other.audio == audio &&
        other.file == file;
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
        text.hashCode ^
        type.hashCode ^
        image.hashCode ^
        video.hashCode ^
        audio.hashCode ^
        file.hashCode;
  }
}

// {
//     assert(isMyMessage && senderId == null || !isMyMessage && senderId != null,
//         'You cant set \'isAmItheSender= true AND set the senderId to a value at the same time!!\'');

//     if (isMyMessage) {
//       senderId = FirebaseAuth.instance.currentUser!.uid;
//     }
//   }
