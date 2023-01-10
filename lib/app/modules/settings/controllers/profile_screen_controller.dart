import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import '../user_provider.dart';

class ProfileScreenController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// text fields controllers & text getters -----------------
  final nameController = TextEditingController();
  final aboutController = TextEditingController();
  final phoneNumberFieledController = TextEditingController();

  String get name => nameController.text.trim();
  String get about => aboutController.text.trim();
  String get phoneNumber => phoneNumberFieledController.text.trim();
  //---------------------------------------------------------

  RxBool isButtonDisable = true.obs;
  RxBool isWaitingResponse = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    nameController.text = MySharedPref.getUserName!;
    phoneNumberFieledController.text = MySharedPref.getUserPhoneNumber!;

    _autoDisableLoginButton();
  }

  void _autoDisableLoginButton() {
    phoneNumberFieledController.addListener(() {
      if (phoneNumber.isEmpty || name.isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
    nameController.addListener(() {
      if (phoneNumber.isEmpty || name.isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
  }

  Future<void> onUpdateButtonPressed() async {
    User myUpdatedInfo = MySharedPref.getUserData!
      ..name = name
      ..about = about;

    isWaitingResponse(true);
    await UserProvider.updateUserProfile(myUpdatedInfo);
    isWaitingResponse(false);
  }

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

}
