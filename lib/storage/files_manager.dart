// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone/storage/database/daos/users_dao.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

// ...

enum FileType {
  image,
  video,
  audio,
  file,
}

class FileManager {
  FileManager._();

  ///this function creates the file structure for the app
  ///
  ///if it was called  and the file structure already exists
  ///notihing will happen
  static Future<void> init() async {
    final appDir = await getExternalStorageDirectory();

    await Directory('${appDir!.path}/chats').create();
    return;
  }

  /// returnes the storage path for this chat,
  ///
  /// if the chat folder does not exist it creates the folder and returnes its path
  static Future<String> getChatStoragePath(String chatId) async {
    //make sure that the file structure is valid
    await init();
    final appDir = await getExternalStorageDirectory();
    final path = '${appDir!.path}/$chatId';

    await Directory(path).create();
    return path;
  }

  ///saves the file in the chat storage path\
  ///returns the path where file is saved
  static Future<String> saveToFile(File file, String fileName, String chatId) async {
    final chatStoragePath = await getChatStoragePath(chatId);

    final filePath = '$chatStoragePath/$fileName';

    ///copy the file into the chat storage path
    await file.copy(filePath);
    log('FileManage => saveToFile => the file is saved in  =>$filePath');
    return filePath;
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
  static Future<bool> isFileSaved(String filePath) async {
    // final File file = await getFile(filePath, chatId);

    // return file.exists();
    return File(filePath).exists();
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
  // static Future<File> saveFileFromNetwork(String fileURl, String fileName, String chatId) async {
  //   final isSaved = await isFileSaved(fileURl, chatId);

  //   if (isSaved) {
  //     ///throw exception only if its (Debug mode)
  //     if (kDebugMode) {
  //       throw Exception('saveFileFromNetwork = >the file is saved before => fileName: $fileName');
  //     }

  //     final file = await getFile(fileURl, chatId);
  //     return file;
  //   }

  //   final response = await http.get(Uri.parse(fileURl));

  //   final chatStoragePath = await getChatStoragePath(chatId);

  //   final storedFile = File('$chatStoragePath/$fileName');

  //   await storedFile.writeAsBytes(response.bodyBytes);

  //   return storedFile;
  // }

  // downloadFile(String chatId) async {
  //   final dio = Dio();
  //   String downloadUrl = 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4';
  //   String fileName = 'sample_video.mp4';

  //   final chatStoragePath = await getChatStoragePath(chatId);
  //   String filePath = '$chatStoragePath/$fileName';

  //   await dio.download(
  //     downloadUrl,
  //     filePath,
  //     onReceiveProgress: (received, total) {
  //       // _downloadProgress = received / total;
  //     },
  //   );

  // }

  ///-Downloads the file from [downloadUrl] and saves it to [filePath]
  ///
  ///-[onProgressChanges] is called when a progress happens to the download
  static Future<void> downloadFile({
    required String downloadUrl,
    required String filePath,
    void Function(int received, int total)? onProgressChanges,
  }) async {
    final dio = Dio();

    try {
      await dio.download(
        downloadUrl,
        filePath,
        onReceiveProgress: onProgressChanges,
      );
    } on DioError catch (e) {
      Logger().e(e.message);
    }
    return;
  }

  /// deletes the file (if exists) from the chat storage path
  static Future<void> deleteFile(String fileName, String chatId) async {
    final chatStoragePath = await getChatStoragePath(chatId);

    final file = File('$chatStoragePath/$fileName');

    if (await file.exists()) {
      await file.delete();
    }
  }

  ///---------------------- Special functions----------------------

  ///saves the user image
  static Future<void> saveUserImage(File imageFile) async {
    final appDir = await getExternalStorageDirectory();

    final storagePath = '${appDir!.path}/userImage${Utils.getFileExtension(imageFile.path)}';

    ///copy the file into the storage path
    imageFile.copy(storagePath);

    ///stores the image path
    /// (I stored the user image path due to various image extensions (jpg,png,...) )

    UsersDao.updateMyData(
      imageUrl: storagePath,
      updateImage: true,
    );
  }

  ///returnes  user image
  // static Future<File?> getUserImage() async {
  //   String? userImagePath = MySharedPref.getUserImage;

  //   if (userImagePath == null) {
  //     return null;
  //   }

  //   return File(userImagePath);
  // }

  /// -this method creates a unique file name in a specifc chat.\
  /// -this means the file name is always unique for this chat.\
  /// -`the file name may exist in another chat`.\
  /// -Ex: IMG-20221008-00001\
  /// `Note: this function does not output the file extension,
  /// You have to manually add it `\
  /// -Use [generateFileMessageFileName] for generating file names for `FileMessage`
  static String generateMediaFileName(FileType fileType, String chatId, DateTime fileTimeSent) {
    assert(fileType.name != FileType.file.name);

    String prefix;

    switch (fileType) {
      case FileType.audio:
        prefix = "AUD";
        break;

      case FileType.video:
        prefix = "VID";
        break;

      case FileType.image:
        prefix = "IMG";
        break;

      default:
        throw 'This function is only used for (image,video,audio) messages';
    }

    String date = fileTimeSent.toString().substring(0, 10).replaceAll("-", "");
    int counter = MySharedPref.getChatCounter(chatId);

    return "$prefix-$date-${counter.toString().padLeft(5, '0')}";
  }

  ///Only used to generate the `fileName for fileMessage`\
  ///[originalFileName]=> if the user has sent a file with name 'homeWork.docx'
  /// u must pass this name to this method.
  ///
  ///use [generateMediaFileName] for generating file names for `(image,video,audio) messages`
  static String generateFileMessageFileName(DateTime fileTimeSent, {required String originalFileName}) {
    return '${fileTimeSent.toIso8601String()}*$originalFileName';

    // final chatFolder = await getChatStoragePath(chatId);

    // String filePath = '$chatFolder/$fileName';
    // int counter = 1;
    // while (await File(filePath).exists()) {
    //   fileName = '$fileName($counter)';
    //   counter++;
    // }

    // return fileName;
  }
}
