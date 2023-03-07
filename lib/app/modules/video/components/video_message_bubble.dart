// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/my_video.dart';
import 'package:whatsapp_clone/storage/files_manager.dart';
import 'package:whatsapp_clone/utils/helpers/message_bubble_settings.dart';

import '../../chat/components/messages/media_message_size.dart';

class VideoMessageBubble extends StatefulWidget {
  const VideoMessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final VideoMessage message;

  @override
  State<VideoMessageBubble> createState() => _VideoMessageBubbleState();
}

class _VideoMessageBubbleState extends State<VideoMessageBubble> {
  // late final VideoViewerController videoController;
  late final ChatScreenController controller;

  /// the calculated video size
  late final Size displayedSize;

  @override
  void initState() {
    controller = Get.find<ChatScreenController>();
    displayedSize = MediaMessageSize.calculateMediaSize(
      messageHeight: widget.message.height.toDouble(),
      messageWidth: widget.message.width.toDouble(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Logger().w('height: ${widget.message.height} - width: ${widget.message.width}');
    return Container(
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
            size: displayedSize,
            child: GestureDetector(
              onTap: () => controller.onVideoPressed(widget.message),
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  ///video
                  Hero(
                    tag: widget.message.databaseId,
                    child: NetworkOrLocalVideo(
                      borderRadius: MessageBubbleSettings.allCornersRoundedBorder,
                      chatId: widget.message.chatId,
                      aspectRatio: widget.message.aspectRatio,
                      videoFilePath: widget.message.videoPath,
                      videoUrl: widget.message.videoUrl,
                      onVideoDownloaded: (video) => controller.onvideoDownloaded(widget.message, video),
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
            Container(
              width: displayedSize.width,
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(widget.message.text!),
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // chewieController.dispose();
    // videoPlayerController.dispose();
    super.dispose();
  }
}
