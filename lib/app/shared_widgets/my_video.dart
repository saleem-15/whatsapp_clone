// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

import 'package:whatsapp_clone/storage/files_manager.dart';

class NetworkOrLocalVideo extends StatefulWidget {
  const NetworkOrLocalVideo({
    Key? key,
    required this.videoUrl,
    required this.fileName,
    required this.chatId,
  }) : super(key: key);

  final String videoUrl;
  final String fileName;
  final String chatId;

  @override
  State<NetworkOrLocalVideo> createState() => _NetworkOrLocalVideoState();
}

class _NetworkOrLocalVideoState extends State<NetworkOrLocalVideo> {
  File? video;

  late final VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();

    getVideo();
  }

  Future<void> getVideo() async {
    File videoFile = await FileManager.getFile(widget.fileName, widget.chatId);

    if (videoFile.existsSync()) {
      video = videoFile;
      await initilizeVideoController();
      return;
    }

    video = await FileManager.saveFileFromNetwork(widget.videoUrl, widget.fileName, widget.chatId);
    await initilizeVideoController();
  }

  Future<void> initilizeVideoController() async {
    videoPlayerController = VideoPlayerController.file(video!);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      allowMuting: false,
      autoInitialize: true,
      allowedScreenSleep: false,
      allowPlaybackSpeedChanging: false,
      allowFullScreen: false,
      showControls: false,
      customControls: const CupertinoControls(
        backgroundColor: Colors.black54,
        iconColor: Colors.white70,
      ),
    );

    ///it may be used by video viewer screen
    Get.put(videoPlayerController, tag: widget.videoUrl);
    
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (video != null) {
      return SizedBox(
        width: 200.w,
        child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: Chewie(
            controller: chewieController,
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
