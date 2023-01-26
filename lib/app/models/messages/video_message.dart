import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import '../message_type_enum.dart';

enum MediaType {
  landscape,
  portrait,
}

class VideoMessage extends MessageInterface {
  /// json fields names (to ensure that i always (send) and (recieve) the right field name)
  static const VIDEO_NAME_KEY = 'videoName';
  static const VIDEO_URL_KEY = 'videoUrl';
  static const VIDEO_WIDTH_KEY = 'width';
  static const VIDEO_HEIGHT_KEY = 'height';

  VideoMessage({
    required super.isSent,
    required super.isSeen,
    required super.chatId,
    required super.senderName,
    required super.timeSent,
    super.senderImage,
    required super.senderId,
    this.text,
    required this.videoUrl,
    required this.videoName,
    int? height,
    int? width,
  })  : height = height!,
        width = width!,
        super(type: MessageType.video);

  ///used to display the video message with correct dimensions
  ///even before the video is downloaded
  late final int width;
  late final int height;

  String videoUrl;
  String videoName;
  String? text;

  double get aspectRatio => height / width;
  MediaType get mediaType {
    if (width > height) {
      return MediaType.landscape;
    }

    return MediaType.portrait;
  }

  @override

  /// its called before sending to the backend,
  /// it's responiple for formatting the video message json body
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'text': text,
        VIDEO_NAME_KEY: videoName,
        VIDEO_URL_KEY: videoUrl,
        VIDEO_HEIGHT_KEY: height,
        VIDEO_WIDTH_KEY: width,
      });
  }

  @override
  factory VideoMessage.fromDoc(DocumentSnapshot<Object?> map) {
    return VideoMessage(
      isSent: false,
      isSeen: false,
      // isSent: map['isSent'],
      // isSeen: map['isSeen'],
      chatId: map.id,
      senderId: map['senderId'],
      senderName: map['senderName'],
      senderImage: map['senderImage'],
      videoUrl: map[VIDEO_URL_KEY],
      videoName: map[VIDEO_NAME_KEY],
      text: map['text'],
      timeSent: (map['createdAt'] as Timestamp).toDate(),
      width: map['width'],
      height: map['height'],
    );
  }
  factory VideoMessage.fromFileMessage(FileMessage fileMessage) {
    return VideoMessage.toSend(
      chatId: fileMessage.chatId,
      text: null,
      videoName: fileMessage.file,
      videoUrl: fileMessage.fileName,
    );
  }

  @override
  factory VideoMessage.toSend({
    required String chatId,
    required String? text,
    required String videoName,
    required String videoUrl,
  }) {
    return VideoMessage(
      isSent: false,
      isSeen: false,
      chatId: chatId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      senderName: MySharedPref.getUserName!,
      senderImage: MySharedPref.getUserImage,
      timeSent: DateTime.now(),
      text: text,
      videoUrl: videoUrl,
      videoName: videoName,
    );
  }
}
