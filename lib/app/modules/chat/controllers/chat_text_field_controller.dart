// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'dart:io';
import 'package:logger/src/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone/app/models/chat_interface.dart';
import 'package:whatsapp_clone/app/models/messages/text_message.dart';
import 'package:whatsapp_clone/app/modules/chat/components/send_attachement_bottom_sheet.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/modules/image/screens/picked_photo_viewer.dart';

import '../services/chatting_provider.dart';

class ChatTextFieldController extends GetxController {
  late final Chat chat;

  late final FlutterSoundRecorder recorder;
  late final String myID;
  late final textController = TextEditingController();
  final RxString text = RxString('');

  bool isRecordingReady = false;

  @override
  void onInit() {
    super.onInit();
    chat = Get.arguments;

    textController.addListener(() {
      text(textController.text);
    });

    myID = FirebaseAuth.instance.currentUser!.uid;
    recorder = FlutterSoundRecorder(logLevel: Level.nothing);

    // initRecorder();
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

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
    isRecordingReady = true;

    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future record() async {
    if (!isRecordingReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future<File> stop() async {
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    return audioFile;
  }

  recordingTime() {
    return StreamBuilder<RecordingDisposition>(
      stream: recorder.onProgress,
      builder: (context, snapshot) {
        final duration = snapshot.hasData ? snapshot.data!.duration : Duration.zero;

        String twoDigits(int n) => n.toString().padLeft(1);
        final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
        final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
        return Text(
          '$twoDigitMinutes:$twoDigitSeconds',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  void showBottomSheet() async {
    await Get.bottomSheet(
      SendFileBottomSheet(
        sendAudio: Get.find<ChatScreenController>().sendAudio,
      ),
      settings: RouteSettings(arguments: chat),
    );
  }

  void sendMessage() {
    final msg = TextMessage.toSend(
      chatId: chat.chatId,
      text: text.trim(),
    );

    ChattingProvider.sendTextMessage(msg);

    textController.clear();
  }

  void onCameraIconPressed() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (pickedImage == null) {
      return;
    }

    final imageFile = File(pickedImage.path);

    Get.to(() => PickedPhotoViewer(
          sendImage: Get.find<ChatScreenController>().sendImage,
          image: imageFile,
        ));
  }

  void onMicIconPressed() async {
    if (recorder.isRecording) {
      File audioFile = await stop();

      showDoYouWantToSendAudioRecordingDialog(audioFile);
    } else {
      record();
    }
  }

  void showDoYouWantToSendAudioRecordingDialog(File audioFile) {
    Get.defaultDialog(
      title: 'Do you want to send the recording?',
      middleText: '',
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Get.back();
          },
        ),
        const SizedBox(
          width: 40,
        ),
        ElevatedButton(
          child: const Text('Send'),
          onPressed: () {
            Get.find<ChatScreenController>().sendAudio(audioFile);
            Get.back();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    textController.dispose();

    super.dispose();
  }
}
