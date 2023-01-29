import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/api/api.dart';

import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

part 'private_chat.g.dart';

@collection
class PrivateChat extends Chat {
  PrivateChat() : super.late();

  factory PrivateChat.fromChatAndUserDocs({
    required QueryDocumentSnapshot chatDoc,
    required QueryDocumentSnapshot userDoc,
  }) {
    final user = User.fromDoc(userDoc);
    return PrivateChat()
      ..id = chatDoc.id
      ..createdAt = (chatDoc['createdAt'] as Timestamp).toDate()

      /// super type [Chat] variables
      ..user.value = user
      ..name = user.name
      ..image = user.imageUrl
      ..bio = user.bio
      ..usersIds = [user.uid, myUid];
  }

  ///this id does not realy represents the user
  ///its only exist due to [Isar] database requirements
  Id databaseId = Isar.autoIncrement;

  final user = IsarLink<User>();

  @ignore
  @override
  ImageProvider get imageProvider =>
      (image == null || image!.isEmpty ? const AssetImage(Assets.default_user_image) : NetworkImage(image!))
          as ImageProvider;

  @ignore
  @override
  bool get isGroupChat => false;

  @override
  String toString() => 'PrivateChat(\nid: $id\n user: $user,\nimage: $image,\ncreatedAt:$createdAt)';
}
