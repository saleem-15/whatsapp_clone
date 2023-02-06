import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

import '../../../api/auth_api.dart';

class SignupController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'sign up global key');

  final phoneNumberFieledController = TextEditingController();
  final userNameController = TextEditingController();

  String get phoneNumber => phoneNumberFieledController.text.trim();
  String get userName => userNameController.text.trim();

  RxBool isButtonDisable = true.obs;
  RxBool isWaitingResponse = false.obs;

  @override
  void onInit() {
    _autoDisableLoginButton();
    super.onInit();
  }

  Future<void> signUp() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    isWaitingResponse(true);
    await AuthApi.signUpService('+$phoneNumber', userName);
    isWaitingResponse(false);

    // if (isSuccessfull) {
    //   // Get.offAllNamed(Routes.MY_APP);
    // }
  }

  void goToLogIn() {
    Get.offNamed(Routes.SIGN_IN);
  }

  void _autoDisableLoginButton() {
    phoneNumberFieledController.addListener(() {
      if (phoneNumberFieledController.text.trim().isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
  }

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
}
