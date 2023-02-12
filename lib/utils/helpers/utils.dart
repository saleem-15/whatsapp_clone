// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import 'dart:async';

class Utils {
  static String formatDate(DateTime time) {
    final myTimeFormat = DateFormat('h:mm a');

    return myTimeFormat.format(time);
  }

  static String getFileNameFireStorage(String url) {
    final name = FirebaseStorage.instance.refFromURL(url).name;
    // log('name from firebase is: $name');
    return name;
  }

  /// if file path was (/data/file_picker/HomeWork 1.docx)
  /// it will return (HomeWork 1.docx)
  static String getFilName(String filePath) {
    return filePath.split('/').last;
  }

  /// returnes file size in Bytes
  static int getFileSize(File file) {
    return file.lengthSync();
  }

  /// if file path was (/data/file_picker/HomeWork 1.docx)
  /// it will return (.docx)
  static String getFileExtension(String filePath, [bool withDot = true]) {
    final fileName = getFilName(filePath);
    final extenstion = fileName.split('.').last;

    return withDot ? '.$extenstion' : extenstion;
  }

  static String? extractUrl(String text) {
    String containsUrlRegex =
        r"(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})";

    RegExp pattern = RegExp(containsUrlRegex);

    return pattern.stringMatch(text);
  }

  static bool containsUrl(String text) {
    String containsUrlRegex =
        r"(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})";

    RegExp pattern = RegExp(containsUrlRegex);

    return pattern.hasMatch(text);
  }

  static bool hasEmoji(String text) {
    final RegExp emojiRegex = RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
    return emojiRegex.hasMatch(text);
  }

  static Future<void> launchLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  static const Uuid _uuid = Uuid();
  static String randomId() {
    return _uuid.v4();
  }

  static Future<VideoData?> getVideoInfo(String videoFilePath) async {
    return await FlutterVideoInfo().getVideoInfo(videoFilePath);
  }

//   Future<Size> calculateImageDimension(File imageFile) {
//     Completer<Size> completer = Completer();
//     final image = Image.file(imageFile);

//     image.image.resolve(const ImageConfiguration()).addListener(
//       ImageStreamListener(
//         (ImageInfo image, bool synchronousCall) {
//           var myImage = image.image;
//           Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
//           completer.complete(size);
//         },
//       ),
//     );
//     return completer.future;
//   }
// }

// Future<Size> getImageSize(File imageFile) async {
//   Map<String, IfdTag> exifData = await readExifFromBytes(await imageFile.readAsBytes());
//   int width = exifData[ExifCodec.width]!.values[0];
//   int height = exifData[ExifCodec.height]!.values[0];
//   return Size(width, height);
// }

 static Future<Size> getImageSize(File imageFile) async {
    final size = ImageSizeGetter.getSize(FileInput(imageFile));
    return size;
  }

}
