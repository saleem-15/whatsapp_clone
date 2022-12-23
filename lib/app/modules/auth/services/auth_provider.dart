// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/routes/app_pages.dart';
import 'package:whatsapp_clone/utils/custom_snackbar.dart';

/// it returnes true if signup process is successful

class AuthProvider {
  AuthProvider._();

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore db = FirebaseFirestore.instance;

  ///used when verifiying the verification code (SMS Message)
  static String? verificationId;

  /// the phone number must begin with '+' (with internationl code)
  static Future<void> signUpService(String phoneNumber, String name) async {
    await verifyPhone(phoneNumber);

    await _createUserDoc(name, phoneNumber);
  }

  static Future<void> verifyPhone(String phoneNumber) => auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        /// the time after which the sent code is invalid
        timeout: const Duration(seconds: 60),

        //!------------------------------------------------------------------------------
        //This callback would gets called when verification is done auto maticlly
        verificationCompleted: (PhoneAuthCredential credential) async {
          Get.back();

          // Sign the user in (or link) with the auto-generated credential
          final result = await auth.signInWithCredential(credential);

          if (result.user == null) {
            CustomSnackBar.showCustomErrorToast(message: 'Error');
            log('Error');
          } else {
            CustomSnackBar.showCustomToast(message: 'verifacion success');
            log('verifacion success');
          }
        },

        //!------------------------------------------------------------------------------
        /// a callback which gets called if the verification is failed
        /// because of (wrong code) or (incorrect mobile number).
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            CustomSnackBar.showCustomErrorToast(message: 'verifacion failed');
          } else {
            // Handle other errors
            log(e.code);
            CustomSnackBar.showCustomErrorToast(message: e.code);
          }
        },

        //!------------------------------------------------------------------------------
        ///a callback which gets called once the code is sent to the device.
        codeSent: (_verificationId, forceResendingToken) {
          Get.toNamed(
            Routes.OTP_SCREEN,
            parameters: {'phoneNumber': phoneNumber},
          );
          
          verificationId = _verificationId;
        },

        //!------------------------------------------------------------------------------
        ///callback which gets called when the time will be
        ///completed for the auto retrieval of code.
        codeAutoRetrievalTimeout: (verificationId) {
          verificationId = verificationId;
          log(verificationId);
          log("Timout");
        },
      );

  static Future<void> _createUserDoc(String name, String phoneNumber) async {
    while (FirebaseAuth.instance.currentUser == null) {
      await Future.delayed(const Duration(seconds: 2));
    }

    await db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'photoUrl': null,
      'chats': null,
    });
  }

  /// returnes true if the sent code is verified, Otherwise returnes false
  static Future<bool> verifyTheSentCode(String code) async {
    final auth = FirebaseAuth.instance;

    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: code,
    );

    try {
      UserCredential result = await auth.signInWithCredential(credential);

      return true;
      // if (result.user != null) {
      // }
    } on FirebaseAuthException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(message: e.code);
      log(e.code);
      return false;
    }
  }

  /// the phone number must begin with '+' (with internationl code)
  static signInService(String phoneNumber) async {
    await verifyPhone(phoneNumber);
  }
}
