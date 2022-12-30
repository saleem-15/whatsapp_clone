import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static showCustomSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 5),
  }) {
    // backgroundColor: MyColors.red.withOpacity(.8),
    myCustomSnackBar(
      message: message,
      color: MyColors.Green.withOpacity(.7),
      duration: duration,
    );
  }

  static myCustomSnackBar({
    required String message,
    Color color = MyColors.SnackBarColor,
    Duration duration = const Duration(seconds: 5),
    double? blurScreen,
  }) {
    Get.rawSnackbar(
      backgroundColor: color,
      barBlur: 10,
      message: message,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(15),
      borderRadius: 5.r,
      animationDuration: const Duration(milliseconds: 500),
      snackPosition: SnackPosition.TOP,
    );
  }

  static showCustomErrorSnackBar({
    String title = 'Error',
    required String message,
    Color color = Colors.redAccent,
    Duration duration = const Duration(seconds: 3),
    double? blurScreen,
  }) {
    Get.snackbar(
      title.tr,
      message.tr,
      duration: duration,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      colorText: Colors.white,
      backgroundColor: color,
      barBlur: 1,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
      overlayBlur: blurScreen,
    );
  }

  static showCustomToast({
    String? title,
    required String message,
    Color color = Colors.green,
    Duration duration = const Duration(seconds: 3),
  }) {

    // Get.
    Get.rawSnackbar(
      title: title,
      message: message.tr,
      duration: duration,
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
    );
  }

  static showCustomErrorToast({
    String? title,
    required String message,
    Color color = Colors.redAccent,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.rawSnackbar(
      title: title,
      message: message.tr,
      duration: duration,
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
    );
  }
}
