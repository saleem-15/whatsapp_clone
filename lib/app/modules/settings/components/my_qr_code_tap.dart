// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:whatsapp_clone/app/modules/settings/controllers/qr_screen_controller.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

class MyQRCodeTap extends StatelessWidget {
  const MyQRCodeTap({
    super.key,
    required this.controller,
  });

  final QRScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: MyStyles.getHorizintalScreenPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Obx(
              () => CircleAvatar(
                backgroundImage: controller.userImage.value,
                radius: 50.r,
              ),
            ),
            SizedBox(height: 20.sp),
            Text(
              controller.userName,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            SizedBox(height: 10.sp),
            Text(
              controller.userPhoneNumber,
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 20.sp),
            PrettyQr(
              // image: const AssetImage(Assets.illustraion),
              typeNumber: 3,
              size: 200.sp,
              data: MySharedPref.getUserId!,
              errorCorrectLevel: QrErrorCorrectLevel.M,
              roundEdges: true,
            ),
            SizedBox(height: 20.sp),
            Text(
              'Your QR Code is private. If you share it with someone,then they can add you as a contact. ',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
