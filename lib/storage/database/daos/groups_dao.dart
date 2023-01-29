import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/chats/group_chat.dart';
import 'package:whatsapp_clone/storage/database/database.dart';

class GroupChatsDao {
  //------------------------adding-------------------------------
  static Future<void> addGroupChat(GroupChat groupChat) async {
    await isar.writeTxn(() async {
      await isar.groupChats.put(groupChat);
    });
  }

  static Future<void> addMultipleGroupChats(List<GroupChat> groupChats) async {
    await isar.writeTxn(() async {
      await isar.groupChats.putAll(groupChats);
    });
  }

  //--------------------------updating-------------------------------
  static Future<void> updateGroupChat(GroupChat groupChat) async {
    return addGroupChat(groupChat);
  }

  //--------------------------Delete-------------------------------
  static Future<void> deleteGroupChat(GroupChat groupChat) async {
    await isar.writeTxn(() async {
      final success = await isar.groupChats.delete(groupChat.databaseId);
      log('Chat deleted: $success');
    });
  }

  static Future<void> deleteGroupChatById(String groupChatId) async {
    await isar.writeTxn(() async {
      await isar.groupChats.filter().idEqualTo(groupChatId).deleteFirst();
    });
  }

  static Future<void> deleteMultipleGroupChatsById(List<String> groupChatId) async {
    for (var id in groupChatId) {
      await deleteGroupChatById(id);
    }
  }

  //--------------------------Get-------------------------------
  static Future<GroupChat?> getGroupChat(int id) async {
    return isar.groupChats.get(id);
  }

  static Future<List<GroupChat>> getAllGroupChats() async {
    return isar.groupChats.where().findAll();
  }

  static Future<List<String>> getAllGroupChatsIDs() async {
    final groups = await getAllGroupChats();

    /// return only the ids
    return groups.map((e) => e.id).toList();
  }

  static Stream<List<GroupChat>> groupChatsStream() {
    return isar.groupChats.where().watch();
  }
}
