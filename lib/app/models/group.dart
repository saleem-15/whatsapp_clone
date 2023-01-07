import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/chat_interface.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';

@Collection()
class GroupChat implements Chat {

  ///this id does not realy represents the user,
  ///its only exist due to [Isar] database requirements
  Id id = Isar.autoIncrement;

  @override
  String chatId;

  @override
  String name;

  @override
  String? image;

  @override
  List<String> usersIds;

  @override
  List<MessageInterface> messages = [];

  @override
  bool get isGroupChat => true;

  GroupChat({
    required this.chatId,
    required this.image,
    required this.name,
    required this.usersIds,
  });

  // @override
  factory GroupChat.fromChatDoc(QueryDocumentSnapshot chatDoc) {
    return GroupChat(
      chatId: chatDoc.id,
      image: chatDoc['imageUrl'],
      name: chatDoc['groupName'],
      usersIds: List.castFrom<dynamic, String>(chatDoc['members'] as List),
    );
  }

  @override
  ImageProvider get imageProvider =>
      (image.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(image!)) as ImageProvider;
}

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/chat_interface.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';

@collection
class GroupChat extends Chat {
  // @override
  // String id;

  // @override
  // String name;

  // @override
  // String? image;

  // @override
  // List<String> usersIds;

  // @override
  // List<MessageInterface> messages = [];

  // @override
  // bool get isGroupChat => true;

  @override
  bool get isGroupChat => true;

  GroupChat({
    required super.id,
    required super.name,
    required super.usersIds,
    required super.image,
     super.messages,
// required    super.
    // required this.image,
    // required this.name,
    // required this.usersIds,
  });

  // @override
  factory GroupChat.fromChatDoc(QueryDocumentSnapshot chatDoc) {
    return GroupChat(
      id: chatDoc.id,
      image: chatDoc['imageUrl'],
      name: chatDoc['groupName'],
      usersIds: List.castFrom<dynamic, String>(chatDoc['members'] as List),
    );
  }

  @override
  ImageProvider get imageProvider =>
      (image.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(image!)) as ImageProvider;
}

*/
