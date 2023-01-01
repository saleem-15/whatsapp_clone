import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

import '../config/translations/localization_service.dart';
import '../app/models/user.dart';

class MySharedPref {
  // get storage
  static late final GetStorage _storage;

  // STORING KEYS
  static const String _currentLocalKey = 'current_local';

  static const String _userId = 'user_id';
  static const String _name = 'user_name';
  static const String _phone = 'user_phone';
  static const String _image = 'user_image';

  /// init get storage services
  static init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  /// save current locale
  static void setCurrentLanguage(String languageCode) => _storage.write(_currentLocalKey, languageCode);

  /// get current locale
  static Locale getCurrentLocal() {
    String? langCode = _storage.read(_currentLocalKey);
    // default language is english
    if (langCode == null) {
      return LocalizationService.defaultLanguage;
    }
    return LocalizationService.supportedLanguages[langCode]!;
  }

  //***************     User Data   ******************/
  static String? get getUserId => _storage.read(_userId);
  static void setUserId(String userId) => _storage.write(_userId, userId);

  static String? get getUserName => _storage.read(_name);
  static void setUserName(String userName) => _storage.write(_name, userName);

  static String? get getUserPhoneNumber => _storage.read(_phone);
  static void setUserPhoneNumber(String phoneNumber) => _storage.write(_phone, phoneNumber);

  static String? get getUserImage => _storage.read(_image);
  static void setUserImage(String? image) {
    if (image != null) {
      _storage.write(_image, image);
    }
  }

  static User? get getUserData {
    final String? userId = MySharedPref.getUserId;

    if (userId == null) {
      log('there is no stored data about the user');
      return null;
    }

    return User(
      uid: userId,
      name: MySharedPref.getUserName!,
      imageUrl: MySharedPref.getUserImage,
      phoneNumber: MySharedPref.getUserPhoneNumber!,
    );
  }

  /// Used when signup
  static void storeUserData({
    required String id,
    required String name,
    required String? image,
    required String phone,
  }) {
    MySharedPref.setUserId(id);
    MySharedPref.setUserName(name);
    MySharedPref.setUserImage(image);
    MySharedPref.setUserPhoneNumber(phone);
  }
  static void saveUser(User user) {
    MySharedPref.setUserId(user.uid);
    MySharedPref.setUserName(user.name);
    MySharedPref.setUserImage(user.imageUrl);
    MySharedPref.setUserPhoneNumber(user.phoneNumber);
  }

  static void clearAllData() {
    _storage.erase();
  }
}
