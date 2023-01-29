import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/chats/private_chat.dart';
import 'package:whatsapp_clone/storage/database/database.dart';

class PrivateChatsDao {
  static Future<void> addPrivateChat(PrivateChat privateChat) async {
    await isar.writeTxn(() async {
      await isar.privateChats.put(privateChat);
      await privateChat.user.save();
    });
  }

  static Future<void> updatePrivateChat(PrivateChat privateChat) async {
    return addPrivateChat(privateChat);
  }

  static Future<void> deletePrivateChat(PrivateChat privateChat) async {
    await isar.writeTxn(() async {
      final success = await isar.privateChats.delete(privateChat.databaseId);
      log('Chat deleted: $success');
    });
  }

  static Future<PrivateChat?> getPrivateChat(int id) async {
    return isar.privateChats.get(id);
  }

  static Future<List<PrivateChat>> getAllPrivateChats() async {
    return isar.privateChats.where().findAll();
  }

  static Stream<List<PrivateChat>> privateChatsStream() {
    return isar.privateChats.where().watch();
  }
}
