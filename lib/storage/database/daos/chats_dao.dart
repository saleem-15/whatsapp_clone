import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/storage/database/daos/groups_dao.dart';

import 'private_chats_dao.dart';

class ChatsDao {
  ChatsDao._();
  //------------------------adding-------------------------------
  // static Future<void> addChat(Chat Chat) async {
  //   await isar.writeTxn(() async {
  //     await isar.groups.put(Chat);
  //   });
  // }

  // static Future<void> addMultipleChats(List<Chat> Chats) async {
  //   await isar.writeTxn(() async {
  //     await isar.groups.putAll(Chats);
  //   });
  // }

  //--------------------------updating-------------------------------
  // static Future<void> updateChat(Chat Chat) async {
  //   return addChat(Chat);
  // }

  //--------------------------Delete-------------------------------
  // static Future<bool> deleteChat(Chat Chat) async {
  //   return await isar.writeTxn(() async {
  //     return await isar.groups.delete(Chat.databaseId);
  //   });
  // }

  // static Future<void> deleteChatById(String ChatId) async {
  //   await isar.writeTxn(() async {
  //     await isar.groups.filter().idEqualTo(ChatId).deleteFirst();
  //   });
  // }

  // static Future<void> deleteMultipleChatsById(List<String> ChatId) async {
  //   for (var id in ChatId) {
  //     await deleteChatById(id);
  //   }
  // }

  //--------------------------Get-------------------------------
  static Future<Chat?> getChatByMyId(String databaseId) async {
    return await GroupChatsDao.getGroupChatByMyID(databaseId) ?? await PrivateChatsDao.getPrivateChatByMyID(databaseId);
  }
  // static Future<Chat?> getChat(int chatId) async {
  //   return await GroupChatsDao.getGroupChat(chatId) ?? await PrivateChatsDao.getPrivateChat(chatId);
  // }

  // static Future<List<Chat>> getAllChats() async {
  //   return isar.groups.where().findAll();
  // }

  // static Future<List<String>> getAllChatsIDs() async {
  //   final groups = await getAllChats();

  //   /// return only the ids
  //   return groups.map((e) => e.id).toList();
  // }

  // static Stream<List<Chat>> ChatsStream() {
  //   return isar.groups.where().watch();
  // }
}
