import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:whatsapp_clone/utils/constants/assets.dart';

import 'message.dart';

abstract class Chat {
  String id;

  String name;

  String? image;

  ImageProvider get imageProvider =>
      (image.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(image!)) as ImageProvider;

  final List<String> usersIds;

  List<Message> messages;

  bool get isGroupChat;

  Chat({
    required this.usersIds,
    required this.name,
    required this.image,
    required this.id,
    required this.messages,
  });
}
