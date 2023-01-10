import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import '../message_type_enum.dart';

class FileMessage extends MessageInterface {
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
        'fileName': fileName,
        'fileSize': fileSize,
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
      fileName: map['fileName'],
      fileSize: map['fileSize'] + ' Mb',
      timeSent: (map['createdAt'] as Timestamp).toDate(),
    );
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
}
