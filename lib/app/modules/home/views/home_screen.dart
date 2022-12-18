import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:underline_indicator/underline_indicator.dart';
import 'package:whatsapp_clone/app/modules/user_chats/screens/user_chats_screen.dart';
import 'package:whatsapp_clone/app/modules/home/views/status_view.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_icon_button.dart';
import 'package:whatsapp_clone/config/theme/light_theme_colors.dart';

import '../controllers/home_controller.dart';
import 'calls_veiw.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'WhatsUp',
          ),
          actions: [
            GradientIconButton(
              icon: Icons.search,
              onPressed: () {},
            ),
            SizedBox(width: 15.sp),
            GradientIconButton(
              icon: Icons.more_vert,
              onPressed: () {},
            ),
            SizedBox(width: 15.sp),
          ],
        ),
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
            const Expanded(
              child: TabBarView(
                children: [
                  ChatsTapView(),
                  StatusView(),
                  CallsView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
