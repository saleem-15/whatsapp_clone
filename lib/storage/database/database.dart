import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/models/chats/group_chat.dart';
import 'package:whatsapp_clone/app/models/chats/private_chat.dart';
import 'package:whatsapp_clone/app/models/user.dart';

import 'models/message.dart';

late final Isar isar;

/// FNV-1a 64bit hash algorithm optimized for Dart Strings\
/// it's recommended by the isar team to be used for converting
/// a `String id` to `int` becuase isar database only uses int id
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}

class MyDataBase {
  MyDataBase._();

  static Future<void> openDatabase() async {
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
      await isar.users.clear();
      await isar.privateChats.clear();
      await isar.groups.clear();
      await isar.messages.clear();
    });

    

  }
}
