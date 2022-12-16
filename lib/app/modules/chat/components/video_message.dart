import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';
import 'package:whatsapp_clone/app/modules/chat/screens/video_viewer_screen.dart';
import 'package:whatsapp_clone/helpers/message_bubble_settings.dart';


class VideoMessageBubble extends StatelessWidget {
  VideoMessageBubble({
    Key? key,
    required this.video,
    this.text,
    required this.isMyMessage,
  }) : super(key: key);

  final File video;
  final String? text;
  final bool isMyMessage;
  final controller = VideoViewerController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();

            Get.to(() => VideoViewerScreen(
                  video: video,
                ));
          },
          child: Container(
            margin: EdgeInsets.only(
              right: isMyMessage ? 8 : 0,
              left: isMyMessage ? 0 : 8,
              bottom: 5,
              top: 3,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: isMyMessage ? MessageBubbleSettings.myMessageColor : MessageBubbleSettings.othersMessageColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Hero(
                    tag: video,
                    child: VideoViewer(
                      controller: controller,
                      source: {
                        "SubRip Text": VideoSource(
                          video: VideoPlayerController.file(video),
                        )
                      },
                    ),
                  ),
                ),
                if (text != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(text!),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
