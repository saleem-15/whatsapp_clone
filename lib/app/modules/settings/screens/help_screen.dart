// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

import '../controllers/help_screen_controller.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({super.key}) : controller = Get.put(HelpScreenController());

  final HelpScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Column(
        children: [
          myDivider(),
          _buildListTile(
            context,
            text: 'FAQ',
            onPressed: () {},
          ),
          myDivider(),
          _buildListTile(
            context,
            text: 'Terms & Conditions',
            onPressed: controller.onTermsAndConditionsTilePressed,
          ),
          myDivider(),
          _buildListTile(
            context,
            text: 'Privay Policy',
            onPressed: controller.onPrivacyPolicyInfoTilePressed,
          ),
          myDivider(),
          _buildListTile(
            context,
            text: 'App Info',
            onPressed: controller.onAppInfoTilePressed,
          ),
          myDivider(),
        ],
      ),
    );
  }

  Widget myDivider() {
    return Padding(
      padding: MyStyles.getHorizintalScreenPadding(),
      child: const Divider(),
    );
  }

  InkWell _buildListTile(BuildContext context,
      {required String text, required Function() onPressed, TextStyle? textStyle}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: MyStyles.getHorizintalScreenPadding().copyWith(
          top: 20.sp,
          bottom: 20.sp,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 15.sp,
            ),
            Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.bodyText1,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).iconTheme.color,
              size: 15.sp,
            ),
          ],
        ),
      ),
    );
  }
}
