import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
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
    required this.isGroupChat,
  });

  String id;
  String name;
  String bio;
  DateTime createdAt;
  String? image;

  final bool isGroupChat;
  final List<String> usersIds;
  List<MessageInterface> messages = [];

  String get formattedCreationDate {
    return DateFormat.yMMMMd().format(createdAt);
  }

  ImageProvider get imageProvider =>
      (image.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(image!)) as ImageProvider;
}
