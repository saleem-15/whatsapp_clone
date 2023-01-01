import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/app/models/chat_interface.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/modules/image/screens/picked_photo_viewer.dart';
import 'package:whatsapp_clone/app/modules/chat/services/chatting_provider.dart';

import '../../video/screens/picked_video_viewer.dart';

class AttachFileController extends GetxController {
  late final Chat chat;

  ChatScreenController get chatController => Get.find<ChatScreenController>();

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

    List<File> files = result.paths.map((path) => File(path!)).toList();

    log('file path: ${files.first.path}');
    log('file name: ${files.first.path.split("/").last}');
    // return;

    // final fileMessage = FileMessage.toSend(
    //   chatId: chat.id,
    //   file: files.first.path,

    // );

    ChattingProvider.sendFileMessage(chat.id, files[0]);
  }
}
