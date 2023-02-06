import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/chats/group_chat.dart';
import 'package:whatsapp_clone/storage/database/database.dart';

class GroupChatsDao {
  GroupChatsDao._();
  //------------------------adding-------------------------------
  static Future<void> addGroupChat(GroupChat groupChat) async {
    await isar.writeTxn(() async {
      await isar.groups.put(groupChat);
    });
  }

  static Future<void> addMultipleGroupChats(List<GroupChat> groupChats) async {
    await isar.writeTxn(() async {
      await isar.groups.putAll(groupChats);
    });
  }

  //--------------------------updating-------------------------------
  static Future<void> updateGroupChat(GroupChat groupChat) async {
    return addGroupChat(groupChat);
  }

  //--------------------------Delete-------------------------------
  static Future<bool> deleteGroupChat(GroupChat groupChat) async {
    return await isar.writeTxn(() async {
      return await isar.groups.delete(groupChat.databaseId);
    });
  }

  static Future<void> deleteGroupChatById(String groupChatId) async {
    await isar.writeTxn(() async {
      await isar.groups.filter().idEqualTo(groupChatId).deleteFirst();
    });
  }

  static Future<void> deleteMultipleGroupChatsById(List<String> groupChatId) async {
    for (var id in groupChatId) {
      await deleteGroupChatById(id);
    }
  }

  //--------------------------Get-------------------------------
  static Future<GroupChat?> getGroupChat(int databaseId) async {
    return isar.groups.get(databaseId);
  }

  static Future<GroupChat?> getGroupChatByMyID(String id) async {
    return isar.groups.filter().idEqualTo(id).findFirst();
  }

  static Future<List<GroupChat>> getAllGroupChats() async {
    return isar.groups.where().findAll();
  }

  static Future<List<String>> getAllGroupChatsIDs() async {
    final groups = await getAllGroupChats();

    /// return only the ids
    return groups.map((e) => e.id).toList();
  }

  static Stream<List<GroupChat>> groupChatsStream() {
    /// fireImmediately means that the results will be sent from the start
    /// if (fireImmediately = false) => the results will be sent when a change
    /// occurs to the (groups collection)
    return isar.groups.where().watch(fireImmediately: true);
  }
}
