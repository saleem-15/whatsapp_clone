import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

class PrivateChat extends Chat {
  final User user;

  PrivateChat({
    required this.user,
    required super.id,
    required super.createdAt,
  }) : super(
          name: user.name,
          bio: user.about,
          image: user.imageUrl,
          usersIds: [user.uid, FirebaseAuth.instance.currentUser!.uid],
          isGroupChat: false,
        );

  @override
  ImageProvider get imageProvider =>
      (image.isBlank! ? const AssetImage(Assets.default_user_image) : NetworkImage(image!)) as ImageProvider;
}
