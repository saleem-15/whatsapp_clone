// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_button.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

import '../components/profile_form.dart';
import '../components/settings_header.dart';
import '../controllers/profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key}) : controller = Get.put(ProfileScreenController());

  final ProfileScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.vertical - 60,
          child: Padding(
            padding: MyStyles.getHorizintalScreenPadding().copyWith(
              bottom: 30.sp,
            ),
            child: Column(
              children: [
                Divider(
                  height: 30.sp,
                ),

                ///user image + edit button
                Hero(
                  tag: 'user_image',
                  child: UserAvatar(
                    avatarSize: 60.sp,
                  ),
                ),

                Divider(
                  height: 30.sp,
                ),
                ProfileForm(
                  controller: controller,
                ),
                const Spacer(),
                GradientButton(
                  isButtonDisable: controller.isButtonDisable,
                  isWaitingForResponse: controller.isWaitingResponse,
                  text: 'Update My Profile',
                  onPressed: controller.onUpdateButtonPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
