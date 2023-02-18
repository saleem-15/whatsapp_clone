import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/api/api.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/storage/database/models/message.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';

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

  factory GroupChat.fromChatDoc(QueryDocumentSnapshot chatDoc) {
    assert(chatDoc.exists);
    return GroupChat(
      id: chatDoc.id,
      createdAt: chatDoc.getDateTime('createdAt')!,
      imageUrl: chatDoc['imageUrl'],
      name: chatDoc['groupName'],
      bio: chatDoc['bio'] ?? 'Some Bullshit Quote',
      usersIds: chatDoc.getStringList('members'),
    );
  }

  final users = IsarLinks<User>();

  @ignore //dont store this field in the database
  @override
  ImageProvider get imageProvider =>
      (imageUrl.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(imageUrl!))
          as ImageProvider;

  @ignore //dont store this field in the database
  @override
  bool get isGroupChat => true;

  @override
  String toString() =>
      'GroupChat(\nid: $id name: $name, bio: $bio, image: $imageUrl,createdAt:$createdAt,usersIds: $usersIds)';
}
