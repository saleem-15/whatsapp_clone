import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'package:whatsapp_clone/fcm_helper.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  RxBool isSearchMode = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await FcmHelper.setupInteractedMessage();

  }

  void onSearchIconButtonPressed() {
    isSearchMode(true);
    searchFocus.requestFocus();
  }

  void onCloseSearchIconPressed() {
    isSearchMode(false);
    searchController.clear();
  }

  /// this method is called when the user selects `settings` option
  ///  from the pop up menu that appears when clicking `more icon button`
  Future<void> onSettingsOptionSelected() async {
    /// this line makes sure that the page will open
    /// if its deleted the page will not open
    /// I searched on the internet about it and this is what i found:
    /// "I think this happens because flutter is closing the PopupMenuButton
    /// automatically and because navigation happens to fast, it closes the new route instead of the menuButton."
    await Future.delayed(const Duration(milliseconds: 1));

    Get.toNamed(Routes.SETTINGS_SCREEN, preventDuplicates: false);
  }

  Future<void> onNewGroupOptionSelected() async {
    /// go to [onSettingsOptionSelected] method to understand why this line exists
    await Future.delayed(const Duration(milliseconds: 1));
    Get.toNamed(Routes.SELECT_NEW_GROUP_MEMBERS);
  }
}
