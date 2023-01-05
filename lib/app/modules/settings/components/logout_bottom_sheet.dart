// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:whatsapp_clone/app/modules/settings/controllers/settings_screen_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/bottom_sheet_skeleton.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({
    Key? key,
    required this.controller,
  }) : super(key: key);
  
  final SettingsScreenController controller;

  @override
  Widget build(BuildContext context) {
    return MyBottomSheet(
      cancelButtonText: 'Cancel',
      onCancel: controller.onLogoutBottomSheetCancel,
      confirmButtonText: 'Yes,Logout',
      onConfirm: controller.onLogoutBottomSheetConfrim,
      content: const Text(
        'Are you sure you want to log out?',
      ),
    );
  }
}
