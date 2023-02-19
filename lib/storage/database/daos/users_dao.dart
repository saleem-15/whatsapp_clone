import 'dart:developer';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:isar/isar.dart';
import 'package:whatsapp_clone/app/providers/users_provider.dart';
import 'package:whatsapp_clone/storage/database/database.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

class UsersDao {
  UsersDao._();

  ///******************* Add/Update data *******************
  static Future<void> addUser(User user) async {
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  static Future<void> addAllUsers(List<User> users) async {
    await isar.writeTxn(() async {
      await isar.users.putAll(users);
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

  ///******************* Delete data *******************

  static Future<void> deleteUser(User user) async {
    await isar.writeTxn(() async {
      final success = await isar.users.delete(user.databaseId);
      log('user deleted: $success');
    });
  }

  ///******************* Fetch data *******************
  static Future<User?> getUserByMyID(String userId) async {
    return await isar.users.filter().uidEqualTo(userId).findFirst();
  }

  static Future<User?> getUser(int id) async {
    return isar.users.get(id);
  }

  static Future<List<User>> getAllUsers() async {
    return isar.users.where().findAll();
  }

  static Stream<List<User>> usersStream() {
    return isar.users.where().watch(fireImmediately: true);
  }

  ///******************* Operations on the user *******************
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

  /// phone number cannot be updated,
  /// Because the its used as the database id (which cannot change)
  ///
  /// you must set `updateImage` to `true` if u want to update the image,
  /// so the database can know if the updated image is `null` or u just dont want
  /// to update the image
  static Future<void> updateMyData({
    String? name,
    String? bio,
    String? imageUrl,
    bool updateImage = false,
  }) async {
    final user = await getMyData();

    assert(
      user != null,
      'The user does not exists yet !! (you didn\'t store the user yet)',
    );

    await addUser(
      User.normal(
        uid: Get.find<UsersProvider>().me.value.uid,
        bio: bio ?? user!.bio,
        name: name ?? user!.name,
        imageUrl: updateImage ? imageUrl : user!.imageUrl,
        phoneNumber: MySharedPref.getUserPhoneNumber!,
        lastUpdated: DateTime.now(),
      ),
    );
  }

  static Future<void> setMyData(User user) async {
    MySharedPref.setUserPhoneNumber(user.phoneNumber);
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  static Future<User?> getMyData() async {
    /// phone number is used as the database id
    final userPhone = int.parse(MySharedPref.getUserPhoneNumber!);
    return getUser(userPhone);
  }

  static Stream<User?> myDataStream() {
    /// phone number is used as the database id
    final userPhone = int.parse(MySharedPref.getUserPhoneNumber!);

    return isar.users.watchObject(userPhone);
  }
}
