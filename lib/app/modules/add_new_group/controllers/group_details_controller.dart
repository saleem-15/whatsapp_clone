import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:whatsapp_clone/app/api/chats_creater_api.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'package:whatsapp_clone/utils/ui/custom_snackbar.dart';

class GroupDetailsController extends GetxController {
  Rxn<ImageProvider> groupImage = Rxn<ImageProvider>(null);
  File? groupImageFile;

  late final List<User> selectedUsers;

  final groubNameController = TextEditingController();
  String get groupName => groubNameController.text.trim();

  List<String> get selectedUsersIds {
    final List<String> usersIds = [];

    for (User user in selectedUsers) {
      usersIds.add(user.uid);
    }
    return usersIds;
  }

  @override
  void onInit() {
    super.onInit();

    selectedUsers = Get.arguments;
  }

  void pickImage() async {
    XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedImage == null) {
      return;
    }

    groupImageFile = File(pickedImage.path);

    groupImage.value = FileImage(groupImageFile!);
  }

  Future<void> onFABPressed() async {
    /// check if there is a name
    if (groupName.isEmpty) {
      CustomSnackBar.showCustomSnackBar(
        message: "Enter the name of the group",
      );

      return;
    }

    await createGroupChat(
      groupName: groupName,
      groupMembersIds: selectedUsersIds,
      groupImage: groupImageFile,
    );

    Get.offAllNamed(Routes.HOME);
  }

  void onUserTilePressed(User user) {}
  @override
  String toString() =>
      'GroupDetailsController(groupImageFile: $groupImageFile, selectedUsers: $selectedUsers)';
}
