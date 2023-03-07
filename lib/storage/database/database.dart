import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/chats/group_chat.dart';
import 'package:whatsapp_clone/app/models/chats/private_chat.dart';
import 'package:whatsapp_clone/app/models/user.dart';

import 'models/message.dart';

late final Isar isar;
bool _isDatabaseInitiliazed = false;

class MyDataBase {
  MyDataBase._();

  static Future<void> openDatabase() async {
    /// if the database is already opened then nothing will happen
    if (_isDatabaseInitiliazed) {
      return;
    }

    _isDatabaseInitiliazed = true;
    isar = await Isar.open([
      UserSchema,
      PrivateChatSchema,
      GroupChatSchema,
      MessageDBSchema,
    ]);
  }

  /// Delets all data in the database
  static Future<void> clearDatabase() async {
    await isar.writeTxn(() async {
      await isar.groups.clear();
      await isar.privateChats.clear();
      await isar.messages.clear();
      await isar.users.clear();
    });
  }
}
