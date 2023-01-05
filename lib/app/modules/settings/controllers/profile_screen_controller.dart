import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

import '../components/change_avatar_bottom_sheet.dart';

class ProfileScreenController extends GetxController {
  late ImageProvider userImage;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// text fields controllers & text getters -----------------
  final userNameController = TextEditingController();
  final aboutController = TextEditingController();
  final phoneNumberFieledController = TextEditingController();

  String get userName => userNameController.text.trim();
  String get about => aboutController.text.trim();
  String get phoneNumber => phoneNumberFieledController.text.trim();
  //---------------------------------------------------------

  RxBool isButtonDisable = true.obs;
  RxBool isWaitingResponse = false.obs;

  @override
  void onInit() {
    super.onInit();

    userNameController.text = MySharedPref.getUserName!;
    phoneNumberFieledController.text = MySharedPref.getUserPhoneNumber!;
    userImage = const AssetImage(Assets.default_user_image);
    _autoDisableLoginButton();
  }

  void _autoDisableLoginButton() {
    phoneNumberFieledController.addListener(() {
      if (phoneNumber.isEmpty || userName.isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
    userNameController.addListener(() {
      if (phoneNumber.isEmpty || userName.isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
  }

  void onEditProfileImagePressed() {
    Get.bottomSheet(
      ChangeUserAvatarBottomSheet(
        chooseUserImageFromCamera: chooseUserImageFromCamera,
        chooseUserImageFromGallery: chooseUserImageFromGallery,
      ),
    );
  }

  void onUpdateButtonPressed() {}

  /// ------------- Text Fields Validators -----------------
  String? phoneNumberFieldValidator(String? value) {
    if (value.isBlank!) {
      return 'required';
    }

    if (!value!.isPhoneNumber) {
      return 'Invalid phone number';
    }

    return null;
  }

  String? userNameValidator(String? value) {
    if (value.isBlank!) {
      return 'required';
    }

    if (!GetUtils.isUsername(value!)) {
      return 'Invalid User Name';
    }

    return null;
  }

  String? aboutValidator(String? value) {
    /// there is not any restrictions on the about
    /// it can be anything (also can be null)
    return null;
  }

  /// ------------------------------------------------------

  void chooseUserImageFromCamera() {}
  void chooseUserImageFromGallery() {}
}
