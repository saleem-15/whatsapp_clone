import 'package:get/get.dart';

import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/modules/home/controllers/home_controller.dart';
import 'package:whatsapp_clone/app/providers/chats_provider.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

class ChatsViewController extends GetxController {
  ///this is list holds all chats
  Rx<List<Rx<Chat>>> get chatsList => Get.find<ChatsProvider>().chatsList;
  RxBool get isSearchMode => Get.find<HomeController>().isSearchMode;
  final searchController = Get.find<HomeController>().searchController;

  @override
  void onInit() {
    super.onInit();

    ever(Get.find<ChatsProvider>().chatsList, (callback) {
      update(['chats listView']);
    });
    ever(isSearchMode, (callback) {
      // log('isSearchMode has changed ===>$callback**************************************');

      update(['chats listView']);
    });
  }

  updateList() {
    update(['chats listView']);
  }

  void onChatTilePressed(Chat chat) {
    Get.toNamed(
      Routes.CHAT_SCREEN,
      arguments: chat,
    );
  }

  /// its responsible for filtiring chats
  List<Rx<Chat>> filter(List<Rx<Chat>> chats) {
    final searchText = Get.find<HomeController>().searchController.text.trim().toLowerCase();

    if (searchText.isEmpty) {
      return chats;
    }
    List<Rx<Chat>> filteredList = [];

    for (int i = 0; i < chats.length; i++) {
      bool isResult = chats[i].value.name.toLowerCase().startsWith(searchText);

      if (isResult) {
        filteredList.add(chats[i]);
      }
    }
    return filteredList;
  }
}
