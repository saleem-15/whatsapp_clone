import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

abstract class Chat {
  Chat({
    required this.usersIds,
    required this.name,
    this.image,
    required this.id,
    required this.isGroupChat,
  });

  String id;
  String name;
  String? image;

  final bool isGroupChat;
  final List<String> usersIds;
  List<MessageInterface> messages = [];

  ImageProvider get imageProvider =>
      (image.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(image!)) as ImageProvider;
}
