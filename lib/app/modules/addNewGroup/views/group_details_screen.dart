import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_button.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

import '../controllers/group_details_controller.dart';
import 'select_group_members_screen.dart';

class GroupDetailsScreen extends StatelessWidget {
  GroupDetailsScreen({super.key}) : controller = Get.put(GroupDetailsController());
  final GroupDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GradientFloatingActionButton(
        onPressed: controller.onFABPressed,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'New Group',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: MyStyles.getHorizintalScreenPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// group image + text field
            Row(
              children: [
                ///group image
                SizedBox.square(
                  dimension: 70.r,
                  child: Obx(
                    () => Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.grey.shade200,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: controller.pickImage,
                          child: Material(
                            color: Colors.transparent,
                            child: controller.groupImage.value == null

                                /// camera icon (displayed if there is not any image)
                                ? Icon(
                                    Icons.camera_alt_outlined,
                                    size: 25.sp,
                                  )

                                /// group image (displayed if exists)
                                : Image(
                                    image: controller.groupImage.value!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        )),
                  ),
                ),

                const SizedBox(
                  width: 15,
                ),

                /// group name text field
                Expanded(
                  child: TextField(
                    controller: controller.groubNameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter group name',
                    ),
                  ),
                )
              ],
            ),
            Divider(
              height: 15.sp,
              indent: MyStyles.leftScreenPadding,
              endIndent: MyStyles.rightScreenPadding,
              thickness: 1.sp,
            ),
            Text(
              'Participants',
              style: Theme.of(context).textTheme.headline3,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 15, left: 15),
                itemCount: controller.selectedUsers.length,
             

                   itemBuilder: (_, index) => UserTile(
                  user: controller.selectedUsers[index],
                  isSelected: false, ///dont show check icon
                  onTap: () => controller.onUserTilePressed(controller.selectedUsers[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
