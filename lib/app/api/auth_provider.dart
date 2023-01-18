// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';
import 'package:whatsapp_clone/utils/ui/custom_snackbar.dart';

import 'user_provider.dart';

/// it returnes true if signup process is successful

class AuthProvider {
  AuthProvider._();

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static CollectionReference usersCollection = db.collection('users');

  ///used when verifiying the verification code (SMS Message)
  static String? verificationId;

  /// the phone number must begin with '+' (with internationl code)
  static Future<void> signUpService(String phoneNumber, String name) async {
    /// used to check if the user have an account
    final User? user = await UserProvider.getUserInfo(phoneNumber);

    /// if user alreay exists
    if (user != null) {
      MySharedPref.storeUserData(
        id: user.uid,
        name: user.name,
        image: user.imageUrl,
        phone: user.phoneNumber,
      );

      CustomSnackBar.myCustomSnackBar(
        message: 'This number is already used',
      );

      Get.toNamed(Routes.SIGN_IN);
      return;
    }

    await verifyPhone(phoneNumber);
    MySharedPref.saveUser(await _createUserDoc(name, phoneNumber));
  }

  /// the phone number must begin with '+' (with internationl code)
  static Future<void> signInService(String phoneNumber) async {
    final User? user = await UserProvider.getUserInfo(phoneNumber);

    ///user does not exists (dont have an account)
    if (user == null) {
      CustomSnackBar.myCustomSnackBar(
        message: 'You dont have an account!',
      );

      /// if the user does not have an account
      Get.toNamed(Routes.SIGNUP);
      return;
    }

    MySharedPref.saveUser(user);
    await verifyPhone(phoneNumber);
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

  ///used when the user has signed up,
  ///to create a record for the user in the database
  static Future<User> _createUserDoc(String name, String phoneNumber) async {
    /// ensure that the user sign in process is completed
    /// by using loop with timer
    while (FirebaseAuth.instance.currentUser == null) {
      await Future.delayed(const Duration(seconds: 1));
    }

    final user = User(
      name: name,
      phoneNumber: phoneNumber,
      imageUrl: null,
      uid: FirebaseAuth.instance.currentUser!.uid,
      about: '',
      lastUpdated: DateTime.now(),
    );

    await usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).set(
          user.toMap(),
        );

    return user;
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
}
