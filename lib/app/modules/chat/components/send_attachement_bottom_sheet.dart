// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/attach_file_controller.dart';

class SendFileBottomSheet extends StatelessWidget {
  SendFileBottomSheet({
    super.key,
    required this.sendAudio,
  }) : controller = Get.put(AttachFileController());

  final AttachFileController controller;
  final void Function(File audioFile) sendAudio;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      height: 100,
      padding: const EdgeInsets.only(left: 6, right: 6, top: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ///image
          GestureDetector(
            onTap: controller.onImageIconPressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                  child: FaIcon(
                    FontAwesomeIcons.solidImage,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Text(
                  'Image',
                  style: TextStyle(color: Colors.grey[600]),
                )
              ],
            ),
          ),
          //video
          GestureDetector(
            onTap: controller.onVideoIconPressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green,
                  child: FaIcon(
                    FontAwesomeIcons.video,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Video',
                  style: TextStyle(color: Colors.grey[600]),
                )
              ],
            ),
          ),

          ///Audio
          GestureDetector(
            onTap: controller.onAudioIconPressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                Text(
                  'Audio',
                  style: TextStyle(color: Colors.grey[600]),
                )
              ],
            ),
          ),

          ///File
          GestureDetector(
            onTap: controller.onFileIconPressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.cyan[700],
                  child: const FaIcon(
                    FontAwesomeIcons.solidFile,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'File',
                  style: TextStyle(color: Colors.grey[600]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
