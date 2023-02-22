import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/models/messages/message.dart';

import '../../providers/users_provider.dart';
import '../message_type_enum.dart';
import 'file_message.dart';

class ImageMessage extends Message {
  /// json fields names (to ensure that i always (send) and (recieve) the right field name)
  static const IMAGE_NAME_KEY = 'imageName';
  static const IMAGE_URL_KEY = 'imageUrl';
  static const IMAGE_WIDTH_KEY = 'width';
  static const IMAGE_HEIGHT_KEY = 'height';

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
    required this.height,
    required this.width,
    required this.imagePath,
  })  : assert(imageUrl != null),
        super(type: MessageType.image);

  String? imageUrl;
  String imagePath;
  String? text;

  final int height;
  final int width;

  double get aspectRatio => height / width;

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        Message.TEXT_KEY: text,
        IMAGE_URL_KEY: imageUrl,
        IMAGE_NAME_KEY: imagePath,
        IMAGE_WIDTH_KEY: width,
        IMAGE_HEIGHT_KEY: height,
      });
  }

  @override
  factory ImageMessage.fromDoc(DocumentSnapshot doc) {
    return ImageMessage(
      isSent: false,
      isSeen: false,
      chatId: doc.id,
      senderId: doc[Message.SENDER_ID_KEY],
      senderName: doc[Message.SENDER_NAME_KEY],
      senderImage: doc[Message.SENDER_image_KEY],
      timeSent: doc.getDateTime(Message.CREATED_AT_KEY)!,
      imageUrl: doc[IMAGE_URL_KEY],
      imagePath: doc[IMAGE_NAME_KEY],
      text: doc[Message.TEXT_KEY],
      height: doc[ImageMessage.IMAGE_HEIGHT_KEY],
      width: doc[IMAGE_WIDTH_KEY],
    )..messageId = doc.id;
  }

  ImageMessage.toSend({
    required super.chatId,
    this.text,
    required this.imagePath,
    required super.timeSent,
    required this.height,
    required this.width,
  }) : super(
          type: MessageType.image,
          isSeen: false,
          isSent: false,
          senderId: Get.find<UsersProvider>().me.value.uid,
          senderName: Get.find<UsersProvider>().me.value.name,
          senderImage: Get.find<UsersProvider>().me.value.imageUrl,
        );

  factory ImageMessage.fromFileMessage(
    FileMessage fileMessage,
    int imageHeight,
    int imageWidth,
  ) {
    return ImageMessage.toSend(
      chatId: fileMessage.chatId,
      text: null,
      imagePath: fileMessage.downloadUrl,
      timeSent: fileMessage.timeSent,
      height: imageHeight,
      width: imageWidth,
    )..imageUrl = fileMessage.fileName;
  }

  factory ImageMessage.fromNotificationPayload(Map<String, dynamic> map) {
    var x = ImageMessage(
      isSent: false,
      isSeen: false,
      chatId: map[Message.CHAT_ID_KEY],
      timeSent: DateTime.parse(map[Message.CREATED_AT_KEY]),
      senderId: map[Message.SENDER_ID_KEY],
      senderName: map[Message.SENDER_NAME_KEY],
      senderImage: map[Message.SENDER_image_KEY],
      imageUrl: map[IMAGE_URL_KEY],
      imagePath: map[IMAGE_NAME_KEY],
      text: map[Message.TEXT_KEY],
      height: int.parse(map[IMAGE_HEIGHT_KEY]),
      width: int.parse(map[IMAGE_WIDTH_KEY]),
    )..messageId = map[Message.MESSAGE_ID_KEY];

    return x;
  }
}
