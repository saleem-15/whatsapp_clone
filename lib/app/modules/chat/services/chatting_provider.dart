import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatsapp_clone/app/models/message.dart';

class ChattingProvider {
  ChattingProvider._();
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final CollectionReference chatsCollection = db.collection('cahts');

  static CollectionReference messagesCollection(String chatId) =>
      chatsCollection.doc(chatId).collection('messages').withConverter<Message>(
            fromFirestore: (snapshot, _) => Message.fromDoc(snapshot),
            toFirestore: (message, _) => message.toMap(),
          );

//-------------------------------------------------------------------------------------

  static Stream<QuerySnapshot<Message>> getMessagesStream(String chatId) {
    return messagesCollection(chatId)
        .orderBy('createdAt', descending: true)
        .withConverter<Message>(
          fromFirestore: (snapshot, _) => Message.fromDoc(snapshot),
          toFirestore: (message, _) => message.toMap(),
        )
        .snapshots();
  }

  static Future<void> sendTextMessage(Message textMessage) async {
    await messagesCollection(textMessage.chatId).add(textMessage);
  }

  static Future<void> sendImageMessage(Message imageMessage, File imageFile) async {
    final imageUrl = await uploadFileToFirestorage(imageMessage.chatId, imageFile);

    /// add the message to firestore
    await messagesCollection(imageMessage.chatId).add(imageMessage..image = imageUrl);
  }

  static Future<void> sendAudioMessage(Message audioMessage, File audioFile) async {
    final audioUrl = await uploadFileToFirestorage(audioMessage.chatId, audioFile);

    /// add the message to firestore
    await messagesCollection(audioMessage.chatId).add(audioMessage..audio = audioUrl);
  }

  static Future<void> sendVideoMessage(Message videoMessage, File videoFile) async {
    final videoUrl = await uploadFileToFirestorage(videoMessage.chatId, videoFile);

    /// add the message to firestore
    await messagesCollection(videoMessage.chatId).add(videoMessage..video = videoUrl);
  }

  ///returnes the file Url in the firestorage
  static Future<String> uploadFileToFirestorage(String chatId, File file) async {
    final fileId = file.hashCode + DateTime.now().hashCode;

    final imageRef = FirebaseStorage.instance.ref().child('chats/$chatId/$fileId');

    /// upload image to fireStorage
    await imageRef.putFile(File(file.path)).whenComplete(() => null);

    ///  imageUrl in fireStorage
    final fileUrl = await imageRef.getDownloadURL();

    return fileUrl;
  }
}
