import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

extension MyExtension on DocumentSnapshot {
  ///
  Object? safeGet(String fieldName) {
    try {
      return get(fieldName);
    } on StateError catch (e) {
      log("$e |field name: $fieldName");
      return null;
    }
  }
}
