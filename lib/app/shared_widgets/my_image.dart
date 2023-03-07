// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:whatsapp_clone/storage/files_manager.dart';

class SavedNetworkImage extends StatefulWidget {
  const SavedNetworkImage({
    Key? key,
    required this.imageUrl,
    required this.imageFilePath,
    required this.chatId,
    required this.timeSent,
    required this.onImageDownloaded,
  }) : super(key: key);

  //  const SavedNetworkImage({
  //   super.key,
  //   required this.imageUrl,
  //   required this.imageFilePath,
  //   required this.chatId,
  //   required this.timeSent,
  //   required this.onImageDownloaded,
  // }) : assert(
  //         imageUrl != null || imageFilePath != null,
  //         'imageUrl and imageFilePath cant be both null',
  //       );

  /// the url used to download the image if it wasn't saved in [imageFilePath]
  /// 
  /// Note: it should be null `ONLY` if the current user is uploading the image  
  final String? imageUrl;

  /// the file path that the image should be stored in.\
  /// if the file does not exist in this path the image will be
  /// downloaded and stored in it.
  final String imageFilePath;
  final String chatId;
  
  final DateTime timeSent;

  /// -called when the image is completed downloading\
  /// -parameter [imageUrl] is downloaded image file
  ///
  /// `Note: the image is downloaded when its not found in [imageFilePath]`
  final Function(File image) onImageDownloaded;

  // final Function(File image) onImageDownloaded;

  @override
  State<SavedNetworkImage> createState() => _SavedNetworkImageState();
}

class _SavedNetworkImageState extends State<SavedNetworkImage> {
  File? image;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  /// initilizes [image] field.\
  /// if [widget.imageFilePath] is not null (image is saved in a file)
  ///
  /// if it was not saved it will be downloaded and saved.
  Future<void> getImage() async {
    final imageFile = File(widget.imageFilePath);
    final isFileExists = await imageFile.exists();

    if (isFileExists) {
      image = imageFile;
    } else {
      /// if image is not stored in a file.
      await downloadImage();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> downloadImage() async {
    await FileManager.downloadFile(
      downloadUrl: widget.imageUrl!,

      ///store the image in the provided path
      filePath: widget.imageFilePath,
    );

    image = File(widget.imageFilePath);
    widget.onImageDownloaded(image!);
  }

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return Image.file(
        image!,
        // fit: BoxFit.cover,
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
