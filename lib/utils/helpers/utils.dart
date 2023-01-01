// ignore: depend_on_referenced_packages
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

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

  /// returnes file size as double
 static double getFileSize(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

  /// if file path was (/data/file_picker/HomeWork 1.docx)
  /// it will return (.docx)
  static String getFileExtension(String filePath) {
    final fileName = getFilName(filePath);
    final extenstion = fileName.split('.').last;

    return '.$extenstion';
  }

  static bool hasEmoji(String text) {
    final RegExp emojiRegex = RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
    return emojiRegex.hasMatch(text);
  }
}
