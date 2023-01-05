import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/auth/controllers/auth_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/bottom_sheet_skeleton.dart';

class AccountScreenController extends GetxController {
  void onDeleteMyAccountTilePressed() {
    Get.bottomSheet(
      Builder(
        builder: (context) => MyBottomSheet(
          content: Column(
            children: [
              Text(
                'Are you sure you want to delete the account?',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              SizedBox(
                height: 10.sp,
              ),
              const Text(
                'We will verify you first with a few questions',
              ),
            ],
          ),
          cancelButtonText: 'Cancel',
          confirmButtonText: 'Yes,Delete',
          onCancel: Get.back,
          onConfirm: Get.find<AuthController>().deleteAccount,
        ),
      ),
    );
  }

  void onRequestAccountInfoTilePressed() {}

  void onChangeNumberTilePressed() {}
}
