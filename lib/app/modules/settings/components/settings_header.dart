// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:whatsapp_clone/app/shared_widgets/gradient_icon_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';

import '../controllers/settings_screen_controller.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SettingsScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///user image + edit button
        UserAvatar(
          avatarSize: 40.sp,
          userImage: controller.userImage,
          onEditButtonPressed: controller.onEditProfileImagePressed,
        ),

        SizedBox(
          width: 15.sp,
        ),

        ///user name & phone number
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///user name
            Text(
              controller.userName,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 8.sp,
            ),

            ///user phone number
            Text(
              controller.userPhoneNumber,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
        const Spacer(),

        ///Qr Code
        GradientIconButton(
          icon: Icons.qr_code_2_rounded,
          iconSize: 30.sp,
          onPressed: controller.onQrIconPressed,
        ),
      ],
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.userImage,
    required this.avatarSize,
    required this.onEditButtonPressed,
  }) : super(key: key);

  final ImageProvider userImage;
  final double avatarSize;
  final Function() onEditButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///user image
        CircleAvatar(
          radius: avatarSize,
          backgroundImage: userImage,
        ),

        ///Edit Button
        Positioned(
          bottom: 5.sp,
          right: 5.sp,
          child: Container(
            width: 23.sp,
            height: 23.sp,
            decoration: const BoxDecoration(
              color: MyColors.Green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onEditButtonPressed,
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
