import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/signup_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';

import 'package:whatsapp_clone/utils/constants/assets.dart';

class SignUpScreen extends GetView<SignupController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Image.asset(
                      Assets.illustraion,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(
                        'Sign up for free',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Phone Number',
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          color: Theme.of(context).hintColor,
                                          fontSize: 30.sp,
                                        ),
                                  ),
                                  TextSpan(
                                    text: '*',
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          color: MyColors.red,
                                          fontSize: 30.sp,
                                        ),
                                  ),
                                ],
                              ),
                              textScaleFactor: 0.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Form(
                        key: controller.formKey,
                        child: TextFormField(
                          controller: controller.phoneNumberFieledController,
                          keyboardType: TextInputType.phone,

                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(12),
                          ],
                          decoration: const InputDecoration(
                            hintText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                          ),
                          validator: controller.phoneNumberFieldValidator,
                        ),
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      GradientButton(
                        isButtonDisable: controller.isButtonDisable,
                        isWaitingForResponse: controller.isWaitingResponse,
                        text: 'Sign up',
                        onPressed: controller.signUp,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?  ',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12.sp,
                                  ),
                            ),
                            GestureDetector(
                              onTap: controller.goToLogIn,
                              child: Text(
                                'Sign in',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
