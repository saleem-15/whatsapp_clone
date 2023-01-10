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
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => controller.onViedeoPressed(widget.message),

      /// The outside (container/Card) that contains all the message and its information
      child: Container(
        // width: widget.message.width.toDouble(),
        clipBehavior: Clip.antiAlias,

        padding: const EdgeInsets.all(5),
        margin: MessageBubbleSettings.messageMargin(isMyMessage: widget.message.isMyMessage),
        decoration: MessageBubbleSettings.messageDecoration(isMyMessage: widget.message.isMyMessage),

        /// Video & text (video caption)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///video
            SizedBox.fromSize(
              size: calculateVideoSize(
                MessageBubbleSettings.maxMessageWidth,
                MessageBubbleSettings.maxMessageHeight,
              ),
              child: AspectRatio(
                aspectRatio: widget.message.aspectRatio,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    ///video
                    Container(
                      color: Colors.yellow.shade100,
                      child: Hero(
                        tag: widget.message.videoUrl,
                        child: NetworkOrLocalVideo(
                          borderRadius: MessageBubbleSettings.allCornersRoundedBorder,
                          chatId: widget.message.chatId,
                          fileName: widget.message.videoName,
                          videoUrl: widget.message.videoUrl,
                        ),
                      ),
                    ),

                    /// play icon (just icon not a button)
                    Align(
                      alignment: Alignment.center,
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
    );
  }

  /// this method returns a `Size`  that is not larger than
  /// the parameters `(maxWidthSize,maxHeightSize)`.
  ///
  /// while preserving the aspect of the video.
  Size calculateVideoSize(double maxWidthSize, double maxHeightSize) {
    final videoWidth = widget.message.width.toDouble();
    final videoHeight = widget.message.height.toDouble();
    final mediaType = widget.message.mediaType;

    final aspectRatio = widget.message.aspectRatio;

    double w = videoWidth;
    double h = videoHeight;

    if (videoWidth > maxWidthSize) {
      w = maxWidthSize;
    }

    if (videoHeight > maxHeightSize) {
      h = maxHeightSize;
    }

    if (mediaType == MediaType.landscape) {
      h = w * aspectRatio;
    } else if (mediaType == MediaType.portrait) {
      w = h / aspectRatio;
    }

    log('height: $h\t\t w:$w');

    return Size(w, h);
  }

  @override
  void dispose() {
    // chewieController.dispose();
    // videoPlayerController.dispose();
    super.dispose();
  }
}
