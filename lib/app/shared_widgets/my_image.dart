// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:whatsapp_clone/storage/files_manager.dart';

class NetworkOrLocalImage extends StatefulWidget {
  const NetworkOrLocalImage({
    Key? key,
    required this.imageUrl,
    required this.fileName,
    required this.chatId,
  }) : super(key: key);

  final String imageUrl;
  final String fileName;
  final String chatId;

  @override
  State<NetworkOrLocalImage> createState() => _NetworkOrLocalImageState();
}

class _NetworkOrLocalImageState extends State<NetworkOrLocalImage> {
  File? image;
  @override
  void initState() {
    super.initState();
    getImage();
  }

  Future<void> getImage() async {
    File imageFile = await FileManager.getFile(widget.fileName, widget.chatId);

    if (imageFile.existsSync()) {
      image = imageFile;
      setState(() {});
      return;
    }
    image = await FileManager.saveFileFromNetwork(widget.imageUrl, widget.fileName, widget.chatId);
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return Image.file(image!);
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
