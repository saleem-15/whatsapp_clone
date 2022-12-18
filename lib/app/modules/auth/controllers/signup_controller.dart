import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/routes/app_pages.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final phoneNumberFieledController = TextEditingController();

  String get phoneNumber => phoneNumberFieledController.text.trim();

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
    // final isSuccessfull = await signInService(phoneNumber, password);
    isWaitingResponse(false);

    // if (isSuccessfull) {
    //   // Get.offAllNamed(Routes.MY_APP);
    // }
  }

  String? phoneNumberFieldValidator(String? value) {
    if (phoneNumber.isBlank!) {
      return 'required';
    }

    return null;
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
}
