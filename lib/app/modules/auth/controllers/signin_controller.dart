import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/auth_api.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

class SigninController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final phoneNumberFieledController = TextEditingController();

  String get phoneNumber => phoneNumberFieledController.text.trim();

  RxBool isButtonDisable = true.obs;
  RxBool isWaitingResponse = false.obs;

  @override
  void onInit() {
    _autoDisableLoginButton();
    super.onInit();
  }

  Future<void> logIn() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    isWaitingResponse(true);
    await AuthApi.signInService('+$phoneNumber');
    isWaitingResponse(false);
  }

  String? phoneNumberFieldValidator(String? value) {
    if (phoneNumber.isBlank!) {
      return 'required';
    }

    return null;
  }

  void goToSignup() {
    Get.offNamed(Routes.SIGNUP);
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
