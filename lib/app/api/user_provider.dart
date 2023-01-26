import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/storage/files_manager.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';
import 'package:whatsapp_clone/utils/extensions/my_extensions.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

import 'api.dart';

class UserProvider {
  UserProvider._();

  static late Rx<ImageProvider> userImage;

  static Future<void> init() async {
    File? imageFile = await FileManager.getUserImage();

    if (imageFile == null) {
      userImage = Rx(const AssetImage(Assets.default_user_image));
      return;
    }

    userImage = Rx(FileImage(imageFile));
  }

  /// returns null if the user does not exist
  static Future<User?> getUserInfoByPhoneNumber(String phoneNumber) async {
    final queryResult = await usersCollection
        .where(
          'phoneNumber',
          isEqualTo: phoneNumber,
        )
        .limit(1)
        .get();

    if (queryResult.docs.isEmpty) {
      return null;
    }

    return User.fromDoc(queryResult.docs.first);
  }

  /// returns null if the user does not exist
  static Future<User?> getUserInfoByUID(String userUID) async {
    final result = await usersCollection.doc(userUID).get();

    if (!result.exists) {
      return null;
    }

    return User.fromDoc(result);
  }

  ///it uses [getUserInfoByPhoneNumber] or [getUserInfoByUID] method to work
  static Future<bool> checkIsUserExists({String? phoneNumber, String? userUID}) async {
    assert(phoneNumber == null || userUID == null);

    User? user;

    if (userUID != null) {
      user = await getUserInfoByUID(userUID);
    } else {
      user = await getUserInfoByPhoneNumber(phoneNumber!);
    }

    return user != null;
  }

  ///
  static Future<void> updateUserProfile(User user) async {
    var userMap = user.toMap();

    ///change last update time
    userMap[User.user_last_Updated_key] = FieldValue.serverTimestamp();

    await usersCollection.doc(user.uid).update(userMap);
  }

  ///,returnes the file Url in the firestorage
  static Future<String> updateUserImage(File imageFile) async {
    final fileExtension = Utils.getFileExtension(imageFile.path);

    final fileRef = rootStorage.child('usersImages/$myUid$fileExtension');

    /// upload image to fireStorage
    await fileRef.putFile(File(imageFile.path)).whenComplete(() => null);

    /// fileUrl in fireStorage
    final fileUrl = await fileRef.getDownloadURL();

    return fileUrl;
  }

  /// returnes all my contacts
  static Future<List<User>> getAllMyContacts() async {
    List<User> myContacts = [];

    final myDoc = await usersCollection.doc(myUid).get();

    final List<String> contactsIds = myDoc.getStringList('myContacts');

    final contactsDocs = await usersCollection.getMultipleDocuments(contactsIds);

    for (DocumentSnapshot userDoc in contactsDocs) {
      myContacts.add(User.fromDoc(userDoc));
    }

    log('number of my contacts: ${myContacts.length}');
    return myContacts;
  }
}
