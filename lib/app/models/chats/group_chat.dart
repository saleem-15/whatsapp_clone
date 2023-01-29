import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';

part 'group_chat.g.dart';

@collection
class GroupChat extends Chat {
  GroupChat({
    required super.id,
    required super.name,
    super.image,
    required super.bio,
    required super.createdAt,
    required super.usersIds,
  });

  factory GroupChat.fromChatDoc(QueryDocumentSnapshot chatDoc) {
    assert(chatDoc.exists);
    return GroupChat(
      id: chatDoc.id,
      createdAt: (chatDoc['createdAt'] as Timestamp).toDate(),
      image: chatDoc['imageUrl'],
      name: chatDoc['groupName'],
      bio: chatDoc['bio'] ?? 'some randon bio',
      usersIds: List.castFrom<dynamic, String>(chatDoc['members'] as List),
    );
  }

  ///this id does not realy represents the user
  ///its only exist due to [Isar] database requirements
  Id databaseId = Isar.autoIncrement;

  @override
  ImageProvider get imageProvider =>
      (image.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(image!)) as ImageProvider;

  @ignore
  @override
  bool get isGroupChat => true;
}
