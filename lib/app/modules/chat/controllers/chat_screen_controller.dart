import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_viewer/video_viewer.dart';
import 'package:whatsapp_clone/app/models/chat_interface.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/models/messages/voice_message.dart';
import 'package:whatsapp_clone/app/modules/chat/screens/video_viewer_screen.dart';
import 'package:whatsapp_clone/app/modules/chat/services/chatting_provider.dart';

import '../screens/image_viewer_screen.dart';
import 'chat_text_field_controller.dart';

class ChatScreenController extends GetxController {
  late final Chat chat;

  Map<String, VideoPlayerController> videos = {};

  @override
  void onInit() {
    super.onInit();
    Get.put(ChatTextFieldController());

    chat = Get.arguments;
  }

  Stream<List<MessageInterface>> getMessagesStream() {
    return ChattingProvider.getMessagesStream(chat.id).map((event) {
      final messageDocs = event.docs;

      final List<MessageInterface> messages = [];

      for (QueryDocumentSnapshot messageDoc in messageDocs) {
        messages.add(MessageInterface.fromDoc(messageDoc));
      }

      log('messages num: ${messages.length}');
      return messages;
    });
  }

  void onAppBarPressed() {
    // Get.to(
    //   () => UserDetailsScreen(
    //     name: widget.name,
    //     image: widget.image,
    //     chatPath: widget.chatPath,
    //     isGroup: isGroupChat,
    //   ),
    // );
  }

  String getUserbyId(senderId) {
    return '';
  }

  Future<VideoPlayerController> initilizeVideoController(String videoUrl) async {
    ///check if the video controller already exists
    if (videos.containsKey(videoUrl)) {
      /// (if exists return it)
      return videos[videoUrl]!;
    }

    final videoController = VideoPlayerController.network(videoUrl);
    await videoController.initialize();

    ///if the video controller does not exists (save it in the videos map)
    videos.addIf(true, videoUrl, videoController);

    return videoController;
  }

  void onImagePressed(ImageMessage message, ImageProvider image) {
    //to remove the keyboaed (better animation)
    Get.focusScope?.unfocus();

    Get.to(() => ImageViewerScreen(
          image: image,
          imageMessage: message,
        ));

    // Get.to(
    //   ImageEditor(
    //     image: image.readAsBytesSync(), // <-- Uint8List of image
    //     appBar: Colors.blue,
    //   ),
    // );
  }

  onViedeoPressed(VideoMessage message, String video, VideoPlayerController videoViewerController) {
    //to remove the keyboaed (better animation)
    Get.focusScope?.unfocus();

    Get.to(() => VideoViewerScreen(
          videoMessage: message,
          videoPlayerController: videoViewerController,
        ));
  }

  void sendImage(File image, String? message) {
    final imageMessage = ImageMessage.toSend(
      text: message,
      chatId: chat.id,
      image: image.path,
    );

    ChattingProvider.sendImageMessage(imageMessage, image);
  }

  void sendAudio(File audioFile) {
    final audioMessage = AudioMessage.toSend(
      chatId: chat.id,
      audio: audioFile.path,
    );

    ChattingProvider.sendAudioMessage(audioMessage, audioFile);
  }

  void sendVideo(File video, String? message) {
    final videoMessage = VideoMessage.toSend(
      chatId: chat.id,
      text: message,
      video: video.path,
    );

    ChattingProvider.sendVideoMessage(videoMessage, video);
  }

  onFilePressed(FileMessage message) {
    // _launchUrl(message.file);
    log('file ${message.file} is pressed ');
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse('file:/$url');

    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }
}
