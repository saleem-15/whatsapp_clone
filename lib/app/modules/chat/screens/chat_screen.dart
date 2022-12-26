import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/chat/components/messages.dart';

import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_icon_button.dart';
import 'package:whatsapp_clone/utils/helpers/message_bubble_settings.dart';

import '../components/chat_text_field.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key})
      : controller = Get.put(ChatScreenController()),
        super(key: key);

  final ChatScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          borderRadius: BorderRadius.circular(3.sp),
          onTap: controller.onAppBarPressed,
          child: Row(
            // mainAxisSize: MainAxisSize.min,
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
        actions: [
          GradientIconButton(
            icon: FontAwesomeIcons.video,
            size: 18.sp,
            onPressed: () {},
          ),
          SizedBox(
            width: 5.sp,
          ),
          GradientIconButton(
            icon: FontAwesomeIcons.phone,
            size: 18.sp,
            onPressed: () {},
          ),
          SizedBox(
            width: 5.sp,
          ),
          GradientIconButton(
            icon: Icons.more_vert,
            onPressed: () {},
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
                  left: 15.w,
                  right: 15.w,
                  bottom: 20.sp,
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
