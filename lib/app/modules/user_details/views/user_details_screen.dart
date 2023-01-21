import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_icon.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_icon_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import '../controllers/user_details_controller.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({super.key}) : controller = Get.put(ChatDetailsController());

  final ChatDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          /// video icon
          Center(
            child: GradientIconButton(
              icon: FontAwesomeIcons.video,
              backgroundSize: 35.sp,
              iconSize: 18.sp,
              backgroundColor: MyColors.LightGreen,
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 10.sp,
          ),

          /// phone icon
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
            width: 10.sp,
          ),

          /// share icon
          Center(
            child: GradientIconButton(
              icon: Icons.share_outlined,
              backgroundSize: 35.sp,
              backgroundColor: MyColors.LightGreen,
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 10.sp,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: MyStyles.getHorizintalScreenPadding(),
          child: Column(
            children: [
              const Divider(),
              SizedBox(
                height: 20.sp,
              ),

              /// Chat image
              CircleAvatar(
                foregroundImage: controller.chatImage,
                radius: 50.r,
              ),
              SizedBox(
                height: 10.sp,
              ),

              /// Chat name
              Text(
                controller.chat.name,
                style: Theme.of(context).textTheme.headline2,
              ),
              if (!controller.isGroupChat)
                SizedBox(
                  height: 10.sp,
                ),

              /// User phoneNumber (if it was a user)
              if (!controller.isGroupChat)
                Text(
                  controller.phoneNumber,
                  style: Theme.of(context).textTheme.caption,
                ),

              Divider(
                height: 30.sp,
              ),

              /// Chat bio & chat creatinon time
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.chat.bio,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          controller.chat.formattedCreationDate,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 30.sp,
              ),

              /// Notifications Tile
              Row(
                children: [
                  GradientIcon(
                    iconSize: 25.sp,
                    icon: Icons.notifications_none_rounded,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Mute Notifications',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const Spacer(),
                  Obx(
                    () => CupertinoSwitch(
                      value: controller.isNotificationsOnn.value,
                      onChanged: (value) => controller.isNotificationsOnn(value),
                    ),
                  )
                ],
              ),
              Divider(
                height: 20.sp,
              ),

              SizedBox(
                height: 100,
                child: groupParticipants(
                  [MySharedPref.getUserData!],
                  context,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget groupParticipants(List<User> users, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${users.length} Participants',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            GradientIconButton(
              icon: Icons.search,
              iconSize: 23.sp,
              onPressed: () {},
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              User user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  foregroundImage: user.imageProvider,
                ),
                title: Text(user.name),
                subtitle: Text(user.phoneNumber),
                trailing: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 3.sp,
                    horizontal: 5.sp,
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.LightGreen,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: const Text(
                    'Group Admin',
                    style: TextStyle(
                      color: MyColors.Green,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
