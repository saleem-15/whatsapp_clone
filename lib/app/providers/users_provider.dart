import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/user_provider.dart';
import 'package:whatsapp_clone/utils/extensions/my_extensions.dart';

import '../models/user.dart';

class UserController extends GetxController {
  final users = RxList<Rx<User>>();

  /// returns a ```copy``` of the users list
  // RxList<Rx<User>> get users => RxList.of(_users);

  @override
  Future<void> onReady() async {
    super.onReady();
    List<User> usersList = await UserProvider.getAllMyContacts();

    users.addAll(usersList.convertToRxElements);
  }

  void addUser(User user) {
    users.add(user.obs);
  }
}
