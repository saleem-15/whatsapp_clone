import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final String myUid = MySharedPref.getUserId!;
final FirebaseFirestore db = FirebaseFirestore.instance;

final rootStorage = FirebaseStorage.instance.ref();
final usersCollection = db.collection('users');
final myUserDocument = usersCollection.doc(myUid);
final chatsCollection = db.collection('chats');

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
