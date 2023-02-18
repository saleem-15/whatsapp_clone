import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/models/messages/audio_message.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/modules/image/screens/picked_photo_viewer.dart';
import 'package:whatsapp_clone/app/providers/messages_provider.dart';
import 'package:whatsapp_clone/storage/files_manager.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

import '../../../../config/routes/app_pages.dart';

class AttachFileController extends GetxController {
  late final Chat chat;

  ChatScreenController get chatController => Get.find<ChatScreenController>();
  MessagesProvider get messagesProvider => Get.find<MessagesProvider>();

  @override
  void onInit() {
    chat = Get.arguments;
    super.onInit();
  }

  void onVideoIconPressed() async {
    ///close the bottom sheet
    Get.back();

    final XFile? pickedVideo = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    ///if the user did not choose anything
    if (pickedVideo == null) {
      return;
    }

    log('video path ${pickedVideo.path}');

    final videoFile = File(pickedVideo.path);
    VideoData? videoInfo = await Utils.getVideoInfo(videoFile.path);

    Get.toNamed(
      Routes.PICKED_VIDEO_SCREEN,
      arguments: {
        'videoFile': videoFile,
        'sendVideoFunction': chatController.sendVideo,
        'aspectRatio': (videoInfo!.width! / videoInfo.height!),
      },
    );
    // videoFile = Get.arguments['videoFile'];
    // sendVideo = Get.arguments['sendVideoFunction'];
    // videoPlayerController = Get.arguments['videoPlayerController'];

    // Get.to(() => PickedVideoScreen(
    //       videoFile: videoFile,
    //       sendVideo: chatController.sendVideo,
    //     ));
  }

  void onImageIconPressed() async {
    Get.back();

    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) {
      return;
    }

    final imageFile = File(pickedImage.path);

    Get.to(() => PickedPhotoViewer(
          sendImage: chatController.sendImage,
          image: imageFile,
        ));
  }

  void onAudioIconPressed() async {
    final result = await file_picker.FilePicker.platform.pickFiles(type: file_picker.FileType.audio);

    if (result == null) {
      return;
    }

    File audioFile = File(result.paths[0]!);

    Get.defaultDialog(
      title: 'Do you want to send the audio?',
      titlePadding: const EdgeInsets.only(top: 10, right: 15, left: 15),
      middleText: '',
      confirm: ElevatedButton(
        child: const Text('Send'),
        onPressed: () {
          Get.find<ChatScreenController>().sendAudio(audioFile);
          Get.back();
          Get.back();
        },
      ),
      cancel: TextButton(
        child: const Text('Cancel'),
        onPressed: () {
          Get.back();
          Get.back();
        },
      ),
    );
  }

  void onFileIconPressed() async {
    final result = await file_picker.FilePicker.platform.pickFiles(
      allowMultiple: false,
    );

    if (result == null) {
      return;
    }

    await sendFileMessage(result);
  }

  Future<void> sendFileMessage(file_picker.FilePickerResult result) async {
    List<File> files = result.paths.map((path) => File(path!)).toList();
    final file = files[0];

    final fileType = checkFileType(file);

    if (fileType is FileType) {
      await _sendMediaMessage(
        file,
        fileType,
      );
    }

    final time = DateTime.now();

    String fileName = FileManager.generateFileMessageFileName(
      time,
      originalFileName: Utils.getFilName(file.path),
    );

    final filePath = await FileManager.saveToFile(file, fileName, chat.id);

    final fileMessage = FileMessage.toSend(
      chatId: chat.id,
      filePath: filePath,
      fileName: fileName,
      fileSize: Utils.getFileSize(file),
      timeSent: time,
    );

    messagesProvider.sendFileMessage(chat, fileMessage, file);
  }

  /// checks if the file is a media file (image,video,audio)\
  /// if its a video => returns `FileType.video`\
  /// audio => `FileType.audio`\
  /// image => `FileType.image`\
  /// `if its anything else returns false`
  dynamic checkFileType(File file) {
    if (file.path.isVideoFileName) {
      return FileType.video;
    }

    if (file.path.isImageFileName) {
      return FileType.image;
    }
    if (file.path.isAudioFileName) {
      return FileType.audio;
    }

    return false;
  }

  /// checks if the file is a media file (image,video,audio)\
  /// if its a media file then it sends the message according to
  /// its appropriate message type
  Future<void> _sendMediaMessage(File file, FileType fileType) async {
    final time = DateTime.now();

    ///generate a unique file name (does not include the file extension)
    final fileName = FileManager.generateMediaFileName(
      fileType,
      chat.id,
      time,
    );

    debugger();

    final filePath = await FileManager.saveToFile(
      file,
      '$fileName${Utils.getFileExtension(file.path)}',
      chat.id,
    );

    debugger();

    switch (fileType) {
      case FileType.audio:
        messagesProvider.sendAudioMessage(
          chat,
          AudioMessage.toSend(
            chatId: chat.id,
            timeSent: time,
            audioPath: filePath,
          ),
          file,
        );
        break;
      case FileType.image:
        final imageDimensions = await Utils.getImageSize(file);

        messagesProvider.sendImageMessage(
          chat,
          ImageMessage.toSend(
            chatId: chat.id,
            text: null,
            timeSent: time,
            imagePath: filePath,
            height: imageDimensions.height,
            width: imageDimensions.width,
          ),
          file,
        );
        break;
      case FileType.video:
        final videoInfo = await Utils.getVideoInfo(file.path);

        messagesProvider.sendVideoMessage(
          chat,
          VideoMessage.toSend(
            chatId: chat.id,
            width: videoInfo!.width!,
            height: videoInfo.height!,
            videoPath: filePath,
          ),
          file,
        );
        break;
      default:
    }
    // if (file.path.isVideoFileName) {
    //   final videoInfo = await Utils.getVideoInfo(fileMessage.downloadUrl);

    //   messagesProvider.sendVideoMessage(
    //     chat,
    //     VideoMessage.fromFileMessage(fileMessage, videoInfo!.width!, videoInfo.height!),
    //     file,
    //   );
    //   return true;
    // }
    // else if (file.path.isImageFileName) {
    //   messagesProvider.sendImageMessage(
    //     chat,
    //     ImageMessage.fromFileMessage(fileMessage),
    //     file,
    //   );
    //   return true;
    // }
    // else if (file.path.isAudioFileName) {
    //   messagesProvider.sendAudioMessage(
    //     chat,
    //     AudioMessage.fromFileMessage(fileMessage),
    //     file,
    //   );
    //   return true;
    // }
    // return false;
  }
}
