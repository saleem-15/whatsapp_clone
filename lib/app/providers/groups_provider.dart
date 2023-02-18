import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/group_chat.dart';
import 'package:whatsapp_clone/storage/database/daos/groups_dao.dart';

import '../api/chats_api.dart';
import 'package:whatsapp_clone/utils/extensions/my_extensions.dart';

import '../api/user_api.dart';
import '../models/user.dart';

/// its responsiple for user chats list.
/// like `(fetching,adding,deleting,updating) its data`
class GroupChatsProvider extends GetxController {
  final groupsList = RxList<Rx<GroupChat>>();

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

  /// fetches the group document then inserts it in the database
  Future<void> fetchNewGroups(List<String> newGroupIds) async {
    final groups = await ChatsApi.getGroupChatsByIds(groupChatIds: newGroupIds);

    for (var group in groups) {
      List<User> usersList = await UserApi.fetchUsers(group.usersIds);
      group.users.addAll(usersList);
    }
    await GroupChatsDao.addMultipleGroupChats(groups);
  }

  // /// `fetches` multiple group documents `then inserts them in the database`
  // Future<void> fetchNewGroupChat(List<String> groupChatsIds) async {
  //   final group = await ChatsApi.getGroupChatsByIds(groupChatIds: groupChatsIds);
  //   await GroupChatsDao.addMultipleGroupChats(group);
  // }

  /// deletes  group from the database
  Future<void> deleteGroupChat(String groupChatId) async {
    await GroupChatsDao.deleteGroupChatById(groupChatId);
  }

  /// deletes multiple groups from the database
  Future<void> deleteMultipleGroupChat(List<String> groupChatsId) async {
    await GroupChatsDao.deleteMultipleGroupChatsById(groupChatsId);
  }
}
