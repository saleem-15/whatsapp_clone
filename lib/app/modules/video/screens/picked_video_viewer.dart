import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/generic_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

class PickedVideoScreen extends StatefulWidget {
  PickedVideoScreen({super.key}) {
    videoFile = Get.arguments['videoFile'];
    sendVideo = Get.arguments['sendVideoFunction'];
    aspectRatio = Get.arguments['aspectRatio'];
  }

  late final File videoFile;
  late final double aspectRatio;
  late final void Function(File video, String? message) sendVideo;

  @override
  State<PickedVideoScreen> createState() => _PickedVideoScreenState();
}

class _PickedVideoScreenState extends State<PickedVideoScreen> {
  final _textController = TextEditingController();

  // late final VideoViewerController controller;

  late final VideoPlayerController videoPlayerController;
  late final ChewieController chewieController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.file(widget.videoFile);

    /// create a new [ChewieController],cuz it has different settings than
    /// the [ChewieController] in the video message bubble
    chewieController = ChewieController(
      aspectRatio: widget.aspectRatio,
      videoPlayerController: videoPlayerController,
      allowMuting: false,
      autoInitialize: true,
      allowedScreenSleep: false,
      allowPlaybackSpeedChanging: false,
      allowFullScreen: false,
      showOptions: false,

      // autoPlay: true,
    );

    videoPlayerController.initialize().then((value) => setState(
          () {},
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.BlackScaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Video Preview
            Theme(
              data: Theme.of(context).copyWith(
                  dialogBackgroundColor: Colors.black54,
                  iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white)),
              child: Material(
                color: Colors.transparent,
                child: Chewie(
                  controller: chewieController,
                ),
              ),
            ),

            ///TextField + Send Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Row(
                children: [
                  ///TextFiled
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 4,
                      controller: _textController,
                      decoration: MyStyles.getMessageInputDecoration().copyWith(
                        hintText: 'Add a caption',
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.emoji_emotions_outlined),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 10.sp,
                  ),

                  ///send button
                  GradientGenericButton(
                    onPressed: () {
                      final message = _textController.text.trim();

                      widget.sendVideo(
                        widget.videoFile,
                        message.isEmpty ? null : message,
                      );

                      Get.back();
                    },
                    child: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // controller.dispose();

    _textController.dispose();
    super.dispose();
  }
}
