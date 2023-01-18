import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:whatsapp_clone/app/api/user_provider.dart';
import 'package:whatsapp_clone/app/api/chats_creater_provider.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';
import 'package:whatsapp_clone/utils/my_exceptions.dart';
import 'package:whatsapp_clone/utils/ui/custom_snackbar.dart';

class QRScreenController extends GetxController {
  late String userName;
  late Rx<ImageProvider> userImage;

  late String userPhoneNumber;

  @override
  void onInit() {
    super.onInit();
    userName = MySharedPref.getUserName!;
    userPhoneNumber = MySharedPref.getUserPhoneNumber!;
    userImage = UserProvider.userImage;
  }

  void onShareIconPressed() {}

  void onMorePressed() {}

  Future<void> onBarcodeDetected(Barcode barcode, MobileScannerArguments? args) async {
    if (barcode.rawValue == null) {
      log('Failed to scan Barcode');
      return;
    }

    final String code = barcode.rawValue!;
    log('Barcode found! $code');

    readBarCode(code);
  }

  Future<void> readBarCode(String code) async {
    final isUserExists = await UserProvider.checkIsUserExists(userUID: code);

    if (!isUserExists) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: 'The Barcode does not have a valid user',
      );
      return;
    }

    try {
      await createPrivateChat(code);
      /// if you already  chat already exists
    } on ChatException catch (e) {
      log(e.toString());
      CustomSnackBar.showCustomErrorSnackBar(
        message: 'The user is already in your contacts',
      );

      return;
    }

    CustomSnackBar.showCustomSnackBar(
      message: 'The user has been Added Successfully',
    );
  }
}
