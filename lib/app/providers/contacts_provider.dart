import 'dart:developer';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/private_chat.dart';
import 'package:whatsapp_clone/storage/database/daos/private_chats_dao.dart';
import 'package:whatsapp_clone/storage/database/daos/users_dao.dart';
import 'package:whatsapp_clone/utils/extensions/my_extensions.dart';

import '../api/chats_api.dart';

/// its responsiple for user chats list.
/// like `(fetching,adding,deleting,updating) its data`
class ContactsProvider extends GetxController {
  final privateChatsList = RxList<Rx<PrivateChat>>();

  @override
  void onReady() async {
    super.onReady();

    /// (the source of users data is the database)
    /// listen to private chats changes in the database
    PrivateChatsDao.privateChatsStream().listen(databaseStreamListener);
  }

  databaseStreamListener(List<PrivateChat> newPrivateChatsList) {
    privateChatsList.value = newPrivateChatsList.convertToRxElements;

    for (var privateChat in privateChatsList) {
      privateChat.value.user.loadSync();
    }
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
  /// `Takes a map<userId,chatID>`\
  /// fetches the Private document then inserts it in the database
  Future<void> fetchMultipleNewContacts(Map<String, String> newContacts) async {
    log('*$newContacts*');
    final privates = await ChatsApi.fetchContacts(contacts: newContacts);
    final users = privates.map((e) => e.user.value!).toList();
    UsersDao.addAllUsers(users);
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

  /// `Takes a map<userId,chatID>`\
  /// deletes multiple Privates from the database
  Future<void> deleteMultipleContacts(Map<String, String> removedContacts) async {
    await PrivateChatsDao.deleteMultiplePrivateChatsById(removedContacts.values.toList());
  }
}
