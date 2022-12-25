import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/app/models/message.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

class ChattingProvider {
  ChattingProvider._();
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final CollectionReference chatsCollection = db.collection('cahts');

  static CollectionReference messagesCollection(String chatId) =>
      chatsCollection.doc(chatId).collection('messages');

  static String myUid = FirebaseAuth.instance.currentUser!.uid;

  static Stream<QuerySnapshot> getMessagesStream(String chatId) {
    return messagesCollection(chatId).orderBy('createdAt').snapshots();
  }

  static Future<void> sendTextMessage(Message textMessage) async {
    final myName = MySharedPref.getUserName;
    final myImage = MySharedPref.getUserImage;

    await messagesCollection(textMessage.chatId).add({
      'text': textMessage.text,
      'createdAt': Timestamp.now(),
      'senderId': myUid,
      'senderName': myName,
      'senderImage': myImage,
      'type': textMessage.type.name,
    });
  }
  // static Future<void> sendPhoto(Message imageMessage, String senderName, String senderImage) async {
  //   final imageFileId = imageMessage.image!.hashCode + DateTime.now().hashCode;

  //   final imageRef = FirebaseStorage.instance.ref().child('chats/${imageMessage.chatPath}/$imageFileId.jpg');

  //   await imageRef.putFile(File(imageMessage.image!)).whenComplete(() => null);
  //   final imageUrl = await imageRef.getDownloadURL();

  //   db.doc(imageMessage.chatPath).collection('messages').add({
  //     'type': 'image',
  //     'image': imageUrl,
  //     'text': imageMessage.text,
  //     'createdAt': Timestamp.now(),
  //     'senderId': myUid,
  //     'senderName': senderName,
  //     'senderImage': senderImage,
  //   });
  // }

  // static void sendVideo(Message videoMessage, String senderName, String senderImage) async {
  //   final videoFileId = videoMessage.video!.hashCode + DateTime.now().hashCode;

  //   final videoRef = FirebaseStorage.instance.ref().child('chats/${videoMessage.chatPath}/$videoFileId');

  //   await videoRef.putFile(File(videoMessage.video!)).whenComplete(() => null);
  //   final videoUrl = await videoRef.getDownloadURL();

  //   db.doc(videoMessage.chatPath).collection('messages').add({
  //     'type': 'video',
  //     'video': videoUrl,
  //     'text': videoMessage.text,
  //     'createdAt': Timestamp.now(),
  //     'senderId': myUid,
  //     'senderName': senderName,
  //     'senderImage': senderImage,
  //   });
  // }

  // static void sendAudio(Message audioMessage, String senderName, String senderImage) async {
  //   final audioFileId = audioMessage.audio!.hashCode + DateTime.now().hashCode;
  //   final audioRef =
  //       FirebaseStorage.instance.ref().child('chats/${audioMessage.chatPath}').child('$audioFileId');

  //   await audioRef.putFile(File(audioMessage.audio!)).whenComplete(() => null);
  //   final audioUrl = await audioRef.getDownloadURL();

  //   db.doc(audioMessage.chatPath).collection('messages').add({
  //     'type': 'audio',
  //     'audio': audioUrl,
  //     'text': audioMessage.text,
  //     'createdAt': Timestamp.now(),
  //     'senderId': myUid,
  //     'senderName': senderName,
  //     'senderImage': senderImage,
  //   });
  // }
}
