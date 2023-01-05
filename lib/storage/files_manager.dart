// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

// ...

class FileManager {
  FileManager._();
  // static final _instance = FileManager();
  // static FileManager get instance => _instance;

  ///this function creates the file structure for the app
  ///
  ///if it was called  and the file structure already exists
  ///notihing will happen
  static Future<void> initFiles() async {
    final appDir = await getExternalStorageDirectory();

    await Directory('${appDir!.path}/chats').create();
    return;
  }

  /// returnes the storage path for this chat,
  ///
  /// if the chat folder does not exist it creates the folder and returnes its path
  static Future<String> getChatStoragePath(String chatId) async {
    //make sure that the file structure is valid
    await initFiles();
    final appDir = await getExternalStorageDirectory();
    final path = '${appDir!.path}/$chatId';

    await Directory(path).create();
    return path;
  }

  ///saves the file in the chat storage path
  static Future<void> saveToFile(File file, String chatId) async {
    log('the file to be saved: ${file.path}');

    final chatStoragePath = await getChatStoragePath(chatId);

    /// file name like => (myPhoto.jpg)
    final fileName = basename(file.path);

    ///copy the file into the chat storage path
    file.copy('$chatStoragePath/$fileName');
    log('FileManage => saveToFile => the file is saved in  =>$chatStoragePath/$fileName');
  }

  /// returnes the file from the chat storage
  ///
  /// Note: the file may not exist you have to check  =>` File(...).exists()`
  static Future<File> getFile(String fileName, String chatId) async {
    final chatStoragePath = await getChatStoragePath(chatId);

    return File('$chatStoragePath/$fileName');
  }

  ///-----------------------------------------------------------------
  ///Checks if the file exists in the chat storage path
  static Future<bool> isFileSaved(String fileName, String chatId) async {
    final File file = await getFile(fileName, chatId);

    return file.exists();
  }

  // Future<bool> isFileSaved(String fileName, String chatId) async {
  //   // final fileName = Utils.getFileNameFireStorage(fileUrl);

  //   final chatStoragePath = await getStoragePath(chatId);
  //   final dir = Directory(chatStoragePath);
  //   final List<FileSystemEntity> filesList = dir.listSync();

  //   final isSaved = filesList.any((storedFile) {
  //     if (fileName == basename(storedFile.path)) {
  //       return true;
  //     }
  //     return false;
  //   });

  //   if (isSaved) {
  //     log('$fileName is SAVED before');
  //   } else {
  //     log('$fileName is NOT saved before');
  //   }
  //   return isSaved;
  // }

  // Future<String> findExistingFileStoragePath(String fileURl, String chatId) async {
  //   final appDir = await getExternalStorageDirectory();
  //   final fileName = Utils.getFileNameFireStorage(fileURl);

  //   final path = '${appDir!.path}/$chatId/$fileName';
  //   return path;
  // }

  // Future<String> saveFileFromNetwork(String fileURl, String chatId) async {
  //   final isSaved = await isFileSaved(fileURl, chatId);

  //   if (isSaved) {
  //     // throw Exception('saveFileFromNetwork = >the file is saved before ');

  //     return await findExistingFileStoragePath(fileURl, chatId);
  //   }

  //   final fileName = Utils.getFileName(fileURl);
  //   final response = await http.get(Uri.parse(fileURl));

  //   final path = await getStoragePath(chatId);

  //   final imageFile = File('$path/$fileName');

  //   await imageFile.writeAsBytes(response.bodyBytes);

  //   return imageFile.path;
  // }

  /// returns the path of the saved file
  /// Warning: this function works only on 'Firebase Storage'
  static Future<File> saveFileFromNetwork(String fileURl, String fileName, String chatId) async {
    final isSaved = await isFileSaved(fileURl, chatId);

    if (isSaved) {
      throw Exception('saveFileFromNetwork = >the file is saved before => fileName: $fileName');

      final file = await getFile(fileURl, chatId);
      return file;
    }

    final response = await http.get(Uri.parse(fileURl));

    final chatStoragePath = await getChatStoragePath(chatId);

    final storedFile = File('$chatStoragePath/$fileName');

    await storedFile.writeAsBytes(response.bodyBytes);

    return storedFile;
  }

  /// deletes the file (if exists) from the chat storage path
  static Future<void> deleteFile(String fileName, String chatId) async {
    final chatStoragePath = await getChatStoragePath(chatId);

    final file = File('$chatStoragePath/$fileName');

    if (await file.exists()) {
      await file.delete();
    }
  }
}
