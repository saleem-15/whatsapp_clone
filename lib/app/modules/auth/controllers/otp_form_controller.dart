import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPScreenController extends GetxController {
  /// the length of the verfication code that is sent to the user
  static const int otpCodeLength = 4;

  /// used to display the phone number that the(verfication code was sent to) to the user
  late final String phoneNumber;

  final otpTextController = TextEditingController();

  RxBool isVerifiyButtonDisabled = true.obs;
  RxBool isWaitingResponse = false.obs;
  RxBool isVerificationCodeSent = false.obs;
  RxInt timeRemainingToBeAbleToReSend = 60.obs;
  
  String obsucuredPhoneNumber() {
    return phoneNumber.replaceRange(5, 10, '******');
  }

  @override
  void onInit() {
    phoneNumber = '+970567244416';
    // email = Get.parameters['email']!;
    super.onInit();
  }

  Future<void> onConfirmButtonPressed() async {
    isWaitingResponse(true);
    // final isSuccessfull = await forgetPasswordService(email);
    isWaitingResponse(false);

    // if (isSuccessfull) {
    //   Get.toNamed(Routes.OTP_FORM);
    // }
  }

  /// this method must be called whenever a field changes
  ///
  /// it checks if all the fields are full so it enables the confirm button
  void changeConfirmButtonStatus() {
    // if (isAllOtpFieldsFull) {
    //   isVerifiyButtonDisabled(false);
    // } else {
    //   isVerifiyButtonDisabled(true);
    // }
  }

  Future<void> onVerifyButtonPressed() async {
    // isWaitingResponse(true);
    // final isSuccess = await verifyCodeService(
    //   email: email,
    //   code: verificationCode,
    // );
    // isWaitingResponse(false);

    // if (isSuccess) {
    //   Get.toNamed(Routes.RESET_PASSWORD, parameters: {
    //     'email': email,
    //     'code': verificationCode,
    //   });
    // }
  }

  void resendCode() {}

  void onOtpFieldCompleted(String pinCode) {
    // isVerifiyButtonDisabled(false);
  }

  void onOtpFieldChanged(String pinCode) {
    if (pinCode.length == otpCodeLength) {
      isVerifiyButtonDisabled(false);
    } else {
      isVerifiyButtonDisabled(true);
    }
  }
}
