import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/app/providers/users_provider.dart';

import '../../modules/chat/components/messages/media_message_size.dart';
import '../message_type_enum.dart';



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
    required this.videoPath,
    int? height,
    int? width,
  })  : assert(videoUrl != null),
        height = height!,
        width = width!,
        super(type: MessageType.video);

  ///used to display the video message with correct dimensions
  ///even before the video is downloaded
  late final int width;
  late final int height;

  String? videoUrl;
  String videoPath;
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
        VIDEO_NAME_KEY: videoPath,
        VIDEO_URL_KEY: videoUrl,
        VIDEO_HEIGHT_KEY: height,
        VIDEO_WIDTH_KEY: width,
      });
  }

  @override
  factory VideoMessage.fromDoc(DocumentSnapshot doc) {
    return VideoMessage(
      isSent: false,
      isSeen: false,
      chatId: doc.id,
      senderId: doc['senderId'],
      senderName: doc['senderName'],
      senderImage: doc['senderImage'],
      videoUrl: doc[VIDEO_URL_KEY],
      videoPath: doc[VIDEO_NAME_KEY],
      text: doc['text'],
      timeSent: doc.getDateTime('createdAt')!,
      width: doc[VIDEO_WIDTH_KEY],
      height: doc[VIDEO_HEIGHT_KEY],
    )..messageId = doc.id;
  }

  factory VideoMessage.fromNotificationPayload(Map<String, dynamic> map) {
    return VideoMessage(
      isSent: false,
      isSeen: false,
      chatId: map['chatId'],
      senderName: map[MessageInterface.SENDER_NAME_KEY],
      timeSent: map[MessageInterface.CREATED_AT_KEY],
      senderId: map[MessageInterface.SENDER_ID_KEY],
      text: map[MessageInterface.TEXT_KEY],
      videoPath: map[VIDEO_NAME_KEY],
      videoUrl: map[VIDEO_URL_KEY],
      height: map[VIDEO_HEIGHT_KEY],
      width: map[VIDEO_WIDTH_KEY],
      senderImage: map[MessageInterface.SENDER_image_KEY],
    );
  }
  factory VideoMessage.fromFileMessage(FileMessage fileMessage, int width, int height) {
    return VideoMessage.toSend(
      chatId: fileMessage.chatId,
      text: null,
      videoPath: fileMessage.downloadUrl,
      width: width,
      height: height,
    )..videoUrl = fileMessage.fileName;
  }

  VideoMessage.toSend({
    required super.chatId,
    this.text,
    required this.videoPath,
    int? height,
    int? width,
  })  : height = height!,
        width = width!,
        super(
          type: MessageType.video,
          isSeen: false,
          isSent: false,
          senderId: Get.find<UsersProvider>().me!.uid,
          senderName: Get.find<UsersProvider>().me!.name,
          senderImage: Get.find<UsersProvider>().me!.imageUrl,
          timeSent: DateTime.now(),
        );
}
