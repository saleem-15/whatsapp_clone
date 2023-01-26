// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';

import '../controllers/select_group_members_controller.dart';

class SelectNewGroupMembersScreen extends StatelessWidget {
  SelectNewGroupMembersScreen({super.key}) : controller = Get.put(SelectNewGroupMembersController());
  final SelectNewGroupMembersController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: GradientFloatingActionButton(
          onPressed: controller.selectedPeopleIndices.isEmpty ? null : controller.onFloatingButtonPressed,
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
        appBar: appBar(),
        body: Column(
          children: [
            /// header (selected users)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              constraints: BoxConstraints(
                minHeight: 50,
                maxHeight: controller.selectedPeopleIndices.isEmpty ? 50 : 130,
              ),
              child: controller.selectedPeopleIndices.isEmpty
                  ? const Center(child: Text('No one is selected'))
                  : AlignedGridView.extent(
                      crossAxisSpacing: 5,
                      maxCrossAxisExtent: 100,
                      shrinkWrap: true,
                      itemCount: controller.selectedPeopleIndices.length,
                      //    mainAxisSpacing: 20,
                      //  crossAxisSpacing: 4,
                      itemBuilder: (context, index) {
                        final selectedPerson =
                            controller.myContacts[controller.selectedPeopleIndices[index]].value;
                        final selectedUserImage = selectedPerson.imageProvider;

                        return Chip(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: Colors.grey.shade300,
                          avatar: CircleAvatar(
                            radius: 15,
                            backgroundImage: selectedUserImage,
                            backgroundColor: Colors.grey.shade200,
                          ),
                          label: Text(selectedPerson.name),
                        );
                      },
                    ),
            ),

            const Divider(
              height: 0,
            ),

            /// all my contacts list
            Expanded(
              child: ListView.builder(
                itemCount: controller.myContacts.length,
                itemBuilder: (_, index) => UserTile(
                  user: controller.myContacts[index].value,
                  isSelected: controller.selectedPeopleIndices.contains(index),
                  onTap: () => controller.onUserTilePressed(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New Group',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            controller.selectedPeopleIndices.isNotEmpty
                ? '${controller.selectedPeopleIndices.length} selected'
                : 'unlimited number of members',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required this.user,
    this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final User user;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,

      /// user circle image
      leading: CircleAvatar(
        radius: 25.r,
        backgroundImage: user.imageProvider,
        child: !isSelected
            ? null
            :

            /// selected icon
            Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(1),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: MyColors.greenGradient,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.done,
                      size: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
      ),

      /// user name
      title: Text(
        user.name,
        style: Theme.of(context).textTheme.bodyText1,
      ),

      /// phone number
      subtitle: Text(
        user.phoneNumber,
        style: Theme.of(context).textTheme.caption!.copyWith(
              fontSize: 12.sp,
            ),
      ),
    );
  }
}
