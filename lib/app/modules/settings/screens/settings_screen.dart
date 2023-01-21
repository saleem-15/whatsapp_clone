// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_icon.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

import '../components/settings_header.dart';
import '../controllers/settings_screen_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key}) : controller = Get.put(SettingsScreenController());

  final SettingsScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _settingsDivider(),
          InkWell(
            onTap: controller.onUserDataPressed,
            child: Padding(
              padding: MyStyles.getHorizintalScreenPadding().copyWith(
                top: 5,
                bottom: 5,
              ),
              child: SettingsHeader(controller: controller),
            ),
          ),
          _settingsDivider(),

          ///Account
          _buildListTile(
            context,
            'Account',
            Icons.person,
            onPressed: controller.onAccountTilePressed,
          ),
          _settingsDivider(),
          _buildListTile(
            context,
            'Chats',
            FontAwesomeIcons.message,
            onPressed: controller.onChatsTilePressed,
          ),
          _settingsDivider(),
          _buildListTile(context, 'Notifications', FontAwesomeIcons.bell,
              onPressed: controller.onNotificationTilePressed),
          _settingsDivider(),
          _buildListTile(
            context,
            'Security',
            FontAwesomeIcons.shield,
            onPressed: controller.onSecurityTilePressed,
          ),
          _settingsDivider(),
          _buildListTile(
            context,
            'Help',
            Icons.info_outline_rounded,
            onPressed: controller.onHelpTilePressed,
          ),

          _settingsDivider(),

          _buildListTile(
            context,
            'Logout',
            Icons.login_rounded,
            hasArrow: false,
            gradientType: GradientType.RedGradient,
            backgroundColor: MyColors.LightRed,
            onPressed: controller.onLogoutTilePressed,
          ),
        ],
      ),
    );
  }

  Widget _settingsDivider() {
    return Padding(
      padding: MyStyles.getHorizintalScreenPadding(),
      child: const Divider(),
    );
  }

  Widget _buildListTile(BuildContext context, String text, IconData icon,
      {required Function() onPressed,
      bool hasArrow = true,
      Color? backgroundColor,
      GradientType? gradientType}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: MyStyles.getHorizintalScreenPadding().copyWith(
          top: 15.sp,
          bottom: 15.sp,
        ),
        child: Row(
          children: [
            GradientIcon(
              backgroundSize: 50.sp,
              iconSize: 23.sp,
              icon: icon,
              hasBackground: true,
              gradientType: gradientType,
              backgroundColor: backgroundColor,
            ),
            SizedBox(
              width: 15.sp,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.headline3,
            ),
            const Spacer(),
            if (hasArrow)
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
