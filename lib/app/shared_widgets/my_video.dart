// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:whatsapp_clone/storage/files_manager.dart';

class NetworkOrLocalVideo extends StatefulWidget {
  const NetworkOrLocalVideo({
    Key? key,
    required this.videoUrl,
    required this.videoFilePath,
    required this.chatId,
    required this.aspectRatio,
    required this.onVideoDownloaded,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  final String videoUrl;

  final String videoFilePath;

  final double aspectRatio;

  final String chatId;
  final BorderRadius? borderRadius;

  final Function(File image) onVideoDownloaded;

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

  // Future<void> getVideo() async {
  //   File videoFile = await FileManager.getFile(widget.videoFilePath, widget.chatId);

  //   // debugger();
  //   if (await videoFile.exists()) {
  //     Logger().w('The file does exist: ${videoFile.path}');
  //     video = videoFile;
  //     await initilizeVideoController();
  //     // debugger();
  //     return;
  //   }

  //   // debugger();
  //   video = await FileManager.saveFileFromNetwork(widget.videoUrl, widget.videoFilePath, widget.chatId);
  //   await initilizeVideoController();
  // }

  /// initilizes [video] field.\
  /// if [widget.videoFilePath] is not null (video is saved in a file)
  ///
  /// if it was not saved it will be downloaded and saved.
  Future<void> getVideo() async {
    final videoFile = File(widget.videoFilePath);
    final isFileExists = await videoFile.exists();

    if (isFileExists) {
      video = videoFile;
    } else {
      /// if video is not stored in a file.
      await downloadVideo();
    }
    await initilizeVideoController();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> downloadVideo() async {
    await FileManager.downloadFile(
      downloadUrl: widget.videoUrl,

      ///store the video in the provided path
      filePath: widget.videoFilePath,
    );

    video = File(widget.videoFilePath);
    widget.onVideoDownloaded(video!);
  }

  Future<void> initilizeVideoController() async {
    videoPlayerController = VideoPlayerController.file(video!);
    chewieController = ChewieController(
      aspectRatio: widget.aspectRatio,
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

  // aspectRatio: chewieController.videoPlayerController.value.aspectRatio,
  @override
  Widget build(BuildContext context) {
    if (video != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius,
        child: Chewie(
          controller: chewieController,
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
