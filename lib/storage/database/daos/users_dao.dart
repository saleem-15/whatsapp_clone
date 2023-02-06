import 'dart:developer';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/providers/users_provider.dart';
import 'package:whatsapp_clone/storage/database/database.dart';

class UsersDao {
  static Future<void> addUser(User user) async {
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  static Future<User?> getUserByMyID(String userId) async {
    return await isar.users.filter().uidEqualTo(userId).findFirst();
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

  static Future<void> storeMyData({
    required String id,
    required String name,
    String? image,
    required String phone,
  }) async {
    await addUser(User.normal(
      uid: id,
      bio: '',
      name: name,
      imageUrl: image,
      phoneNumber: phone,
      lastUpdated: DateTime.now(),
    ));
  }

  /// Updating phone number will cause problems\
  /// Because the its used as the database id (which cannot change)
  static Future<void> updateMyData({
    required String name,
    required String phone,
    required String bio,
    required String imageUrl,
  }) async {
    await addUser(
      User.normal(
        uid: Get.find<UsersProvider>().me!.uid,
        bio: bio,
        name: name,
        imageUrl: imageUrl,
        phoneNumber: phone,
        lastUpdated: DateTime.now(),
      ),
    );
  }
}
