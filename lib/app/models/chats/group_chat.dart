import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/storage/database/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

import '../../../utils/constants/assests.dart';
import '../user.dart';

part '../../../storage/database/generated_code/group_chat.g.dart';

@Collection(accessor: 'groups')
class GroupChat extends Chat {
  GroupChat({
    required super.id,
    required super.name,
    super.imageUrl,
    required super.bio,
    required super.createdAt,
    required super.usersIds,
  });
  static const GROUP_NAME_KEY = 'groupName';

  factory GroupChat.fromChatDoc(QueryDocumentSnapshot groupDoc) {
    assert(groupDoc.exists);

    return GroupChat(
      id: groupDoc.id,
      createdAt: groupDoc.getDateTime(Chat.CREATED_AT_KEY)!,
      imageUrl: groupDoc['imageUrl'],
      name: groupDoc['groupName'],
      bio: groupDoc['bio'] ?? 'Some Bullshit Quote',
      usersIds: groupDoc.getStringList(Chat.CHAT_MEMBERS_KEY),
    );
  }

  final users = IsarLinks<User>();

  @ignore //dont store this field in the database
  @override
  ImageProvider get imageProvider =>
      (Utils.isBlank(imageUrl) ? const AssetImage(Assets.CHAT_IMAGE) : NetworkImage(imageUrl!))
          as ImageProvider;

  @ignore //dont store this field in the database
  @override
  bool get isGroupChat => true;

  @override
  String toString() =>
      'GroupChat(\nid: $id name: $name, bio: $bio, image: $imageUrl,createdAt:$createdAt,usersIds: $usersIds)';
}
