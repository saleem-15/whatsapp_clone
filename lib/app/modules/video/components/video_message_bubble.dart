// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/my_video.dart';
import 'package:whatsapp_clone/utils/helpers/message_bubble_settings.dart';

class VideoMessageBubble extends StatefulWidget {
  const VideoMessageBubble({
    Key? key,
    required this.video,
    required this.message,
  }) : super(key: key);

  final String video;
  final VideoMessage message;

  @override
  State<VideoMessageBubble> createState() => _VideoMessageBubbleState();
}

class _VideoMessageBubbleState extends State<VideoMessageBubble> {
  // late final VideoViewerController videoController;
  late final ChatScreenController controller;

  @override
  void initState() {
    controller = Get.find<ChatScreenController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.message.isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          onTap: () => controller.onViedeoPressed(widget.message),
          child: Container(
            width: 300,
            height: 300,
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(5),
            margin: MessageBubbleSettings.messageMargin(isMyMessage: widget.message.isMyMessage),
            decoration: MessageBubbleSettings.messageDecoration(isMyMessage: widget.message.isMyMessage),
            child: LayoutBuilder(
              builder: (_, constranis) {
                log('constrants:');
                log('MAX Width: ${constranis.maxWidth}\t min Width: ${constranis.minWidth}');
                // log('min Width: ${constranis.minWidth}');
                log('MAX Height: ${constranis.maxHeight}\t min Height: ${constranis.minHeight}');
                // log('min Height: ${constranis.minHeight}');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///video
                    Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.center,
                      children: [
                        LayoutBuilder(
                          builder: (_, constranis) {
                            log('Stack childe constrants:');
                            log('MAX Width: ${constranis.maxWidth}\t min Width: ${constranis.minWidth}');
                            // log('min Width: ${constranis.minWidth}');
                            log('MAX Height: ${constranis.maxHeight}\t min Height: ${constranis.minHeight}');
                            // log('min Height: ${constranis.minHeight}');
                            return const SizedBox.shrink();
                          },
                        ),
                        ClipRRect(
                          borderRadius: MessageBubbleSettings.borderRadius,
                          child: Hero(
                            tag: widget.message.videoUrl,
                            child: NetworkOrLocalVideo(
                              chatId: widget.message.chatId,
                              fileName: widget.message.videoName,
                              videoUrl: widget.message.videoUrl,
                            ),
                          ),
                        ),

                        /// play icon (just icon not a button)
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(10.sp),
                            decoration: const BoxDecoration(
                              color: Colors.black45,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: 30.sp,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),

                    /// Text (shown if there is any)
                    if (widget.message.text != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Text(widget.message.text!),
                      )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // chewieController.dispose();
    // videoPlayerController.dispose();
    super.dispose();
  }
}
