// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:whatsapp_clone/app/models/messages/video_message.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

class VideoViewerScreen extends StatefulWidget {
  VideoViewerScreen({super.key}) {
    videoMessage = Get.arguments['videoMessage'];
    videoPlayerController = Get.arguments['videoController'];
  }

  late final VideoMessage videoMessage;
  late final VideoPlayerController videoPlayerController;

  @override
  State<VideoViewerScreen> createState() => _VideoViewerScreenState();
}

class _VideoViewerScreenState extends State<VideoViewerScreen> {
  late final ChewieController chewieController;
  @override
  void initState() {
    /// create a new [ChewieController],cuz it has different settings than
    /// the [ChewieController] in the video message bubble
    chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      allowMuting: false,
      allowedScreenSleep: false,
      allowPlaybackSpeedChanging: false,
      allowFullScreen: false,
      autoPlay: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.BlackScaffold,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.videoMessage.senderName,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              Utils.formatDate(widget.videoMessage.timeSent),
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
              dialogBackgroundColor: Colors.black54,
              iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white)),
          child: Hero(
            tag: widget.videoMessage.databaseId,
            child: Material(
              color: Colors.transparent,
              child: Chewie(
                controller: chewieController,
                // controller:widget. chewieController,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ///pause the video
    widget.videoPlayerController.pause();

    ///go to the start (if the user wants to watch the video, he wathces it from the start)
    widget.videoPlayerController.seekTo(Duration.zero);
    super.dispose();
  }
}
