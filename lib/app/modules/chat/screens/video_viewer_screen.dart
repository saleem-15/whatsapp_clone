// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_viewer/video_viewer.dart';

import 'package:whatsapp_clone/app/models/message.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

class VideoViewerScreen extends StatefulWidget {
  const VideoViewerScreen({
    Key? key,
    required this.videoMessage,
    required this.videoPlayerController,
  }) : super(key: key);

  final Message videoMessage;

  final VideoPlayerController videoPlayerController;

  @override
  State<VideoViewerScreen> createState() => _VideoViewerScreenState();
}

class _VideoViewerScreenState extends State<VideoViewerScreen> {
  @override
  void initState() {
    widget.videoPlayerController.play();
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
        child: Hero(
          tag: widget.videoMessage.video!,
          child: Theme(
            data: Theme.of(context).copyWith(
                dialogBackgroundColor: Colors.black54,
                iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white)),
            child: Material(
              color: Colors.transparent,
              child: Chewie(
                controller: ChewieController(
                  videoPlayerController: widget.videoPlayerController,
                  allowMuting: false,
                  allowedScreenSleep: false,
                  allowPlaybackSpeedChanging: false,
                  allowFullScreen: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.videoPlayerController.pause();
    widget.videoPlayerController.seekTo(Duration.zero);
    super.dispose();
  }
}
