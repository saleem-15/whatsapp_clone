import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

import 'package:get/get_utils/get_utils.dart';

// part 'user.g.dart';

@Collection()
class User {
  ///this id does not realy represents the user
  ///its only exist due to [Isar] database requirements
  Id id = Isar.autoIncrement;

  String uid;
  String name;
  String phoneNumber;
  String about;
  DateTime lastUpdated;
  String? imageUrl;

  /// -------field names (used when getting, sending request to back end)------
  static const user_image_url_key = 'imageUrl';
  static const user_name_key = 'name';
  static const user_phone_number_key = 'phoneNumber';
  static const user_private_chats_key = 'chats';
  static const user_group_chats_key = 'groups';
  static const user_last_Updated_key = 'lastUpdated';
  static const user_about_key = 'about';

  ///--------------------------------------------------------------------
  User({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.lastUpdated,
    required this.about,
  });

  ImageProvider get imageProvider => (imageUrl == null || imageUrl!.isBlank!
      ? const AssetImage(Assets.default_user_image)
      : NetworkImage(imageUrl!)) as ImageProvider;

  factory User.fromDoc(dynamic doc) {
    return User(
      uid: doc.id,
      name: doc[user_name_key] as String,
      phoneNumber: doc[user_phone_number_key] as String,
      imageUrl: doc[user_image_url_key],
      lastUpdated: (doc[user_last_Updated_key] as Timestamp).toDate(),
      about: doc[user_about_key],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ///name
      user_name_key: name,

      ///phone
      user_phone_number_key: phoneNumber,

      ///user image
      user_image_url_key: imageUrl,

      user_last_Updated_key: Timestamp.fromDate(lastUpdated),

      user_about_key: about,
    };
  }
}
