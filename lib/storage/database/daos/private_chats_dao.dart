import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/chats/private_chat.dart';
import 'package:whatsapp_clone/storage/database/database.dart';

class PrivateChatsDao {
  PrivateChatsDao._();

  //------------------------adding-------------------------------

  static Future<void> addPrivateChat(PrivateChat privateChat) async {
    await isar.writeTxn(() async {
      await isar.privateChats.put(privateChat);
      await privateChat.user.save();
      await privateChat.messages.save();
    });
  }

  static Future<void> addMultiplePrivateChats(List<PrivateChat> privateChats) async {
    await isar.writeTxn(() async {
      await isar.privateChats.putAll(privateChats);

      for (final chat in privateChats) {
        await chat.user.save();
        await chat.messages.save();
      }
    });
  }
  //--------------------------updating-------------------------------

  static Future<void> updatePrivateChat(PrivateChat privateChat) async {
    return addPrivateChat(privateChat);
  }

  static Future<void> updateMultiplePrivateChat(List<PrivateChat> privateChats) async {
    return addMultiplePrivateChats(privateChats);
  }

  //--------------------------Delete-------------------------------

  ///delete chat and all of its messages
  static Future<void> deletePrivateChat(PrivateChat privateChat) async {
    await isar.writeTxn(() async {
      await isar.privateChats.delete(privateChat.databaseId);
    });
  }

  static Future<void> deletePrivateChatById(String privateChatId) async {
    await isar.writeTxn(() async {
      await isar.privateChats.filter().idEqualTo(privateChatId).deleteFirst();
    });
  }

  static Future<void> deleteMultiplePrivateChatsById(List<String> privateChatsIds) async {
    for (var id in privateChatsIds) {
      await deletePrivateChatById(id);
    }
  }

  //--------------------------Get-------------------------------
  static Future<PrivateChat?> getPrivateChat(int databaseId) async {
    return isar.privateChats.get(databaseId);
  }

  static Future<PrivateChat?> getPrivateChatByMyID(String id) async {
    return isar.privateChats.filter().idEqualTo(id).findFirst();
  }

  static Future<List<PrivateChat>> getAllPrivateChats() async {
    return isar.privateChats.where().findAll();
  }

  static Stream<List<PrivateChat>> privateChatsStream() {
    /// fireImmediately means that the results will be sent from the start
    /// if (fireImmediately = false) => the results will be sent when a change
    /// occurs to the (groups collection)
    return isar.privateChats.where().watch(fireImmediately: true);
  }

  static Future<List<String>> getAllPrivateChatsIDs() async {
    final privateChats = await getAllPrivateChats();

    /// return only the ids
    return privateChats.map((e) => e.id).toList();
  }
}
