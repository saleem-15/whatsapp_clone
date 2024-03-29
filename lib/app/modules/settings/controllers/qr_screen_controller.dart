import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:whatsapp_clone/app/api/user_api.dart';
import 'package:whatsapp_clone/app/api/chats_creater_api.dart';
import 'package:whatsapp_clone/utils/exceptions/chat_exceptions.dart';
import 'package:whatsapp_clone/utils/ui/custom_snackbar.dart';

import '../../../providers/users_provider.dart';

class QRScreenController extends GetxController {
  late String userName;
  late ImageProvider userImage;

  late String userPhoneNumber;

  String get encodeQrCodeData {
    return Get.find<UsersProvider>().me.value.uid;
    return json.encode({
      'userId': Get.find<UsersProvider>().me.value.uid,
      'userName': userName,
    });
  }

//   Map decodeQrCodeData(String data) {
// jsonDecode(source)

//     return json.decode(data);
//   }

  @override
  void onInit() {
    super.onInit();
    final user = Get.find<UsersProvider>().me.value;

    userName = user.name;
    userPhoneNumber = user.phoneNumber;
    userImage = user.imageProvider;
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
    final isUserExists = await UserApi.checkIsUserExists(userUID: code);

    if (!isUserExists) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: 'The Barcode does not have a valid user',
      );
      return;
    }

    try {
      await createPrivateChat(code);
      // Get.find<UsersProvider>().reFetchUsersFromBackend();

      /// if you already  chat already exists
    } on ChatException catch (e) {
      // log(e.toString());
      Logger().e(e);
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
