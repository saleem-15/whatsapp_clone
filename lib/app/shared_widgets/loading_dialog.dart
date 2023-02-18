import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  static bool _isShown = false;

  static void show() {
    _isShown = true;
    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async => false,
        child: const LoadingDialog(),
      ),
    );
  }

  static void close() {
    if (_isShown) {
      Get.back();
      _isShown = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          width: 100.sp,
          height: 100.sp,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Center(
            child: Lottie.asset('assets/lottie/Loading2.json'),
          ),
        ),
      ),
    );
  }
}
