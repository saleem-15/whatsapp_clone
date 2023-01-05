import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

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
}
