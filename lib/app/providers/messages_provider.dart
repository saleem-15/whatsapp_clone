import 'dart:io';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/messaging_api.dart';
import 'package:whatsapp_clone/app/models/messages/audio_message.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/text_message.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/providers/users_provider.dart';
import 'package:whatsapp_clone/storage/database/daos/messages_dao.dart';

import '../models/chats/chat_interface.dart';
import '../models/messages/image_message.dart';
import '../models/user.dart';

import 'package:logger/logger.dart';

class MessagesProvider extends GetxController {
  User get me => Get.find<UsersProvider>().me!;

  ///sends a text message\
  Future<void> sendTextMessage(Chat chat, TextMessage textMessage) async {
    Logger().d(textMessage.toString());

    MessagingApi.sendTextMessage(textMessage);
    MessagesDao.addMessage(
      chat: chat,
      sender: me,
      message: textMessage,
    );
  }

  ///sends a image message\
  void sendImageMessage(Chat chat, ImageMessage imageMessage, File imageFile) {
    MessagingApi.sendImageMessage(imageMessage, imageFile);
    MessagesDao.addMessage(
      chat: chat,
      sender: me,
      message: imageMessage,
    );
  }

  ///sends a video message\
  void sendVideoMessage(Chat chat, VideoMessage videoMessage, File videoFile) async {
    MessagingApi.sendVideoMessage(videoMessage, videoFile);
    MessagesDao.addMessage(
      chat: chat,
      sender: me,
      message: videoMessage,
    );
  }

  ///sends a audio message\
  void sendAudioMessage(Chat chat, AudioMessage audioMessage, File audioFile) {
    MessagingApi.sendAudioMessage(audioMessage, audioFile);
    MessagesDao.addMessage(
      chat: chat,
      sender: me,
      message: audioMessage,
    );
  }

  ///sends a file message\
  void sendFileMessage(Chat chat, FileMessage fileMessage, File file) {
    MessagingApi.sendFileMessage(fileMessage, file);

    MessagesDao.addMessage(
      chat: chat,
      sender: me,
      message: fileMessage,
    );
  }
}
