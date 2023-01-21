import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/signup_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';

class SignUpForm extends GetView<SignupController> {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 20.h,
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
          height: 10.h,
        ),
        Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.phoneNumberFieledController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12),
                ],
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: controller.phoneNumberFieldValidator,
              ),
              SizedBox(
                height: 15.h,
              ),
              TextFormField(
                controller: controller.userNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(25),
                ],
                decoration: const InputDecoration(
                  hintText: 'User Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: controller.userNameValidator,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.h,
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
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
