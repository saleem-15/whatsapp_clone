import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';
import 'package:intl/intl.dart';

abstract class Chat {
  Chat({
    required this.usersIds,
    required this.name,
    this.image,
    required this.bio,
    required this.createdAt,
    required this.id,
  });

  ///its used when you want you dont want to pass parameters in constructor
  Chat.late();

  late String id;
  late String name;
  late String bio;
  late DateTime createdAt;
  String? image;

  bool get isGroupChat;
  late final List<String> usersIds;

  @ignore
  List<MessageInterface> messages = [];

  String get formattedCreationDate {
    return DateFormat.yMMMMd().format(createdAt);
  }

  @ignore
  ImageProvider get imageProvider =>
      (image.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(image!)) as ImageProvider;
}
