import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/api/api.dart';

import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/models/messages/message.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/storage/database/models/message.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

part '../../../storage/database/generated_code/private_chat.g.dart';

@collection
class PrivateChat extends Chat {
  /// this constructor is for isar database
  PrivateChat() : super.late();

  factory PrivateChat.fromChatAndUserDocs({
    required QueryDocumentSnapshot chatDoc,
    required QueryDocumentSnapshot userDoc,
  }) {
    final user = User.fromDoc(userDoc);

    return PrivateChat()
      ..id = chatDoc.id
      ..createdAt = chatDoc.getDateTime(Message.CREATED_AT_KEY)!
      ..user.value = user

      /// super type [Chat] variables
      ..user.value = user
      ..name = user.name
      ..imageUrl = user.imageUrl
      ..bio = user.bio
      ..usersIds = [user.uid, myUid];
  }

  final user = IsarLink<User>();

  @ignore
  @override
  ImageProvider get imageProvider => (imageUrl == null || imageUrl!.isEmpty
      ? const AssetImage(Assets.DEFAULT_USER_IMAGE)
      : NetworkImage(imageUrl!)) as ImageProvider;

  @ignore
  @override
  bool get isGroupChat => false;

  @override
  String toString() => 'PrivateChat(\nid: $id\n user: $user,\nimage: $imageUrl,\ncreatedAt:$createdAt)';
}
