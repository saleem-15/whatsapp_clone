import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/auth_api.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'package:country_picker/country_picker.dart';

class SignupController extends GetxController {
  var formKey = GlobalKey<FormState>(debugLabel: 'sign up global key');

  final phoneNumberFieldController = TextEditingController();
  final userNameController = TextEditingController();

  /// default country is palestine
  final phoneNumberCountry = Rx<Country>(CountryService().findByCode('Ps')!);

  String? phoneNumber;
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
    log(phoneNumber!);
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
    phoneNumberFieldController.addListener(() {
      if (phoneNumberFieldController.text.trim().isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
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

  void onPhoneNumberChanged(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }
}
