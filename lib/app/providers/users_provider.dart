import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/user_api.dart';
import 'package:whatsapp_clone/storage/database/daos/users_dao.dart';
import 'package:whatsapp_clone/utils/extensions/my_extensions.dart';

import '../models/user.dart';

class UsersProvider extends GetxController {
  late final Rx<User> me;

  // static late Rx<ImageProvider> userImage;

  final users = RxList<Rx<User>>();

  /// returns a `copy` of the users list
  // RxList<Rx<User>> get users => RxList.of(_users);

  Future<void> init() async {
    me = (await UsersDao.getMyData())!.obs;
    return;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    // me = (await UsersDao.getMyData())!.obs;

    UsersDao.myDataStream().listen((user) {
      /// (user = null) only when the user is logging out
      if (user != null) {
        me.value = user;
      }
    });

    /// (the source of users data is the database)
    /// listen to users changes in the database
    UsersDao.usersStream().listen((newUsersList) {
      users.value = newUsersList.convertToRxElements;
      // for (Rx<User> user in users) {
      //   user.printInfo();
      // }
    });

    // users.addAll(usersList.convertToRxElements);
  }

  Future<void> fetchUsersFromBackend(List<String> usersIDs) async {
    List<User> usersList = await UserApi.getAllMyContacts();

    await UsersDao.addUsers(usersList);
  }

  /// it refetches users & chats.
  ///
  /// Becuase if you have a `new User` => you have a `new Chat`
  // Future<void> reFetchUsersFromBackend() async {
  //   await fetchUsersFromBackend();
  //   await Get.find<GroupChatsProvider>().reFetchChats();
  // }

  // void addUser(User user) {
  //   UsersDao.addUser(user);
  // }

  // void deleteUser(User user) {
  //   UsersDao.deleteUser(user);
  // }
}
