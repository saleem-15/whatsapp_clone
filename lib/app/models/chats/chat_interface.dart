import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';
import 'package:intl/intl.dart';

import '../../../storage/database/models/message.dart';

abstract class Chat {
  Chat({
    required this.usersIds,
    required this.name,
    this.imageUrl,
    required this.bio,
    required this.createdAt,
    required this.id,
  });

  static const CHAT_TYPE_KEY = 'chatType';
  static const CHAT_MEMBERS_KEY = 'members';
  static const CREATED_AT_KEY = 'createdAt';

  ///its used when you dont want to pass parameters in constructor
  Chat.late();

  ///this id does not realy represents the user
  ///its only exist due to [Isar] database requirements
  Id databaseId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;

  late String name;
  late String bio;
  late DateTime createdAt;
  String? imageUrl;

  @ignore
  bool get isGroupChat;
  late final List<String> usersIds;

  final messages = IsarLinks<MessageDB>();

  @ignore
  String get formattedCreationDate {
    return DateFormat.yMMMMd().format(createdAt);
  }

  @ignore
  ImageProvider get imageProvider =>
      (imageUrl.isBlank! ? const AssetImage(Assets.DEFAULT_USER_IMAGE) : NetworkImage(imageUrl!))
          as ImageProvider;
}
