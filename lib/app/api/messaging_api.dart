// ignore_for_file: dead_code

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/message_type_enum.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/app/models/messages/text_message.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/models/messages/audio_message.dart';
import 'package:whatsapp_clone/app/providers/users_provider.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';
import 'package:logger/logger.dart';
import 'api.dart';

class MessagingApi {
  MessagingApi._();

  static late final String senderName;
  static late final String? senderImage;

  static void init() {
    final user = Get.find<UsersProvider>().me;
    senderName = user.value.name;
    senderImage = user.value.imageUrl;
  }

  static CollectionReference messagesCollection(String chatId) =>
      chatsCollection.doc(chatId).collection('messages').withConverter<MessageInterface>(
            fromFirestore: (snapshot, _) => fromFirestoreConverter(snapshot),
            toFirestore: (message, _) => message.toMap(),
          );

//-------------------------------------------------------------------------------------

  static Stream<QuerySnapshot> getMessagesStream(String chatId) {
    return messagesCollection(chatId).orderBy('createdAt', descending: true).snapshots();
  }

  static MessageInterface fromFirestoreConverter(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Logger().i(snapshot.data());
    switch (msgTypeEnumfromString(snapshot['type'])) {
      case MessageType.text:
        return TextMessage.fromDoc(snapshot);

      case MessageType.image:
        return ImageMessage.fromDoc(snapshot);

      case MessageType.video:
        return VideoMessage.fromDoc(snapshot);

      case MessageType.file:
        return FileMessage.fromDoc(snapshot);

      default:
        throw 'Unknown type: ${snapshot["type"]}';
    }
  }

  /// returns the message doc id
  static Future<String> sendTextMessage(TextMessage textMessage) async {
    final msgDoc = await messagesCollection(textMessage.chatId).add(textMessage);

    return msgDoc.id;
  }

  /// 0 index =>the message doc id\
  /// 1 index =>the file download url
  static Future<List> sendImageMessage(ImageMessage imageMessage, File imageFile) async {
    final imageUrl = await uploadFileToFirestorage(
      chatId: imageMessage.chatId,
      file: imageFile,
      fileName: imageMessage.imagePath,
    );

    imageMessage.imageUrl = imageUrl;

    /// add the message to firestore
    final response = await messagesCollection(imageMessage.chatId).add(imageMessage);
    return [response.id, imageUrl];
  }

  /// 0 index =>the message doc id\
  /// 1 index =>the file download url
  static Future<List> sendAudioMessage(AudioMessage audioMessage, File audioFile) async {
    final audioUrl = await uploadFileToFirestorage(
      chatId: audioMessage.chatId,
      file: audioFile,
      fileName: 'v',
    );

    /// add the message to firestore
    final response = await messagesCollection(audioMessage.chatId).add(audioMessage..audioUrl = audioUrl);
    return [response.id, audioUrl];
  }

  /// 0 index =>the message doc id\
  /// 1 index =>the file download url
  static Future<List> sendVideoMessage(VideoMessage videoMessage, File videoFile) async {
    final videoUrl = await uploadFileToFirestorage(
      chatId: videoMessage.chatId,
      file: videoFile,
      fileName: videoMessage.videoPath,
    );

    videoMessage.videoUrl = videoUrl;

    /// add the message to firestore
    final response = await messagesCollection(videoMessage.chatId).add(videoMessage);

    return [response.id, videoUrl];
  }

  /// 0 index =>the message doc id\
  /// 1 index =>the file download url
  static Future<List> sendFileMessage(FileMessage fileMessage, File file) async {
    final fileUrl = await uploadFileToFirestorage(
      chatId: fileMessage.chatId,
      file: file,
      fileName: fileMessage.fileName,
    );

    fileMessage.downloadUrl = fileUrl;

    final response = await messagesCollection(fileMessage.chatId).add(fileMessage);

    return [response.id, fileUrl];
  }

  ///returnes the file Url in the firestorage\
  ///-`chatId` is used to determine where the file will be stored
  /// (every chat has its own storage path)\
  ///-the `fileName` has to be unique, if it was not unique then the
  /// new file will overWrite the old one.
  static Future<String> uploadFileToFirestorage({
    required String chatId,
    required File file,
    required String fileName,
  }) async {
    final fileRef = rootStorage.child('chats/$chatId/$fileName');

    /// upload image to fireStorage
    await fileRef.putFile(File(file.path)).whenComplete(() => null);

    /// fileUrl in fireStorage
    final fileUrl = await fileRef.getDownloadURL();

    return fileUrl;
  }

  ///Becuase firebase storage does not offer unique id generating
  ///
  ///I use the sender ID +(currnet time in Microsecends) + file extension
  ///the return looks like this (name.jpg)
  static String genereteFileId(String senderId, String filePath) {
    /// file extension (.png/.jpg/.mp4/.pdf/.....)
    final fileExtension = Utils.getFileExtension(filePath);

    final fileId = '$senderId${DateTime.now().microsecondsSinceEpoch}$fileExtension';
    return fileId;
  }
}
