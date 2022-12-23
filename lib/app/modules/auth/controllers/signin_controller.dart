import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/auth/services/auth_provider.dart';
import 'package:whatsapp_clone/app/routes/app_pages.dart';


class SigninController extends GetxController {
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

  Future<void> logIn() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    isWaitingResponse(true);
    final isSuccessfull = await AuthProvider.signInService('+$phoneNumber');
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
