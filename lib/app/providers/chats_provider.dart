import 'dart:developer';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/models/chats/group_chat.dart';
import 'package:whatsapp_clone/app/models/chats/private_chat.dart';
import 'package:whatsapp_clone/app/providers/groups_provider.dart';
import 'package:whatsapp_clone/app/providers/private_chats_provider.dart';

import '../modules/user_chats/controllers/chats_view_controller.dart';

/// its responsiple for user chats list.
/// like `(fetching,adding,deleting,updating) its data`
class ChatsProvider extends GetxController {
  final Rx<List<Rx<Chat>>> allChatsList = Rx(<Rx<Chat>>[]);

  RxList<Rx<GroupChat>> get groups => Get.find<GroupChatsProvider>().groupsList;
  RxList<Rx<PrivateChat>> get privateChats => Get.find<PrivateChatsProvider>().privateChatsList;

  @override
  void onReady() async {
    super.onReady();

    ever(groups, (_) => _reConstructChatsList());
    ever(privateChats, (_) => _reConstructChatsList());

    ever(allChatsList, (callback) {
      log('******************chats list has been updated***************');
      Get.find<ChatsViewController>().updateList();
    });
  }

  void _reConstructChatsList() {
    allChatsList.value = [...groups, ...privateChats];
    log('********************* All Chats *********************');
    log('All chats list length: ${allChatsList.value.length}');
    log('Group chats list length: ${groups.length}');
    log('Private chats list length: ${privateChats.length}');

    for (var chat in allChatsList.value) {
      chat.printInfo();
    }
    log('********************* All Chats *********************');
  }
}
