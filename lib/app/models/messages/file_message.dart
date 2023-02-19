import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

import '../../providers/users_provider.dart';
import '../message_type_enum.dart';

class FileMessage extends MessageInterface {
  /// json fields names (to ensure that i always (send) and (recieve) the right field name)
  static const FILE_NAME_KEY = 'fileName';
  static const FILE_URL_KEY = 'fileUrl';
  static const FILE_SIZE_KEY = 'fileSize';
  static const FILE_Path_KEY = 'filePath';

  FileMessage({
    required super.isSent,
    required super.isSeen,
    required super.chatId,
    required super.senderId,
    super.senderImage,
    required super.senderName,
    required super.timeSent,
    this.filePath,
    required this.downloadUrl,
    required this.fileName,
    required int fileSizeInBytes,
  })  : fileSize = fileSizeInBytes,
        super(type: MessageType.file);

  /// the url that is used to download the file
  late String downloadUrl;

  /// the path of the file in the device (if its downloaded)
  String? filePath;
  String fileName;

  /// file size in Bytes
  int fileSize;

  /// returns a formatted string that represents the file size
  /// in the appropriate unit of measure\
  /// Example:  '100 B' /  '15.3 kB' / '15.2 MB' / '1.22 GB'
  String get formattedSize {
    if (fileSize < 1024) {
      return "$fileSize B";
    } else if (fileSize < 1048576) {
      return "${(fileSize / 1024).toStringAsFixed(1)} KB";
    } else if (fileSize < 1073741824) {
      return "${(fileSize / 1048576).toStringAsFixed(1)} MB";
    }
    return "${(fileSize / 1073741824).toStringAsFixed(2)} GB";
  }

  RxDouble downloadProgress = 0.0.obs;

  @ignore
  String get fileType => Utils.getFileExtension(fileName, false);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        FILE_URL_KEY: downloadUrl,
        FILE_NAME_KEY: fileName,
        FILE_SIZE_KEY: fileSize,
        FILE_Path_KEY: filePath,
      });
  }

  @override
  factory FileMessage.fromDoc(DocumentSnapshot doc) {
    return FileMessage(
      isSent: false,
      isSeen: false,
      chatId: doc.id,
      senderId: doc[MessageInterface.SENDER_ID_KEY],
      senderName: doc[MessageInterface.SENDER_NAME_KEY],
      senderImage: doc[MessageInterface.SENDER_image_KEY],
      downloadUrl: doc[FILE_URL_KEY],
      fileName: doc[FILE_NAME_KEY],
      fileSizeInBytes: doc[FILE_SIZE_KEY],
      timeSent: doc.getDateTime(MessageInterface.CREATED_AT_KEY)!,
    )..messageId = doc.id;
  }

  FileMessage.toSend({
    required super.chatId,
    required super.timeSent,
    required this.filePath,
    required this.fileName,
    required this.fileSize,
  }) : super(
          type: MessageType.file,
          isSeen: false,
          isSent: false,
          senderId: Get.find<UsersProvider>().me.value.uid,
          senderName: Get.find<UsersProvider>().me.value.name,
          senderImage: Get.find<UsersProvider>().me.value.imageUrl,
        );

  factory FileMessage.fromNotificationPayload(Map<String, dynamic> map) {
    return FileMessage(
      isSent: false,
      isSeen: false,
      chatId: map['chatId'],
      timeSent: map[MessageInterface.CREATED_AT_KEY],
      senderId: map[MessageInterface.SENDER_ID_KEY],
      senderName: map[MessageInterface.SENDER_NAME_KEY],
      senderImage: map[MessageInterface.SENDER_image_KEY],
      downloadUrl: map[FILE_URL_KEY],
      fileName: map[FILE_NAME_KEY],
      fileSizeInBytes: map[FILE_SIZE_KEY],
    );
  }
}
