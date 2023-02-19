import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/messaging_api.dart';
import 'package:whatsapp_clone/app/models/messages/audio_message.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/app/models/messages/text_message.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/providers/users_provider.dart';
import 'package:whatsapp_clone/storage/database/daos/messages_dao.dart';

import '../models/chats/chat_interface.dart';
import '../models/messages/image_message.dart';
import '../models/user.dart';

class MessagesProvider extends GetxController {
  Rx<User> get me => Get.find<UsersProvider>().me;

  ///sends a text message\
  Future<void> sendTextMessage(Chat chat, TextMessage textMessage) async {
    final response = await MessagingApi.sendTextMessage(textMessage);
    MessagesDao.addMessage(
      chat: chat,
      sender: me.value,
      message: textMessage..messageId = response,
    );
  }

  ///sends a image message\
  Future<void> sendImageMessage(Chat chat, ImageMessage imageMessage, File imageFile) async {
    final response = await MessagingApi.sendImageMessage(imageMessage, imageFile);

    imageMessage
      ..imageUrl = response[1]
      ..messageId = response[0];

    MessagesDao.addMessage(
      chat: chat,
      sender: me.value,
      message: imageMessage,
    );
  }

  ///sends a video message\
  void sendVideoMessage(Chat chat, VideoMessage videoMessage, File videoFile) async {
    final response = await MessagingApi.sendVideoMessage(videoMessage, videoFile);

    videoMessage
      ..messageId = response[0]
      ..videoUrl = response[1];

    MessagesDao.addMessage(
      chat: chat,
      sender: me.value,
      message: videoMessage,
    );
  }

  ///sends a audio message\
  Future<void> sendAudioMessage(Chat chat, AudioMessage audioMessage, File audioFile) async {
    final response = await MessagingApi.sendAudioMessage(audioMessage, audioFile);

    audioMessage
      ..messageId = response[0]
      ..audioUrl = response[1];

    MessagesDao.addMessage(
      chat: chat,
      sender: me.value,
      message: audioMessage,
    );
  }

  ///sends a file message\
  Future<void> sendFileMessage(Chat chat, FileMessage fileMessage, File file) async {
    final respnse = await MessagingApi.sendFileMessage(fileMessage, file);

    fileMessage
      ..messageId = respnse[0]
      ..downloadUrl = respnse[1];

    MessagesDao.addMessage(
      chat: chat,
      sender: me.value,
      message: fileMessage,
    );
  }

  Stream<List<MessageInterface>> getMessagesStream(String chatId) {
    MessagesDao.getChatMessagesStream(chatId);
    return MessagingApi.getMessagesStream(chatId).map((event) {
      final messageDocs = event.docs;

      final List<MessageInterface> messages = [];

      for (QueryDocumentSnapshot messageDoc in messageDocs) {
        messages.add(MessageInterface.fromFirestoreDoc(messageDoc));
      }

      log('messages num: ${messages.length}');
      return messages;
    });
  }

  void updateMessage(MessageInterface imageMessage) {
    MessagesDao.updateDownloadUrl(
      imageMessage,
      silent: false,
    );
  }
}
