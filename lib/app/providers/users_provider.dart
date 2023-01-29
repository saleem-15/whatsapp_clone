import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/user_api.dart';
import 'package:whatsapp_clone/app/providers/chats_provider.dart';
import 'package:whatsapp_clone/storage/database/daos/users_dao.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';
import 'package:whatsapp_clone/utils/extensions/my_extensions.dart';

import '../models/user.dart';

class UsersProvider extends GetxController {
  late final User? me;
  final users = RxList<Rx<User>>();

  /// returns a `copy` of the users list
  // RxList<Rx<User>> get users => RxList.of(_users);

  @override
  void onInit() {
    me = MySharedPref.getUserData;
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    fetchUsersFromBackend();

    /// (the source of users data is the database)
    /// listen to users changes in the database
    UsersDao.usersStream().listen((newUsersList) {
      users.value = newUsersList.convertToRxElements;
      for (Rx<User> user in users) {
        user.printInfo();
      }
    });

    // users.addAll(usersList.convertToRxElements);
  }

  Future<void> fetchUsersFromBackend() async {
    List<User> usersList = await UserApi.getAllMyContacts();
    await UsersDao.addUsers(usersList);
  }

  /// it refetches users & chats.
  ///
  /// Becuase if you have a `new User` => you have a `new Chat`
  Future<void> reFetchUsersFromBackend() async {
    await fetchUsersFromBackend();
    await Get.find<GroupChatsProvider>().reFetchChats();
  }

  void addUser(User user) {
    UsersDao.addUser(user);
  }

  void deleteUser(User user) {
    UsersDao.deleteUser(user);
  }
}
