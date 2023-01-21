import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/models/messages/audio_message.dart';
import 'package:whatsapp_clone/app/api/messaging_provider.dart';
import 'package:whatsapp_clone/app/modules/image/screens/image_viewer_screen.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'package:whatsapp_clone/storage/files_manager.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

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
    return MessagingProvider.getMessagesStream(chat.id).map((event) {
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
    Get.toNamed(
      Routes.CHAT_DETAILS_SCREEN,
      arguments: chat,
    );
    // Get.to(
    //   () => UserDetailsScreen(
    //     name: widget.name,
    //     image: widget.image,
    //     chatPath: widget.chatPath,
    //     isGroup: isGroupChat,
    //   ),
    // );
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

  Future<void> onImagePressed(ImageMessage message) async {
    final isImageStored = await FileManager.isFileSaved(message.imageName, message.chatId);
    if (!isImageStored) {
      return;
    }

    //to remove the keyboaed (better animation)
    Get.focusScope?.unfocus();

    final imageFile = await FileManager.getFile(message.imageName, message.chatId);

    Get.to(() => ImageViewerScreen(
          imageMessage: message,
          imageFile: imageFile,
        ));

    // Get.to(
    //   ImageEditor(
    //     image: image.readAsBytesSync(), // <-- Uint8List of image
    //     appBar: Colors.blue,
    //   ),
    // );
  }

  onViedeoPressed(VideoMessage videoMessage) async {
    final isVideoLoaded = await FileManager.isFileSaved(videoMessage.videoName, videoMessage.chatId);
    if (!isVideoLoaded) {
      return;
    }

    //to remove the keyboaed (better animation)
    Get.focusScope?.unfocus();

    /// this video controller was injected in the video message bubble
    final videoPlayerController = Get.find<VideoPlayerController>(tag: videoMessage.videoUrl);

    Get.toNamed(
      Routes.VIDEO_VIEWER_SCREEN,
      arguments: {
        'videoController': videoPlayerController,
        'videoMessage': videoMessage,
      },
    );
  }

  void sendImage(File image, String? message) {
    final imageMessage = ImageMessage.toSend(
      text: message,
      chatId: chat.id,
      imageUrl: image.path,
      imageName: '',
    );

    MessagingProvider.sendImageMessage(imageMessage, image);
  }

  void sendAudio(File audioFile) {
    final audioMessage = AudioMessage.toSend(
      chatId: chat.id,
      audio: audioFile.path,
    );

    MessagingProvider.sendAudioMessage(audioMessage, audioFile);
  }

  Future<void> sendVideo(File video, String? message) async {
    var videoInfo = await Utils.getVideoInfo(video.path);

    final videoMessage = VideoMessage.toSend(
      chatId: chat.id,
      text: message,
      videoUrl: video.path,
      videoName: '',
      height: videoInfo!.height!,
      width: videoInfo.width!,
    );

    MessagingProvider.sendVideoMessage(videoMessage, video);
  }

  onFilePressed(FileMessage message) {
    // _launchUrl(message.file);
    log('file ${message.file} is pressed ');
  }
}
