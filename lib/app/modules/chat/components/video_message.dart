// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

import 'package:whatsapp_clone/app/models/message.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/utils/helpers/message_bubble_settings.dart';

class VideoMessageBubble extends StatefulWidget {
  const VideoMessageBubble({
    Key? key,
    required this.video,
    required this.message,
  }) : super(key: key);

  final String video;
  final Message message;

  @override
  State<VideoMessageBubble> createState() => _VideoMessageBubbleState();
}

class _VideoMessageBubbleState extends State<VideoMessageBubble> {
  // late final VideoViewerController videoController;
  late final ChatScreenController controller;

  late final VideoPlayerController videoPlayerController;

  late ChewieController chewieController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(
      widget.video,
    );
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
          onTap: () => controller.onViedeoPressed(
            widget.message,
            widget.video,
            videoPlayerController,
          ),
          child: Container(
            margin: MessageBubbleSettings.messageMargin(isMyMessage: widget.message.isMyMessage),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: widget.message.isMyMessage
                  ? MessageBubbleSettings.myMessageColor
                  : MessageBubbleSettings.othersMessageColor,
              borderRadius: MessageBubbleSettings.borderRadius,
            ),
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                ///video
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 400.sp,
                    maxWidth: 300.w,
                  ),
                  child: AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: Hero(
                      tag: widget.video,
                      child: FutureBuilder(
                        future: controller.initilizeVideoController(widget.video),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          chewieController = ChewieController(
                            videoPlayerController: videoPlayerController,
                            allowMuting: false,
                            allowedScreenSleep: false,
                            allowPlaybackSpeedChanging: false,
                            allowFullScreen: false,
                            showControls: false,
                            customControls: const CupertinoControls(
                              backgroundColor: Colors.black54,
                              iconColor: Colors.white70,
                            ),
                          );

                          return Stack(
                            children: [
                              AbsorbPointer(
                                child: ClipRRect(
                                  borderRadius: MessageBubbleSettings.borderRadius,
                                  child: Chewie(
                                    controller: chewieController,
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
                          );
                        },
                      ),
                    ),
                  ),
                ),

                /// Text (shown if there is any)
                if (widget.message.text != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(widget.message.text!),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    chewieController.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }
}
