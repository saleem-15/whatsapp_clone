import 'dart:developer';

import 'package:whatsapp_clone/app/models/user.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/storage/database/database.dart';

class UsersDao {
  static Future<void> addUser(User user) async {
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  /// if there is a user, that already exist then it will be updated
  static Future<void> addUsers(List<User> user) async {
    await isar.writeTxn(() async {
      await isar.users.putAll(user);
    });
  }

  static Future<void> updateUser(User user) async {
    return addUser(user);
  }

  static Future<void> deleteUser(User user) async {
    await isar.writeTxn(() async {
      final success = await isar.users.delete(user.databaseId);
      log('user deleted: $success');
    });
  }

  static Future<User?> getUser(int id) async {
    return isar.users.get(id);
  }

  static Future<List<User>> getAllUsers() async {
    return isar.users.where().findAll();
  }

  static Stream<List<User>> usersStream() {
    return isar.users.where().watch();
  }
}
