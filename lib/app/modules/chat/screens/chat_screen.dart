import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/chat/components/messages.dart';

import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_icon_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/utils/helpers/message_bubble_settings.dart';

import '../../../../utils/ui/custom_snackbar.dart';
import '../components/chat_text_field.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key})
      : controller = Get.put(ChatScreenController()),
        super(key: key);

  final ChatScreenController controller;

  @override
  Widget build(BuildContext context) {
    log('chat screen');

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          borderRadius: BorderRadius.circular(3.sp),
          onTap: controller.onAppBarPressed,
          child: SizedBox(
            child: Row(
              children: [
                Hero(
                  tag: controller.chat.image!,
                  child: CircleAvatar(
                    backgroundImage: controller.chat.imageProvider,
                    maxRadius: 20,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.chat.name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          Center(
            child: GradientIconButton(
              icon: FontAwesomeIcons.video,
              backgroundSize: 35.sp,
              iconSize: 18.sp,
              backgroundColor: MyColors.LightGreen,
              onPressed: () {
                // CustomSnackBar.showCustomSnackBar(message: 'message');
                CustomSnackBar.showCustomToast(message: 'message');
                // CustomSnackBar.showCustomToast(message: 'message');
                // CustomSnackBar.showCustomErrorToast(message: 'message');
              },
            ),
          ),
          SizedBox(
            width: 5.sp,
          ),
          Center(
            child: GradientIconButton(
              icon: FontAwesomeIcons.phone,
              backgroundSize: 35.sp,
              iconSize: 18.sp,
              backgroundColor: MyColors.LightGreen,
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 5.sp,
          ),
          Center(
            child: GradientIconButton(
              icon: Icons.more_vert,
              backgroundSize: 35.sp,
              backgroundColor: MyColors.LightGreen,
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 5.sp,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const ChatBackground(),
          Column(
            children: [
              Expanded(
                child: Messages(
                  chatId: controller.chat.id,
                ),
              ),

              /// Chat Text Field
              Container(
                margin: EdgeInsets.only(
                  top: 5.sp,
                  bottom: 20.sp,
                  left: 15.w,
                  right: 15.w,
                ),
                child: const ChatTextField(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBackground extends StatelessWidget {
  const ChatBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Theme.of(context).scaffoldBackgroundColor,
    );
    return Obx(
      () => Positioned.fill(
        child: MessageBubbleSettings.backgroundType.value == ChatBacground.image
            ? Image.asset(
                MessageBubbleSettings.chatBackgroundImage.value,
                fit: BoxFit.cover,
              )
            : Ink(
                color: MessageBubbleSettings.chatBackgroundColor.value,
              ),
      ),
    );
  }
}
