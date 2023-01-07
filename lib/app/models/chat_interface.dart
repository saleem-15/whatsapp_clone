import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

abstract class Chat {
  String chatId;

  String name;

  String? image;

  ImageProvider get imageProvider =>
      (image.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(image!)) as ImageProvider;

  final List<String> usersIds;

  List<MessageInterface> messages;

  bool get isGroupChat;

  Chat({
    required this.usersIds,
    required this.name,
    required this.image,
    required this.chatId,
    required this.messages,
  });
}
