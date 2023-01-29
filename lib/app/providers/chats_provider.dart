import 'dart:developer';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/storage/database/daos/groups_dao.dart';

import '../api/chats_api.dart';
import 'package:whatsapp_clone/utils/extensions/my_extensions.dart';

/// its responsiple for user chats list.
/// like `(fetching,adding,deleting,updating) its data`
class GroupChatsProvider extends GetxController {
  final groupsList = RxList<Rx<Chat>>();

  /// returns a `copy` of the chats list
  // RxList<Rx<Chat>> get chats => RxList.of(_chats);

  @override
  void onReady() async {
    super.onReady();

    /// (the source of users data is the database)
    /// listen to users changes in the database
    GroupChatsDao.groupChatsStream().listen((newGroupsList) {
      groupsList.value = newGroupsList.convertToRxElements;
    });
  }

  void addChat(Chat chat) {
    groupsList.add(chat.obs);
  }

  void addListOfChats(List<Chat> chat) {
    groupsList.addAll(chat.convertToRxElements);
  }

  // Future<void> _fetchChats() async {
  //   List<Chat> chatsList = await ChatsApi.getAllMyChats();
  //   log('number of chats: ${chatsList.length}------------------------------');
  //   chats.addAll(chatsList.convertToRxElements);
  // }

  Future<void> reFetchChats() async {
    List<Chat> chatsList = await ChatsApi.getAllMyChats();
    groupsList.replaceRange(0, groupsList.length, chatsList.convertToRxElements);
  }

  /// fetches the group document then inserts it in the database
  Future<void> fetchMultipleNewGroupChat(List<String> newGroupChatsIds) async {
    log('*${newGroupChatsIds.first}*');
    final groups = await ChatsApi.getGroupChatsByIds(groupChatIds: newGroupChatsIds);
    await GroupChatsDao.addMultipleGroupChats(groups);
  }

  /// `fetches` multiple group documents `then inserts them in the database`
  Future<void> fetchNewGroupChat(List<String> groupChatsIds) async {
    final group = await ChatsApi.getGroupChatsByIds(groupChatIds: groupChatsIds);
    await GroupChatsDao.addMultipleGroupChats(group);
  }

  /// deletes  group from the database
  Future<void> deleteGroupChat(String groupChatId) async {
    await GroupChatsDao.deleteGroupChatById(groupChatId);
  }

  /// deletes multiple groups from the database
  Future<void> deleteMultipleGroupChat(List<String> groupChatsId) async {
    await GroupChatsDao.deleteMultipleGroupChatsById(groupChatsId);
  }
}
