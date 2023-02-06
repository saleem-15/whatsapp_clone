// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_icon_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/storage/files_manager.dart';

import '../controllers/settings_screen_controller.dart';
import '../../../api/user_api.dart';
import 'change_avatar_bottom_sheet.dart';

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
        Hero(
          tag: 'user_image',
          child: UserAvatar(
            avatarSize: 40.sp,
          ),
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

/// this widget handles its own logic
/// (loading image from file,opening bottom sheet,changing)
class UserAvatar extends StatelessWidget {
  UserAvatar({
    super.key,
    required this.avatarSize,
  }) : userImageProvider = UserApi.userImage;

  late final Rx<ImageProvider> userImageProvider;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///user image
        Obx(
          () => CircleAvatar(
            radius: avatarSize,
            backgroundImage: userImageProvider.value,
          ),
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
            child: Material(
              type: MaterialType.circle,
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: onEditProfileImagePressed,
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onEditProfileImagePressed() {
    Get.bottomSheet(
      ChangeUserAvatarBottomSheet(
        chooseUserImageFromCamera: () => chooseUserImage(ImageSource.camera),
        chooseUserImageFromGallery: () => chooseUserImage(ImageSource.gallery),
      ),
    );
  }

  Future<void> chooseUserImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);

    ///close the bottom sheet (choose image source bottom sheet)
    Get.back();

    ///if the user did not choose any image
    if (image == null) {
      return;
    }

    final userImageFile = File(image.path);

    userImageProvider.value = FileImage(userImageFile);

    FileManager.saveUserImage(userImageFile);

    UserApi.updateUserImage(userImageFile);
  }
}
