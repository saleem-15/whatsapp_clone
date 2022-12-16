// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


import 'message_type.dart';


class Message {
  bool isSent = false;
  bool isSeen = false;

  final String chatPath;

  final String senderId;

  final DateTime timeSent = DateTime.now();

  final String? text;

  final MessageType type;

  String? image; // the file path stored in the device

  String? video; // the file path stored in the device

  String? audio; // the file path stored in the device

  String? file; // the file path stored in the device

  Message({
    this.type = MessageType.text,
    required this.chatPath,
    required this.text,
    required this.senderId,
  });

  Message.image({
    required this.chatPath,
    this.text,
    this.type = MessageType.photo,
    required this.image,
    required this.senderId,
  });

  Message.video({
    required this.chatPath,
    this.text,
    this.type = MessageType.video,
    required this.video,
    required this.senderId,
  });

  Message.file({
    required this.chatPath,
    this.text,
    this.type = MessageType.file,
    required this.file,
    required this.senderId,
  });

  Message.audio({
    required this.chatPath,
    this.text,
    this.type = MessageType.audio,
    required this.audio,
    required this.senderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatPath': chatPath,
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

    return other.chatPath == chatPath &&
        other.text == text &&
        other.type == type &&
        other.image == image &&
        other.video == video &&
        other.audio == audio &&
        other.file == file;
  }

  @override
  int get hashCode {
    return chatPath.hashCode ^
        text.hashCode ^
        type.hashCode ^
        image.hashCode ^
        video.hashCode ^
        audio.hashCode ^
        file.hashCode;
  }
}
