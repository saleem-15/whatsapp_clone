import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:underline_indicator/underline_indicator.dart';
import 'package:whatsapp_clone/app/modules/settings/components/my_qr_code_tap.dart';
import 'package:whatsapp_clone/app/modules/settings/components/scan_qr_code_tap.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_icon_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/config/theme/light_theme_colors.dart';

import '../controllers/qr_screen_controller.dart';

class QRScreen extends StatelessWidget {
  QRScreen({Key? key})
      : controller = Get.put(QRScreenController()),
        super(key: key);

  final QRScreenController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'QR Code',
          ),
          actions: [
            Center(
              child: GradientIconButton(
                icon: Icons.share_outlined,
                backgroundColor: MyColors.LightGreen,
                backgroundSize: 35.sp,
                onPressed: controller.onShareIconPressed,
              ),
            ),
            SizedBox(width: 15.sp),
            Center(
              child: GradientIconButton(
                icon: Icons.more_vert,
                backgroundColor: MyColors.LightGreen,
                backgroundSize: 35.sp,
                onPressed: controller.onMorePressed,
              ),
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
                    Tab(text: 'My Code'),
                    Tab(text: 'Scan Code'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  MyQRCodeTap(
                    controller: controller,
                  ),
                  ScanQRCodeTap(
                    controller: controller,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
