// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/modules/user_chats/controllers/chats_view_controller.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    Key? key,
    required this.chat,
  }) : super(key: key);

  // (In case of group chat) userId = null
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    chat.printInfo();
    return GetBuilder<ChatsViewController>(
      builder: (controller) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 4.sp,
          ),

          onTap: () => controller.onChatTilePressed(chat),

          ///--------- chat image---------
          leading: CircleAvatar(
            radius: 25.sp,
            backgroundImage: chat.imageProvider,
            // backgroundImage: FileImage(File(image)),
          ),

          ///--------- chat name ---------
          title: Text(
            chat.name,
            style: Theme.of(context).textTheme.headline6,
          ),

          ///--------- number of unread messages ---------
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Text(
                '505',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),

          /// --------- last message ---------
          // subtitle: Padding(
          //   padding: const EdgeInsets.only(top: 7),
          //   child: Obx(() {
          //     final chat = controller.myChatsList.firstWhere((chat) => chat.value.chatPath == chatPath);
          //     final messagesList = chat.value.messages;

          //     log('messages: ${chat.value.messages.length}');
          //     if (messagesList.isEmpty) {
          //       return const SizedBox.shrink();
          //     }

          //     final lastMessage = chat.value.messages.last;
          //     switch (lastMessage.type) {
          //       case MessageType.text:
          //         return Text(lastMessage.text!);

          //       case MessageType.photo:
          //         return Row(
          //           children: const [
          //             Icon(
          //               Icons.photo,
          //               size: 15,
          //             ),
          //             SizedBox(width: 5),
          //             Text('Photo'),
          //           ],
          //         );

          //       case MessageType.video:
          //         return Row(
          //           children: const [
          //             FaIcon(
          //               FontAwesomeIcons.video,
          //               size: 15,
          //             ),
          //             SizedBox(width: 5),
          //             Text('Video'),
          //           ],
          //         );

          //       case MessageType.audio:
          //         return Row(
          //           children: const [
          //             Icon(
          //               Icons.mic,
          //               size: 18,
          //             ),
          //             Text('Audio'),
          //           ],
          //         );

          //       default:
          //         return Row(
          //           children: const [
          //             FaIcon(
          //               FontAwesomeIcons.solidFile,
          //               size: 15,
          //             ),
          //             Text('File'),
          //           ],
          //         );
          //     }
          //   }),
          // ),
        );
      },
    );
  }
}
