import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/auth_api.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

class SigninController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final phoneNumberFieldController = TextEditingController();

  String? phoneNumber;

  RxBool isButtonDisable = true.obs;
  RxBool isWaitingResponse = false.obs;

  /// default country is palestine
  final phoneNumberCountry = Rx<Country>(CountryService().findByCode('Ps')!);
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
    phoneNumberFieldController.addListener(() {
      if (phoneNumberFieldController.text.trim().isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
  }

  void onPhoneNumberChanged(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }
}
