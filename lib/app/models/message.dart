// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'message_type.dart';

class Message {
  bool isSent = false;
  bool isSeen = false;

  final String chatId;

  String? senderId;
  final bool isAmItheSender;

  final DateTime timeSent = DateTime.now();

  final String? text;

  final MessageType type;

  String? image; //the file path stored in the device

  String? video; //the file path stored in the device

  String? audio; //the file path stored in the device

  String? file; //the file path stored in the device

  Message({
    this.type = MessageType.text,
    this.isAmItheSender = false,
    this.senderId,
    required this.chatId,
    required this.text,
  }) {
    assert(isAmItheSender && senderId == null || !isAmItheSender && senderId != null,
        'You cant set \'isAmItheSender= true AND set the senderId to a value at the same time!!\'');

    if (isAmItheSender) {
      senderId = FirebaseAuth.instance.currentUser!.uid;
    }
  }

  Message.image({
    this.type = MessageType.photo,
    required this.chatId,
    this.isAmItheSender = false,
    this.senderId,
    this.text,
    required this.image,
  }) {
    assert(isAmItheSender && senderId == null || !isAmItheSender && senderId != null,
        'You cant set \'isAmItheSender= true AND set the senderId to a value at the same time!!\'');

    if (isAmItheSender) {
      senderId = FirebaseAuth.instance.currentUser!.uid;
    }
  }

  Message.video({
    this.type = MessageType.video,
    required this.chatId,
    this.text,
    required this.video,
    this.isAmItheSender = false,
    this.senderId,
  }) {
    assert(isAmItheSender && senderId == null || !isAmItheSender && senderId != null,
        'You cant set \'isAmItheSender= true AND set the senderId to a value at the same time!!\'');

    if (isAmItheSender) {
      senderId = FirebaseAuth.instance.currentUser!.uid;
    }
  }

  Message.file({
    this.type = MessageType.file,
    required this.chatId,
    this.text,
    required this.file,
    this.isAmItheSender = false,
    this.senderId,
  }) {
    assert(isAmItheSender && senderId == null || !isAmItheSender && senderId != null,
        'You cant set \'isAmItheSender= true AND set the senderId to a value at the same time!!\'');

    if (isAmItheSender) {
      senderId = FirebaseAuth.instance.currentUser!.uid;
    }
  }

  Message.audio({
    this.type = MessageType.audio,
    required this.chatId,
    this.text,
    required this.audio,
    this.isAmItheSender = false,
    this.senderId,
  }) {
    assert(isAmItheSender && senderId == null || !isAmItheSender && senderId != null,
        'You cant set \'isAmItheSender= true AND set the senderId to a value at the same time!!\'');

    if (isAmItheSender) {
      senderId = FirebaseAuth.instance.currentUser!.uid;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'chatPath': chatId,
      'text': text,
      'type': type.name,
      'image': image,
      'video': video,
      'audio': audio,
      'file': file,
    };
  }

  // factory Message.fromMap(Map<String, dynamic> map) {
  //   return Message(
  //     chatPath: map['chatPath'],
  //     text: map['text'],
  //     type: MessageType.fromMap(map['type']),
  //     image: File.fromMap(map['image']),
  //     video: File.fromMap(map['video']),
  //     audio: File.fromMap(map['audio']),
  //     file: File.fromMap(map['file']),
  //   );
  // }
  String toJson() => json.encode(toMap());
//  factory Message.fromJson(String source) => Message.fromMap(json.decode(source));

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
