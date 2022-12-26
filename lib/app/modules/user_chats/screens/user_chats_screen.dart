import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/user_chats/controllers/chats_view_controller.dart';
import 'package:whatsapp_clone/app/modules/user_chats/components/chat_tile.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

class ChatsTapView extends StatelessWidget {
  ChatsTapView({Key? key})
      : controller = Get.put(ChatsViewController()),
        super(key: key);

  final ChatsViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final myChats = controller.myChatsList;

        if (myChats.isEmpty) {
          return Align(
            alignment: const Alignment(0, -.4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Assets.empty_chats,
                  width: 200,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 30.sp,
                ),
                Text(
                  'You haven\'t chat yet',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: MyColors.Green,
                      ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: myChats.length,
          itemBuilder: (context, index) {
            //
            final chat = myChats[index].value;

            return ChatTile(
              chat: chat,
            );
          },
        );
      },
    );
  }
}
