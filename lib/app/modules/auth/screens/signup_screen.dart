import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/signup_controller.dart';

import 'package:whatsapp_clone/utils/constants/assest_path.dart';

import '../views/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key})
      : controller = Get.put(SignupController()),
        super(key: key);

  final SignupController controller;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
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
              SizedBox(
                height: 280.h,
                child: const SignUpForm(),
              ).paddingOnly(bottom: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
