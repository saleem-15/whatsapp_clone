import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

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
}

extension MyListExtensions<T> on List<T> {
  void safeAdd(T? value) {
    if (value != null) {
      add(value);
    }
  }

  List<Rx<T>> get convertToRxElements {
    return map((e) => e.obs).toList();
  }

  void safeAddAll(List<T>? values) {
    if (values != null) {
      addAll(values);
    }
  }
}
