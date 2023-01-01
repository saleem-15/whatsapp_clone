// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String phoneNumber;
  String? imageUrl;

  /// -------field names (used when getting, sending request to back end)------
  static const user_image_url_key = 'imageUrl';
  static const user_name_key = 'name';
  static const user_phone_number_key = 'phoneNumber';
  static const user_private_chats_key = 'chats';
  static const user_group_chats_key = 'groups';

  ///--------------------------------------------------------------------
  User({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
  });

  factory User.fromDoc(QueryDocumentSnapshot doc) {
    return User(
      uid: doc.id,
      name: doc[user_name_key] as String,
      phoneNumber: doc[user_phone_number_key] as String,
      imageUrl: doc[user_image_url_key],
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
    };
  }
}
