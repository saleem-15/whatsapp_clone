import 'dart:developer';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/private_chat.dart';
import 'package:whatsapp_clone/storage/database/daos/private_chats_dao.dart';
import 'package:whatsapp_clone/utils/extensions/my_extensions.dart';

import '../api/chats_api.dart';

/// its responsiple for user chats list.
/// like `(fetching,adding,deleting,updating) its data`
class PrivateChatsProvider extends GetxController {
  final privateChatsList = RxList<Rx<PrivateChat>>();

  @override
  void onReady() async {
    super.onReady();

    /// (the source of users data is the database)
    /// listen to private chats changes in the database
    PrivateChatsDao.privateChatsStream().listen(
      (event) => x(event),
    );
  }

  x(List<PrivateChat> newPrivateChatsList) {
    privateChatsList.value = newPrivateChatsList.convertToRxElements;

    log('Private chats list length: ${privateChatsList.length}********************');
  }

  // void addChat(PrivateChat chat) {
  //   privateChatsList.add(chat.obs);
  // }

  // void addListOfChats(List<PrivateChat> chat) {
  //   privateChatsList.addAll(chat.convertToRxElements);
  // }

  // Future<void> reFetchChats() async {
  //   List<Chat> chatsList = await ChatsApi.getAllMyChats();
  //   privateChatsList.replaceRange(0, privateChatsList.length, chatsList.convertToRxElements);
  // }

  /// fetches the Private document then inserts it in the database
  Future<void> fetchMultipleNewPrivateChat(List<String> newPrivateChatsIds) async {
    log('*${newPrivateChatsIds.first}*');
    final privates = await ChatsApi.getPrivateChatsByIds(privateChatIds: newPrivateChatsIds);
    await PrivateChatsDao.addMultiplePrivateChats(privates);
  }

  /// `fetches` multiple Private documents `then inserts them in the database`
  Future<void> fetchNewPrivateChat(List<String> privateChatsIds) async {
    final private = await ChatsApi.getPrivateChatsByIds(privateChatIds: privateChatsIds);
    await PrivateChatsDao.addMultiplePrivateChats(private);
  }

  /// deletes  Private from the database
  Future<void> deletePrivateChat(String privateChatId) async {
    await PrivateChatsDao.deletePrivateChatById(privateChatId);
  }

  /// deletes multiple Privates from the database
  Future<void> deleteMultiplePrivateChats(List<String> privateChatsId) async {
    await PrivateChatsDao.deleteMultiplePrivateChatsById(privateChatsId);
  }
}
