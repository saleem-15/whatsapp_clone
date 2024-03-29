import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/message.dart';
import 'package:whatsapp_clone/app/providers/users_provider.dart';
import 'package:whatsapp_clone/storage/files_manager.dart';

import '../message_type_enum.dart';

class VideoMessage extends Message {
  /// json fields names (to ensure that i always (send) and (recieve) the right field name)
  static const VIDEO_NAME_KEY = 'videoName';
  static const VIDEO_URL_KEY = 'videoUrl';
  static const VIDEO_WIDTH_KEY = 'width';
  static const VIDEO_HEIGHT_KEY = 'height';

  VideoMessage({
    super.databaseId,
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
  })  : assert(videoUrl != null || videoPath != null),
        height = height!,
        width = width!,
        super(type: MessageType.video);

  ///used to display the video message with correct dimensions
  ///even before the video is downloaded
  late final int width;
  late final int height;

  /// if the message has been recieved now => it has a [videoUrl].
  ///
  /// if I sent the message now => [videoUrl] is null.
  String? videoUrl;

  /// the file path that the video `should be stored at`.
  ///
  /// `Note: the file may not exist`
  /// 
  ///  `when downloading the video, the video should be saved in this path` 
  String videoPath;


  String? text;

  double get aspectRatio => width / height;

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
    var chatId = doc.id;
    var timeSent = doc.getDateTime('createdAt')!;

    /// the file path that the video should be stored at
    var filePath = FileManager.generateMediaFileName(FileType.video, chatId, timeSent);
    return VideoMessage(
      isSent: false,
      isSeen: false,
      chatId: chatId,
      senderId: doc['senderId'],
      senderName: doc['senderName'],
      senderImage: doc['senderImage'],
      videoUrl: doc[VIDEO_URL_KEY],
      videoPath: doc[VIDEO_NAME_KEY],
      text: doc['text'],
      timeSent: timeSent,
      width: doc[VIDEO_WIDTH_KEY],
      height: doc[VIDEO_HEIGHT_KEY],
    )
      ..messageId = doc.id
      ..videoPath = filePath;
  }

  factory VideoMessage.fromNotificationPayload(Map<String, dynamic> map) {
    var chatId = map['chatId'];
    var timeSent = DateTime.parse(map[Message.CREATED_AT_KEY]);

    /// the file path that the video should be stored at
    var filePath = FileManager.generateMediaFileName(FileType.video, chatId, timeSent);
    var x = VideoMessage(
      isSent: false,
      isSeen: false,
      chatId: chatId,
      senderName: map[Message.SENDER_NAME_KEY],
      timeSent: timeSent,
      senderId: map[Message.SENDER_ID_KEY],
      text: map[Message.TEXT_KEY],
      videoPath: map[VIDEO_NAME_KEY],
      videoUrl: map[VIDEO_URL_KEY],
      height: int.parse(map[VIDEO_HEIGHT_KEY]),
      width: int.parse(map[VIDEO_WIDTH_KEY]),
      senderImage: map[Message.SENDER_image_KEY],
    )
      ..messageId = map[Message.MESSAGE_ID_KEY]
      ..videoPath = filePath;

    return x;
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
          senderId: Get.find<UsersProvider>().me.value.uid,
          senderName: Get.find<UsersProvider>().me.value.name,
          senderImage: Get.find<UsersProvider>().me.value.imageUrl,
          timeSent: DateTime.now(),
        );
}
