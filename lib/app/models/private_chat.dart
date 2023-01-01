// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:whatsapp_clone/app/models/chat_interface.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

class PrivateChat implements Chat {
  final User user;

  @override
  String id;

  @override
  late String name;

  @override
  late String? image;

  @override
  List<MessageInterface> messages = [];

  @override
  List<String> usersIds;

  PrivateChat({
    required this.id,
    required this.user,
    required this.usersIds,
  }) {
    name = user.name;
    image = user.imageUrl;
  }

  @override
  bool get isGroupChat => false;

  @override
  ImageProvider get imageProvider =>
      (image.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(image!)) as ImageProvider;
}
