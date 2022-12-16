import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatDate(DateTime time) {
    final myTimeFormat = DateFormat('h:mm a');

    return myTimeFormat.format(time);
  }

  static String getCollectionId(String docPath) {
    return docPath.split('/')[0];
  }

  static String getdocId(String docPath) {
    return docPath.split('/')[1];
  }

  static String getFileName(String url) {
    final name = FirebaseStorage.instance.refFromURL(url).name;
    // log('name from firebase is: $name');
    return name;
  }

 static bool hasEmoji(String text) {
    final RegExp emojiRegex = RegExp(r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
    return emojiRegex.hasMatch(text);
  }
}
