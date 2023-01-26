import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';

import '../api/chats_provider.dart';
import 'package:whatsapp_clone/utils/extensions/my_extensions.dart';

class ChatsController extends GetxController {
  final chats = RxList<Rx<Chat>>();

  /// returns a ```copy``` of the chats list
  // RxList<Rx<Chat>> get chats => RxList.of(_chats);

  @override
  void onReady() async {
    super.onReady();

    _fetchChats();
  }

  void addChat(Chat chat) {
    chats.add(chat.obs);
  }

  Future<void> _fetchChats() async {
    List<Chat> chatsList = await ChatsProvider.getAllMyChats();
    chats.addAll(chatsList.convertToRxElements);
  }

  Future<void> reFetchChats() async {
    List<Chat> chatsList = await ChatsProvider.getAllMyChats();
    chats.replaceRange(0, chats.length, chatsList.convertToRxElements);
  }
}
