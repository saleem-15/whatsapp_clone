import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/models/messages/audio_message.dart';
import 'package:whatsapp_clone/app/api/messaging_api.dart';
import 'package:whatsapp_clone/app/modules/image/screens/image_viewer_screen.dart';
import 'package:whatsapp_clone/app/providers/messages_provider.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'package:whatsapp_clone/storage/files_manager.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

import 'chat_text_field_controller.dart';

class ChatScreenController extends GetxController {
  late final Chat chat;
  final messagesList = RxList<MessageInterface>();

  MessagesProvider get messagesProvider => Get.find<MessagesProvider>();

  Map<String, VideoPlayerController> videos = {};

  @override
  void onInit() {
    super.onInit();
    Get.put(ChatTextFieldController());

    chat = Get.arguments;

    messagesProvider.getMessagesStream(chat.id);

    _getMessagesStream().listen((event) {
      Logger().i('num of masseges: ${event.length}');

      messagesList.value = event;
    });
  }

  Stream<List<MessageInterface>> _getMessagesStream() {
    return MessagingApi.getMessagesStream(chat.id).map((event) {
      final messageDocs = event.docs;

      final List<MessageInterface> messages = [];

      for (QueryDocumentSnapshot messageDoc in messageDocs) {
        messages.add(MessageInterface.fromFirestoreDoc(messageDoc));
      }

      return messages;
    });
  }

  void onAppBarPressed() {
    Get.toNamed(
      Routes.CHAT_DETAILS_SCREEN,
      arguments: chat,
    );
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
    final isImageStored = await FileManager.isFileSaved(message.imagePath);
    if (!isImageStored) {
      log('image is not stored');
      return;
    }

    //to remove the keyboaed (better animation)
    Get.focusScope?.unfocus();

    final imageFile = File(message.imagePath);
    // await FileManager.getFile(message.imagePath, message.chatId);

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
    final isVideoLoaded = await FileManager.isFileSaved(videoMessage.videoPath);
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

    // Get.put
  }

  Future<void> sendImage(File imageFile, String? message) async {
    final time = DateTime.now();

    final imageDimensions = await Utils.getImageSize(imageFile);
    Logger().w(imageDimensions);

    /// file name without the file extension
    String imageName = FileManager.generateMediaFileName(
      FileType.image,
      chat.id,
      time,
    );

    final imagePath = await FileManager.saveToFile(
      imageFile,
      '$imageName${Utils.getFileExtension(imageFile.path)}',
      chat.id,
    );

    Logger().w(imagePath);

    final imageMessage = ImageMessage.toSend(
      text: message,
      chatId: chat.id,
      imagePath: imagePath,
      timeSent: time,
      height: imageDimensions.height,
      width: imageDimensions.width,
    );

    messagesProvider.sendImageMessage(chat, imageMessage, imageFile);
  }

  Future<void> sendAudio(File audioFile) async {
    final time = DateTime.now();

    /// file name without the file extension
    String audioFileName = FileManager.generateMediaFileName(
      FileType.audio,
      chat.id,
      time,
    );

    final audioFilePath = await FileManager.saveToFile(
      audioFile,
      '$audioFileName${Utils.getFileExtension(audioFile.path)}',
      chat.id,
    );

    final audioMessage = AudioMessage.toSend(
      chatId: chat.id,
      audioPath: audioFilePath,
      timeSent: time,
    );

    messagesProvider.sendAudioMessage(chat, audioMessage, audioFile);
  }

  Future<void> sendVideo(File videoFile, String? message) async {
    final time = DateTime.now();

    /// file name without the file extension
    String videoFileName = FileManager.generateMediaFileName(
      FileType.video,
      chat.id,
      time,
    );

    final videoFilePath = await FileManager.saveToFile(
      videoFile,
      '$videoFileName${Utils.getFileExtension(videoFile.path)}',
      chat.id,
    );

    /// get the video width & height
    var videoInfo = await Utils.getVideoInfo(videoFile.path);

    final videoMessage = VideoMessage.toSend(
      chatId: chat.id,
      text: message,
      videoPath: videoFilePath,
      width: videoInfo!.width!,
      height: videoInfo.height!,
    );

    messagesProvider.sendVideoMessage(chat, videoMessage, videoFile);
  }

  void onFilePressed(FileMessage message) {
    launchUrl(Uri.file(message.downloadUrl));

    log('file ${message.downloadUrl} is pressed ');
  }

  void onVideoCallButtonPressed() {}

  ///called when an image of an [ImageMessage] is downloaded
  ///
  ///it must update the database with the stored image file path
  void onImageDownloaded(ImageMessage imageMessage, File downloadedImage) {
    imageMessage.imagePath = downloadedImage.path;
    messagesProvider.updateMessage(imageMessage);
  }

  void onvideoDownloaded(VideoMessage videoMessage, File downloadedVideo) {
    videoMessage.videoPath = downloadedVideo.path;
    messagesProvider.updateMessage(videoMessage);
  }
}
