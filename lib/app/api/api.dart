import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../providers/users_provider.dart';

// class Api{

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;

final rootStorage = FirebaseStorage.instance.ref();
final usersCollection = db.collection('users');
final chatsCollection = db.collection('chats');
String get myUid => Get.find<UsersProvider>().me.value.uid;
DocumentReference get myUserDocument => usersCollection.doc(myUid);

extension CollectionExtensions on CollectionReference {
  /// gets multiple documents,
  /// it finishes when all the queires are done
  Future<List<DocumentSnapshot>> getMultipleDocuments(List<String> documentsIds) async {
    List<Future<DocumentSnapshot>> futures = [];

    for (String docId in documentsIds) {
      futures.add(doc(docId).get());
    }

    return Future.wait(futures);
  }
}

extension MyExtension on DocumentSnapshot {
  ///
  Object? safeGet(String fieldName) {
    try {
      return get(fieldName);
    } on StateError catch (e) {
      debugPrint("$e |field name: $fieldName");
      log(e.stackTrace.toString());
      return null;
    }
  }

  List<String> getStringList(String name) {
    return List.castFrom<dynamic, String>(get(name));
  }

  DateTime? getDateTime(String field) {
    return (get(field) as Timestamp?)?.toDate();
  }
}
