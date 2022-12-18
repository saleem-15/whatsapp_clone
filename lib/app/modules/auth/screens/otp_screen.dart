import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

import '../controllers/otp_form_controller.dart';

class OTPScreen extends GetView<OTPScreenController> {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter OTP Code'),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 30.sp,
          ),
          child: Column(
            children: [
              const Spacer(),
              Text(
                'Code has been sent to ${controller.obsucuredPhoneNumber()}',
                style: Theme.of(context).textTheme.bodyText2,
              ),

              SizedBox(
                height: 20.sp,
              ),

              /// OTP Text Field
              Pinput(
                // forceErrorState: true,
                length: OTPScreenController.otpCodeLength,
                controller: controller.otpTextController,
                defaultPinTheme: MyStyles.getDefaultPinTheme,
                focusedPinTheme: MyStyles.getFocusedPinTheme,
                submittedPinTheme: MyStyles.getSubmittedPinTheme,
                errorPinTheme: MyStyles.getErrorPinTheme,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: controller.onOtpFieldChanged,

                onCompleted: controller.onOtpFieldCompleted,
              ),

              SizedBox(
                height: 40.sp,
              ),

              Obx(() => controller.isVerificationCodeSent.value
                  ? Obx(
                      () => RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                fontSize: 28.sp,
                              ),
                          children: <TextSpan>[
                            const TextSpan(text: 'Resend code in '),
                            TextSpan(
                              text: '${controller.timeRemainingToBeAbleToReSend.value}',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: MyColors.Green,
                                    fontSize: 30.sp,
                                  ),
                            ),
                            const TextSpan(text: ' s'),
                          ],
                        ),
                        textScaleFactor: 0.5,
                      ),
                    )
                  : const SizedBox.shrink()),
              const Spacer(),

//  OutlinedButton(
//                     onPressed: controller.resendCode,
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(
//                         width: 1,
//                         color: MyColors.Green,
//                       ),
//                     ),
//                     child: const Text('Resend Code'),
//                   ),
              /// resend && confrim buttons
              GradientButton(
                text: 'Verify',
                onPressed: controller.onVerifyButtonPressed,
                isWaitingForResponse: controller.isWaitingResponse,
                isButtonDisable: controller.isVerifiyButtonDisabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
