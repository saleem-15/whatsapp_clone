import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';

class GroupChat extends Chat {
  GroupChat({
    required super.id,
    required super.name,
    super.image,
    required super.bio,
    required super.createdAt,
    required super.usersIds,
  }) : super(isGroupChat: true);

  @override
  ImageProvider get imageProvider =>
      (image.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(image!)) as ImageProvider;

  factory GroupChat.fromChatDoc(QueryDocumentSnapshot chatDoc) {
    return GroupChat(
      id: chatDoc.id,
      createdAt: (chatDoc['createdAt'] as Timestamp).toDate(),
      image: chatDoc['imageUrl'],
      name: chatDoc['groupName'],
      bio: chatDoc['bio'] ?? 'some randon bio',
      usersIds: List.castFrom<dynamic, String>(chatDoc['members'] as List),
    );
  }
}
