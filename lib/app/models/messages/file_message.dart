import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

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
    required this.fileSize,
  }) : super(type: MessageType.file);


  /// the url that is used to download the file 
  String downloadUrl;

  /// the path of the file in the device (if its downloaded)
  String? filePath;
  String fileName;
  String fileSize;

  @ignore
  String get fileType {
    var x = Utils.getFileExtension(fileName);
    Logger().w(x);
    return x;
  }

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
  factory FileMessage.fromDoc(DocumentSnapshot<Object?> map) {
    return FileMessage(
        isSent: false,
        isSeen: false,
        // isSent: map['isSent'],
        // isSeen: map['isSeen'],
        chatId: map.id,
        senderId: map[MessageInterface.SENDER_ID_KEY],
        senderName: map[MessageInterface.SENDER_NAME_KEY],
        senderImage: map[MessageInterface.SENDER_image_KEY],
        downloadUrl: map[FILE_URL_KEY],
        fileName: map[FILE_NAME_KEY],
        fileSize: map[FILE_SIZE_KEY] + ' Mb',
        timeSent: map.getDateTime(MessageInterface.CREATED_AT_KEY)!);
  }

  @override
  factory FileMessage.toSend(
      {required String chatId, required String file, required String fileName, required String fileSize}) {
    return FileMessage(
      isSeen: false,
      isSent: false,
      chatId: chatId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      senderName: MySharedPref.getUserName!,
      senderImage: MySharedPref.getUserImage,
      timeSent: DateTime.now(),
      downloadUrl: file,
      fileName: fileName,
      fileSize: fileSize,
    );
  }

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
      fileSize: map[FILE_SIZE_KEY],
    );
  }
}
