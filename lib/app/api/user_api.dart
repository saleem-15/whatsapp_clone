// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/app/providers/chats_provider.dart';
import 'package:whatsapp_clone/storage/database/daos/groups_dao.dart';
import 'package:whatsapp_clone/storage/files_manager.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';
import 'package:whatsapp_clone/utils/extensions/my_extensions.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

import 'api.dart';

class UserApi {
  UserApi._();

  static late final StreamSubscription<DocumentSnapshot<Object?>> myDocumentListener;
  static late final Stream<DocumentSnapshot<Object?>> myDocumentStream;

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

  /// this method watches the changes that happens to my document
  static void wathcMyDocChanges() {
    myDocumentStream = usersCollection.doc(myUid).snapshots();

    myDocumentListener = myDocumentStream.listen((document) async {
      log('****************my document has changed****************');

      final changedChats = await getChangesInChats(document);

      applyChanges(changedChats);

      final nameInDoc = document['name'];
      final phoneInDoc = document['phoneNumber'];
      final aboutInDoc = document['about'];

      if (nameInDoc != MySharedPref.getUserName ||
          phoneInDoc != MySharedPref.getUserPhoneNumber ||
          aboutInDoc != MySharedPref.getUserAbout) {
        MySharedPref.updateUserData(name: nameInDoc, phone: phoneInDoc, about: aboutInDoc);
      }
    });
  }

  /// this method compares the `stored chat IDs list` with `fetchedChatIDsList`.
  ///
  /// it returns a map with 4 entries
  /// {`newChats`, `removedChats`,`newGroups`,`removedGroups`}
  static Future<Map<String, List<String>>> getChangesInChats(DocumentSnapshot doc) async {
    /// changes in groups
    List<String> fetchedGroupChatIDsList = doc.getStringList('groups');
    final storedGroupsList = await GroupChatsDao.getAllGroupChatsIDs();

    final newGroups = fetchedGroupChatIDsList.where((item) => !storedGroupsList.contains(item)).toList();
    final removedGroups = storedGroupsList.where((item) => !fetchedGroupChatIDsList.contains(item)).toList();

    /// changes in private chats
    List<String> fetchedPrivateChatsIDsList = doc.getStringList('chats');
    final storedPrivateChatsList = MySharedPref.getUserChatIds;

    final newPrivateChats =
        fetchedPrivateChatsIDsList.where((item) => !storedPrivateChatsList.contains(item)).toList();
    final removedPrivateChats =
        storedPrivateChatsList.where((item) => !fetchedPrivateChatsIDsList.contains(item)).toList();

    return {
      'newChats': newPrivateChats,
      'removedChats': removedPrivateChats,
      'removedGroups': removedGroups,
      'newGroups': newGroups,
    };
  }
}

void applyChanges(Map<String, List<String>> changedChats) {
  ///new private chats
  final newPrivateChats = changedChats['newChats'];

  if (newPrivateChats!.isNotEmpty) {
    //
  }

  ///deleted private chats
  final deletedPrivateChats = changedChats['removedChats'];

  if (deletedPrivateChats!.isNotEmpty) {
    //
  }

  ///new groups
  final newGroupChats = changedChats['newGroups'];

  if (newGroupChats!.isNotEmpty) {
    newGroupChats.printInfo(info: 'New groups Ids');
    Get.find<GroupChatsProvider>().fetchMultipleNewGroupChat(newGroupChats);
  }

  ///deleted groups
  final deletedGroupChats = changedChats['removedGroups'];

  if (deletedGroupChats!.isNotEmpty) {
    deletedGroupChats.printInfo(info: 'Removed groups Ids');
    log('*${deletedGroupChats.first}*');
    Get.find<GroupChatsProvider>().deleteMultipleGroupChat(deletedGroupChats);
  }
}
