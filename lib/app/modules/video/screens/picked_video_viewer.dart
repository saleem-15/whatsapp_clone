import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/generic_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

class PickedVideoScreen extends StatefulWidget {
  const PickedVideoScreen({
    Key? key,
    required this.videoFile,
    required this.sendVideo,
  }) : super(key: key);

  final File videoFile;
  final void Function(File video, String? message) sendVideo;

  @override
  State<PickedVideoScreen> createState() => _PickedVideoScreenState();
}

class _PickedVideoScreenState extends State<PickedVideoScreen> {
  final _textController = TextEditingController();

  late final VideoViewerController controller;

  @override
  void initState() {
    controller = VideoViewerController();

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
            VideoViewer(
              controller: controller,
              source: {
                "SubRip Text": VideoSource(
                  video: VideoPlayerController.file(widget.videoFile),
                )
              },
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
