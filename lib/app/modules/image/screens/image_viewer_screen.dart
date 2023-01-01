// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:whatsapp_clone/app/models/messages/image_message.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({
    Key? key,
    required this.imageMessage,
    required this.imageFile,
  }) : super(key: key);

  final ImageMessage imageMessage;
  final File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              imageMessage.senderName,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              Utils.formatDate(imageMessage.timeSent),
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Center(
        child: Hero(
          tag: imageMessage.imageUrl,
          child: ExtendedImage(
            image: FileImage(imageFile),
            fit: BoxFit.contain,
            mode: ExtendedImageMode.gesture,
          ),
        ),
      ),
    );
  }
}
