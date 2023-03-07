// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart' hide Index;
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:isar/isar.dart';

import 'package:whatsapp_clone/utils/constants/assests.dart';

part 'user.g.dart';

@collection
class User {
  ///this id does not realy represents the user
  ///its only exist due to [Isar] database requirements
  late Id databaseId;

  @Index(unique: true, replace: true)
  late String uid;

  late String name;
  late String phoneNumber;
  late String bio;
  late DateTime lastUpdated;
  late String? imageUrl;

  /// -------field names (used when getting, sending request to back end)------
  static const user_image_url_key = 'imageUrl';
  static const user_name_key = 'name';
  static const user_phone_number_key = 'phoneNumber';
  static const user_group_chats_key = 'groups';
  static const user_last_Updated_key = 'lastUpdated';
  static const user_bio_key = 'bio';

  ///--------------------------------------------------------------------
  ///this is for isar database
  User();

  User.normal({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.lastUpdated,
    required this.bio,
  }) : databaseId = int.parse(phoneNumber.substring(1));

  @ignore
  ImageProvider get imageProvider => (imageUrl == null || imageUrl!.isBlank!
      ? const AssetImage(Assets.DEFAULT_USER_IMAGE)
      : NetworkImage(imageUrl!)) as ImageProvider;

  factory User.fromDoc(dynamic doc) {
    return User.normal(
      uid: doc.id,
      name: doc[user_name_key] as String,
      phoneNumber: doc[user_phone_number_key] as String,
      imageUrl: doc[user_image_url_key],
      lastUpdated: (doc[user_last_Updated_key] as Timestamp).toDate(),
      bio: doc[user_bio_key],
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

      user_bio_key: bio,
    };
  }

  @override
  String toString() {
    return 'User(databaseId: $databaseId, uid: $uid, name: $name, phoneNumber: $phoneNumber, about: $bio, lastUpdated: $lastUpdated, imageUrl: $imageUrl)';
  }
}
