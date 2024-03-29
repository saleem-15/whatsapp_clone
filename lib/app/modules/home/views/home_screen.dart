import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:underline_indicator/underline_indicator.dart';
import 'package:whatsapp_clone/app/modules/home/views/status_view.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_icon_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/config/theme/light_theme_colors.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';
import 'package:whatsapp_clone/utils/constants/assests.dart';

import '../../../shared_widgets/gradient_widgets/gradient_icon.dart';
import '../../user_chats/screens/user_chats_tab.dart';
import '../controllers/home_controller.dart';
import 'calls_veiw.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}) : controller = Get.put(HomeController());

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: HomeAppBar(controller),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: const DecoratedBox(
                //This is responsible for the background of the tabbar, does the magic
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffdadee3),
                      width: 1,
                    ),
                  ),
                ),
                child: TabBar(
                  indicator: UnderlineIndicator(
                    strokeCap: StrokeCap.round,
                    borderSide: BorderSide(
                      color: LightThemeColors.primaryColor,
                      width: 3,
                    ),
                  ),
                  tabs: [
                    Tab(text: 'CHATS'),
                    Tab(text: 'STATUS'),
                    Tab(text: 'CALLS'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ChatsTapView(),
                  const StatusView(),
                  const CallsView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppBar(this.controller, {super.key});

  final HomeController controller;

  final GlobalKey popUpkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool isSearchMode = controller.isSearchMode.value;

        return AppBar(
          title: isSearchMode
              ? null
              : const Text(
                  'Chatty',
                ),
          actions: [
            /// search (icon button/field)
            Center(
              child: searchField(),
            ),

            if (!isSearchMode) SizedBox(width: 15.sp),

            /// more icon button
            if (!isSearchMode)
              Center(
                child: GradientIconButton(
                  key: popUpkey,
                  icon: Icons.more_vert,
                  backgroundColor: MyColors.LightGreen,
                  backgroundSize: 35.sp,
                  onPressed: () => showMoreButtonPopupMenu(context),
                ),
              ),

            SizedBox(width: 15.sp),
          ],
        );
      },
    );
  }

  Widget searchField() {
    var borderRadius = BorderRadius.circular(10.r);
    return InkWell(
      /// clickable when its an icon button only
      /// when it opens and the text field appears it is not clickable anymore
      onTap: controller.isSearchMode.value ? null : controller.onSearchIconButtonPressed,
      borderRadius: borderRadius,
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 35.sp,
          width: controller.isSearchMode.value ? 330.w : 35.sp,
          decoration: BoxDecoration(
            color: MyColors.LightGreen,
            borderRadius: borderRadius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.isSearchMode.value)
                SizedBox(
                  width: 10.sp,
                ),
              GradientIcon(
                assetIconPath: Assets.SEARCH_ICON,
                iconSize: 16.sp,
              ),

              /// TextField
              if (controller.isSearchMode.value)
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    focusNode: controller.searchFocus,
                    textAlignVertical: TextAlignVertical.center,
                    controller: controller.searchController,
                    cursorHeight: 20.sp,
                    decoration: MyStyles.getInputDecoration().copyWith(
                      contentPadding: EdgeInsets.only(
                        right: 10.sp,
                        left: 10.sp,
                        bottom: 2.sp,
                      ),
                      isCollapsed: true,
                      fillColor: Colors.transparent,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: controller.onCloseSearchIconPressed,
                        icon: const Icon(
                          Icons.close,
                          color: MyColors.Green,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;

  void showMoreButtonPopupMenu(BuildContext context) {
    final RenderBox button = popUpkey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay = Get.overlayContext!.findRenderObject()! as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + Offset.zero, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showMenu(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.sp),
      ),
      useRootNavigator: false,
      items: [
        PopupMenuItem(
          onTap: controller.onNewGroupOptionSelected,
          child: const Text('New Group'),
        ),
        PopupMenuItem(
          onTap: controller.onSettingsOptionSelected,
          child: const Text('Settings'),
        ),
      ],
    );
  }
}
