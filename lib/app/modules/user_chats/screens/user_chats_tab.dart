import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/modules/user_chats/controllers/chats_view_controller.dart';
import 'package:whatsapp_clone/app/modules/user_chats/components/chat_tile.dart';
import 'package:whatsapp_clone/app/shared_widgets/searchable_list.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/utils/constants/assests.dart';

class ChatsTapView extends StatelessWidget {
  ChatsTapView({super.key}) : controller = Get.put(ChatsViewController());

  final ChatsViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final myChats = controller.chatsList;
        // log('Chats Tap==> num of chats: ${myChats.value.length}');

        if (myChats.value.isEmpty) {
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

        return Obx(
          () => SearchableListView<Rx<Chat>>(
            list: myChats.value,
            textController: controller.searchController,
            filteringFunction: controller.filter,
            itemBuilder: (chat) => ChatTile(chat: chat.value),
          ),
        );
      },
    );
  }
}
