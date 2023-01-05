// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

import '../controllers/account_screen_controller.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key}) : controller = Get.put(AccountScreenController());

  final AccountScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Column(
        children: [
          myDivider(),
          _buildListTile(
            context,
            text: 'Privacy',
            onPressed: () {},
          ),
          myDivider(),
          _buildListTile(
            context,
            text: 'Change Number',
            onPressed: controller.onChangeNumberTilePressed,
          ),
          myDivider(),
          _buildListTile(
            context,
            text: 'Request Account Info',
            onPressed: controller.onRequestAccountInfoTilePressed,
          ),
          myDivider(),
          _buildListTile(
            context,
            text: 'Delete My Account',
            textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: MyColors.red),
            onPressed: controller.onDeleteMyAccountTilePressed,
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
