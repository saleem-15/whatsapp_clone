import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/api/auth_provider.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';

class OTPScreenController extends GetxController {
  /// the length of the verfication code that is sent to the user
  static const int otpCodeLength = 6;

  /// used to display the phone number that the(verfication code was sent to) to the user
  late final String phoneNumber;

  final otpTextController = TextEditingController();

  /// these variables are used to change the UI according to the changes
  RxBool isVerifiyButtonDisabled = true.obs;
  RxBool isWaitingResponse = false.obs;
  RxBool isVerificationCodeSent = false.obs;
  RxInt timeRemainingToBeAbleToReSend = 60.obs;

  GlobalKey<FormState> otpFieldKey = GlobalKey<FormState>();

  bool isValidCode = false;

  ///its used by the OTP screen to display the phone number obsucred
  String obsucuredPhoneNumber() {
    return phoneNumber.replaceRange(5, 10, '******');
  }

  @override
  void onInit() {
    phoneNumber = Get.parameters['phoneNumber']!;
    super.onInit();
  }

  Future<void> onVerifyButtonPressed() async {
    final code = otpTextController.text;

    isWaitingResponse(true);
    final isSuccess = await AuthProvider.verifyTheSentCode(code);
    isWaitingResponse(false);

    if (isSuccess) {
      ///close all the screens and go to the home screen
      isValidCode = true;
      Get.offAllNamed(Routes.HOME);
      return;
    }

    isValidCode = false;
    otpFieldKey.currentState!.validate();
  }

  void resendCode() {}

  ///must be called when the OTP field value changes
  void onOtpFieldChanged(String pinCode) {
    if (pinCode.length == otpCodeLength) {
      isVerifiyButtonDisabled(false);
    } else {
      isVerifiyButtonDisabled(true);
    }
  }
}
