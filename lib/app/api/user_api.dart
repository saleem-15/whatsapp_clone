// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/app/providers/groups_provider.dart';
import 'package:whatsapp_clone/app/providers/contacts_provider.dart';
import 'package:whatsapp_clone/storage/database/daos/groups_dao.dart';
import 'package:whatsapp_clone/storage/database/daos/private_chats_dao.dart';
import 'package:whatsapp_clone/storage/database/daos/users_dao.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

import '../providers/users_provider.dart';
import 'api.dart';

class UserApi {
  UserApi._();

  static StreamSubscription<DocumentSnapshot>? myDocumentListener;
  static late Stream<DocumentSnapshot> myDocumentStream;

  static late bool isMyDocExists;

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

  static Future<void> setUserFcmToken(String fcmToken) async {
    await myUserDocument.update({
      'fcmToken': fcmToken,
    });
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

  ///returns the file Url in the firestorage
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

    final List<String> contactsIds = myDoc.getStringList('contacts');

    final contactsDocs = await usersCollection.getMultipleDocuments(contactsIds);

    for (DocumentSnapshot userDoc in contactsDocs) {
      myContacts.add(User.fromDoc(userDoc));
    }

    log('number of my contacts: ${myContacts.length}');
    return myContacts;
  }

  /// this method watches the changes that happens to my document
  static Future<void> wathcMyDocChanges() async {
    while (!MySharedPref.getIsMyDocExists) {
      Logger().i('My Document doesnt yet exists');
      await Future.delayed(const Duration(seconds: 1));
    }
    myDocumentStream = myUserDocument.snapshots();

    myDocumentListener = myDocumentStream.listen((document) async {
      // log('****************my document has changed****************');

      final changedChats = await getChangesInChats(document);

      applyChanges(changedChats);

      final String nameInDoc = document['name'];
      final String phoneInDoc = document['phoneNumber'];
      final String bioInDoc = document['about'];
      final String? imageInDoc = document[User.user_image_url_key];

      final user = Get.find<UsersProvider>().me.value;

      if (nameInDoc != user.name ||
          phoneInDoc != user.phoneNumber ||
          bioInDoc != user.bio ||
          imageInDoc != user.imageUrl) {
        UsersDao.updateMyData(
          name: nameInDoc,
          bio: bioInDoc,
          imageUrl: imageInDoc,
        );
      }
    });
  }

  /// this method compares the `stored chat IDs list` with `fetchedChatIDsList`.
  ///
  /// it returns a map with 4 entries
  /// {`newChats`, `removedChats`,`newGroups`,`removedGroups`}
  static Future<Map<String, dynamic>> getChangesInChats(DocumentSnapshot doc) async {
    /// ******changes in groups******
    List<String> fetchedGroupChatIDsList = doc.getStringList('groups');
    final storedGroupsList = await GroupChatsDao.getAllGroupChatsIDs();
    Logger().i('Stored Groups ID\'s: $storedGroupsList');

    final newGroups = fetchedGroupChatIDsList.where((item) => !storedGroupsList.contains(item)).toList();
    final removedGroups = storedGroupsList.where((item) => !fetchedGroupChatIDsList.contains(item)).toList();

    /// ******changes in contacts******

    /// contacts are stored as a map<userId,privateChatId> in firestore
    final fetchedContacts = doc.get('contacts') as Map;
    final storedContacts = await PrivateChatsDao.getContactsMap();

    Logger().i('Stored Private Chats ID\'s: $storedContacts');

    Map<String, String> newContacts = {};
    Map<String, String> removedContacts = {};

    fetchedContacts.forEach((contactId, chatId) {
      ///check if the contact is stored locally
      bool isStoredLocally = storedContacts.keys.contains(contactId);

      if (!isStoredLocally) {
        newContacts[contactId] = chatId;
      }
    });

    storedContacts.forEach((contactId, chatId) {
      ///check if the contact is stored in Backend
      bool isExistInBackend = fetchedContacts.keys.contains(contactId);

      if (!isExistInBackend) {
        removedContacts[contactId] = chatId;
      }
    });

    Logger().wtf('New Contacts: \n$newContacts');
    Logger().wtf('Removed Contacts: \n$removedContacts');

    return {
      'newContacts': newContacts,
      'removedContacts': removedContacts,
      'removedGroups': removedGroups,
      'newGroups': newGroups,
    };
  }

  static Future<List<User>> fetchUsers(List<String> usersIds) async {
    final result = await usersCollection
        .where(
          FieldPath.documentId,
          whereIn: usersIds,
        )
        .get();

    return result.docs
        .map(
          (userDoc) => User.fromDoc(userDoc),
        )
        .toList();
  }

  static void stopWathcingMyDocChanges() {
    myDocumentListener?.cancel();
  }
}

void applyChanges(Map<String, dynamic> changedChats) {
  /// new private chats
  final newContacts = changedChats['newContacts'] as Map;

  if (newContacts.isNotEmpty) {
    Logger().i('new Private Chats ID\'s: $newContacts');
    Get.find<ContactsProvider>().fetchMultipleNewContacts(newContacts.cast());
  }

  ///deleted private chats
  final deletedContacts = changedChats['removedContacts'] as Map;

  if (deletedContacts.isNotEmpty) {
    Logger().i('removed Private Chats ID\'s: $deletedContacts');
    Get.find<ContactsProvider>().deleteMultipleContacts(deletedContacts.cast());
  }

  ///new groups
  final newGroupChats = changedChats['newGroups'] as List<String>;

  if (newGroupChats.isNotEmpty) {
    Logger().i('new Groups ID\'s: $newGroupChats');
    Get.find<GroupChatsProvider>().fetchNewGroups(newGroupChats);
  }

  ///deleted groups
  final deletedGroupChatsIDs = changedChats['removedGroups'] as List<String>;

  if (deletedGroupChatsIDs.isNotEmpty) {
    Logger().i('Deleted Groups ID\'s: $deletedGroupChatsIDs');
    Get.find<GroupChatsProvider>().deleteMultipleGroupChat(deletedGroupChatsIDs);
  }
}
