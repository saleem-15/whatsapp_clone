import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/api/messaging_api.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/models/messages/audio_message.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/modules/image/screens/picked_photo_viewer.dart';
import 'package:whatsapp_clone/app/providers/messages_provider.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

import '../../video/screens/picked_video_viewer.dart';

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

    Get.to(() => PickedVideoScreen(
          videoFile: videoFile,
          sendVideo: chatController.sendVideo,
        ));
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
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);

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
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result == null) {
      return;
    }

    await sendFileMessage(result);
  }

  Future<void> sendFileMessage(FilePickerResult result) async {
    List<File> files = result.paths.map((path) => File(path!)).toList();
    final file = files[0];

    String fileName = MessagingApi.genereteFileId(myUid, file.path);

    final fileMessage = FileMessage.toSend(
      chatId: chat.id,
      file: file.path,
      fileName: fileName,
      fileSize: Utils.getFileSize(file).toStringAsFixed(1),
    );

    /// make sure that the file is not a media file
    if (await _checkIsMediaFile(file, fileMessage)) {
      return;
    }

    messagesProvider.sendFileMessage(chat, fileMessage, file);
  }

  /// checks if the file is a media file (image,video,audio)\
  /// if its a media file then it sends the message according to
  /// its appropriate message type
  Future<bool> _checkIsMediaFile(File file, FileMessage fileMessage) async {
    /// if its a video file => send a video message
    /// image => image message
    /// audio => audio message
    if (file.path.isVideoFileName) {
      final videoInfo = await Utils.getVideoInfo(fileMessage.downloadUrl);

      messagesProvider.sendVideoMessage(
        chat,
        VideoMessage.fromFileMessage(fileMessage, videoInfo!.width!, videoInfo.height!),
        file,
      );
      return true;
    } else if (file.path.isImageFileName) {
      messagesProvider.sendImageMessage(
        chat,
        ImageMessage.fromFileMessage(fileMessage),
        file,
      );
      return true;
    } else if (file.path.isAudioFileName) {
      messagesProvider.sendAudioMessage(
        chat,
        AudioMessage.fromFileMessage(fileMessage),
        file,
      );
      return true;
    }
    return false;
  }
}
