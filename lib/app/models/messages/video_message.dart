import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/app/models/message_type.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

class VideoMessage extends MessageInterface {
  /// json fields names (to ensure that i always (send) and (recieve) the right field name)
  static const video_name_key = 'videoName';
  static const video_url_key = 'videoUrl';

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
  }) : super(type: MessageType.video);

  String videoUrl;
  String videoName;
  String? text;

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'text': text,
        video_name_key:videoName,
        video_url_key: videoUrl,
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
      videoUrl: map[video_url_key],
      videoName: map[video_name_key],
      text: map['text'],
      timeSent: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  @override
  factory VideoMessage.toSend(
      {required String chatId, required String? text, required String videoName, required String videoUrl}) {
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
