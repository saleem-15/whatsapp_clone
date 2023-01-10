import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/auth_controller.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'package:whatsapp_clone/storage/files_manager.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

import '../components/logout_bottom_sheet.dart';

class SettingsScreenController extends GetxController {
  late final String userName;
  late final String userPhoneNumber;
  late Rx<ImageProvider> userImage;

  @override
  void onInit() {
    super.onInit();
    userName = MySharedPref.getUserName!;
    userPhoneNumber = MySharedPref.getUserPhoneNumber!;
    userImage = Rx(const AssetImage(Assets.default_user_image));
  }

    @override
  Future<void> onReady() async {
    super.onReady();

    File? image = await FileManager.getUserImage();
    if (image != null) {
      userImage.value = FileImage(image);
    }
  }

  void onQrIconPressed() {}


  void onAccountTilePressed() {
    Get.toNamed(Routes.ACCOUNT_SCREEN);
  }

  void onChatsTilePressed() {}

  void onNotificationTilePressed() {}

  void onSecurityTilePressed() {}

  void onHelpTilePressed() {
    Get.toNamed(Routes.HELP_SCREEN);
  }

  void onLogoutTilePressed() {
    Get.bottomSheet(LogoutBottomSheet(controller: this));
  }

  void onUserDataPressed() {
    Get.toNamed(Routes.PROFILE_SCREEN);
  }

  void onLogoutBottomSheetCancel() {
    Get.back();
  }

  void onLogoutBottomSheetConfrim() {
    Get.back();
    Get.find<AuthController>().logout();
  }
}
