import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/app/providers/users_provider.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

class SelectNewGroupMembersController extends GetxController {
  //this list containes the indices of the selected people
  // for example if (selectedPeople = [2,3]) ==> then ==> contacts[2] ,contacts[3] are selected

  final selectedPeopleIndices = <int>[].obs;
  RxList<Rx<User>> get myContacts => Get.find<UsersProvider>().users;

  List<User> get selectedUsers {
    List<User> users = [];

    for (int userIndex in selectedPeopleIndices) {
      users.add(myContacts[userIndex].value);
    }

    return users;
  }

  void onUserTilePressed(int index) {
    if (!selectedPeopleIndices.contains(index)) {
      selectedPeopleIndices.add(index);
    } else {
      selectedPeopleIndices.remove(index);
    }
  }

  void onFloatingButtonPressed() {
    final selected = <User>[];
    for (var i = 0; i < selectedPeopleIndices.length; i++) {
      selected.add(myContacts[selectedPeopleIndices[i]].value);
    }

    Get.toNamed(
      Routes.NEW_GROUP_DETAILS,
      arguments: selectedUsers,
    );
  }
}
