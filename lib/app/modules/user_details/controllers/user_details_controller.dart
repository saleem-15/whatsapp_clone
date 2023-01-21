import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/models/chats/private_chat.dart';

class ChatDetailsController extends GetxController {
  late Chat chat;

  RxBool isNotificationsOnn = false.obs;
  bool get isGroupChat => chat.isGroupChat;

  ImageProvider get chatImage => chat.imageProvider;

  // List<User> get groupUsers => (chat as GroupChat).

  /// used only if chat is [PrivateChat]
  String get phoneNumber => (chat as PrivateChat).user.phoneNumber;

  @override
  void onInit() {
    super.onInit();
    chat = Get.arguments;
  }
}
