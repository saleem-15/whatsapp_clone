import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/modules/user_chats/controllers/chats_view_controller.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  RxBool isSearchMode = false.obs;

  RxList<Rx<Chat>> get chatsList => Get.find<ChatsViewController>().chatsList;
  List<Rx<Chat>> get allChatsList => Get.find<ChatsViewController>().allChatsList;

  void onMorePressed() {
    Get.toNamed(Routes.SETTINGS_SCREEN);
  }

  void onSearchIconButtonPressed() {
    isSearchMode(true);
    searchFocus.requestFocus();
  }

  void onCloseSearchIconPressed() {
    isSearchMode(false);
    chatsList.replaceRange(0, chatsList.length, allChatsList);
  }

  void search() {
    final text = searchController.text.trim().toLowerCase();
    final results = allChatsList.where((chat) => chat.value.name.startsWith(text));

    chatsList.replaceRange(0, chatsList.length, results);
  }
}
