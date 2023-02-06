import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import '../message_type_enum.dart';

class FileMessage extends MessageInterface {
  /// json fields names (to ensure that i always (send) and (recieve) the right field name)
  static const FILE_NAME_KEY = 'fileName';
  static const FILE_URL_KEY = 'fileUrl';
  static const FILE_SIZE_KEY = 'fileSize';

  FileMessage({
    required super.isSent,
    required super.isSeen,
    required super.chatId,
    required super.senderName,
    required super.timeSent,
    super.senderImage,
    required super.senderId,
    required this.file,
    required this.fileName,
    required this.fileSize,
  }) : super(type: MessageType.file);

  String file;
  String fileName;
  String fileSize;

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'file': file,
        FILE_NAME_KEY: fileName,
        FILE_SIZE_KEY: fileSize,
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
        senderId: map['senderId'],
        senderName: map['senderName'],
        senderImage: map['senderImage'],
        file: map['file'],
        fileName: map[FILE_NAME_KEY],
        fileSize: map[FILE_SIZE_KEY] + ' Mb',
        timeSent: map.getDateTime('createdAt')!);
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
      file: file,
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
      file: map[FILE_URL_KEY],
      fileName: map[FILE_NAME_KEY],
      fileSize: map[FILE_SIZE_KEY],
    );
  }
}
