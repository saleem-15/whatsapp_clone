import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatsapp_clone/app/models/message_type_enum.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/app/models/messages/text_message.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/models/messages/voice_message.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

class ChattingProvider {
  ChattingProvider._();
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final myId = FirebaseAuth.instance.currentUser!.uid;
  static final senderName = MySharedPref.getUserName!;
  static final senderImage = MySharedPref.getUserImage;

  static final CollectionReference chatsCollection = db.collection('cahts');

  static CollectionReference messagesCollection(String chatId) =>
      chatsCollection.doc(chatId).collection('messages').withConverter<MessageInterface>(
            fromFirestore: (snapshot, _) => fromFirestoreConverter(snapshot),
            toFirestore: (message, _) => message.toMap(),
          );

//-------------------------------------------------------------------------------------

  static Stream<QuerySnapshot<MessageInterface>> getMessagesStream(String chatId) {
    return messagesCollection(chatId)
        .orderBy('createdAt', descending: true)
        .withConverter<MessageInterface>(
          fromFirestore: (snapshot, _) => fromFirestoreConverter(snapshot),
          toFirestore: (message, _) => message.toMap(),
        )
        .snapshots();
  }

  static MessageInterface fromFirestoreConverter(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    throw '-----------Fuck You-----------';
    switch (msgTypeEnumfromString(snapshot['type'])) {
      case MessageType.text:
        return TextMessage.fromDoc(snapshot);

      case MessageType.photo:
        return ImageMessage.fromDoc(snapshot);

      case MessageType.video:
        return VideoMessage.fromDoc(snapshot);

      case MessageType.file:
        return FileMessage.fromDoc(snapshot);

      default:
        throw 'Unknown type: ${snapshot["type"]}';
    }
  }

  static Future<void> sendTextMessage(TextMessage textMessage) async {
    await messagesCollection(textMessage.chatId).add(textMessage);
  }

  static Future<void> sendImageMessage(ImageMessage imageMessage, File imageFile) async {
    String fileName = genereteFileId(myId, imageFile.path);

    imageMessage.imageName = fileName;

    final imageUrl = await uploadFileToFirestorage(
      chatId: imageMessage.chatId,
      file: imageFile,
      fileId: fileName,
    );

    /// add the message to firestore
    await messagesCollection(imageMessage.chatId).add(imageMessage..imageUrl = imageUrl);
  }

  static Future<void> sendAudioMessage(AudioMessage audioMessage, File audioFile) async {
    String fileId = genereteFileId(myId, audioFile.path);

    final audioUrl = await uploadFileToFirestorage(
      chatId: audioMessage.chatId,
      file: audioFile,
      fileId: fileId,
    );

    /// add the message to firestore
    await messagesCollection(audioMessage.chatId).add(audioMessage..audio = audioUrl);
  }

  static Future<void> sendVideoMessage(VideoMessage videoMessage, File videoFile) async {
    String fileId = genereteFileId(myId, videoFile.path);

    final videoUrl = await uploadFileToFirestorage(
      chatId: videoMessage.chatId,
      file: videoFile,
      fileId: fileId,
    );
    videoMessage
      ..videoUrl = videoUrl
      ..videoName = Utils.getFilName(videoFile.path);

    /// add the message to firestore
    await messagesCollection(videoMessage.chatId).add(videoMessage);
  }

  static Future<void> sendFileMessage(String chatId, File file) async {
    String fileId = genereteFileId(myId, file.path);
    final fileName = Utils.getFilName(file.path);

    final fileUrl = await uploadFileToFirestorage(
      chatId: chatId,
      file: file,
      fileId: fileId,
    );

    final fileMessage = FileMessage.toSend(
      chatId: chatId,
      file: file.path,
      fileName: fileName,
      fileSize: Utils.getFileSize(file).toStringAsFixed(1),
    );

    /// add the message to firestore
    // chatsCollection.doc(chatId).collection('messages').add({
    //   'createdAt': Timestamp.now(),
    //   'senderId': myId,
    //   'senderName': senderName,
    //   'senderImage': senderImage,
    //   'type': MessageType.file.name,
    //   'file': fileUrl,
    //   'fileName': fileName,
    // });
    await messagesCollection(fileMessage.chatId).add(fileMessage..file = fileUrl);
  }

  ///returnes the file Url in the firestorage
  ///It needs senderId to ensure that the file name is unique
  ///to prevent any kind of proplems
  static Future<String> uploadFileToFirestorage({
    required String chatId,
    required File file,
    required String fileId,
  }) async {
    final fileRef = FirebaseStorage.instance.ref().child('chats/$chatId/$fileId');

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
