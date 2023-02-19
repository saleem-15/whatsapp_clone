import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

import '../config/translations/localization_service.dart';

class MySharedPref {
  // get storage
  static late final GetStorage _storage;

  // STORING KEYS
  static const String _currentLocalKey = 'current_local';

  // static const String _userId = 'user_id';
  // static const String _name = 'user_name';
  static const String _phone = 'user_phone';
  // static const String _image = 'user_image';
  // static const String _userLastUpdated = 'user_last_updated';
  // static const String _about = 'user_about';
  static const String _fcmToken = 'Fcm_Token';
  static const String _isUserDocExists = 'is_user_doc_exists';

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

  static bool get getIsMyDocExists => _storage.read(_isUserDocExists) ?? false;
  static void setIsMyDocExists(bool isUserDocExists) => _storage.write(_isUserDocExists, isUserDocExists);

  // static String? get getUserId => _storage.read(_userId);
  // static void setUserId(String userId) => _storage.write(_userId, userId);
  // static void deleteUserId() => _storage.remove(_userId);

  static String? get getIsFcmTokenSent => _storage.read(_fcmToken);
  static void setIsFcmTokenSent(String fcmToken) => _storage.write(_fcmToken, fcmToken);

  static String? get getFcmToken => _storage.read(_fcmToken);
  static void setFcmToken(String userName) => _storage.write(_fcmToken, userName);

  // static String? get getUserName => _storage.read(_name);
  // static void setUserName(String userName) => _storage.write(_name, userName);
  // static void deleteUserName() => _storage.remove(_name);

  static String? get getUserPhoneNumber => _storage.read(_phone);
  static void setUserPhoneNumber(String phoneNumber) => _storage.write(_phone, phoneNumber);
  static void deleteUserPhoneNumber() => _storage.remove(_phone);

  // static String? get getUserAbout => _storage.read(_about);
  // static void setUserAbout(String about) => _storage.write(_about, about);
  // static void deleteUserAbout() => _storage.remove(_about);

  // static DateTime? get getLastUpdated => DateTime.parse(_storage.read(_userLastUpdated));
  // static void setLastUpdated(DateTime lastUpdated) =>
  //     _storage.write(_userLastUpdated, lastUpdated.toIso8601String());
  // static void deleteLastUpdated() => _storage.remove(_userLastUpdated);

  ///returnes the path that the user image was stored in.
  ///
  ///returnes null if the user dont have an image
  // static String? get getUserImage => _storage.read(_image);

  ///Takes the image path as a paramater
  // static void setUserImage(String? image) {
  //   if (image != null) {
  //     _storage.write(_image, image);
  //   }
  // }

  // static void deleteUserImage() => _storage.remove(_image);

  // static User? get getUserData {
  //   final String? userId = MySharedPref.getUserId;

  //   if (userId == null) {
  //     log('there is no stored data about the user');
  //     return null;
  //   }

  //   final user = Get.find<UsersProvider>().me!;

  //   return User.normal(
  //     uid: userId,
  //     name: user.name,
  //     imageUrl: 'getUserImage',
  //     phoneNumber: getUserPhoneNumber!,
  //     lastUpdated: getLastUpdated ?? DateTime.now(),
  //     bio: getUserAbout ?? 'this text comes from storage',
  //   );
  // }

  // /// Used when signup
  // static void storeUserData({
  //   required String id,
  //   required String name,
  //   required String? image,
  //   required String phone,
  // }) {
  //   MySharedPref.setUserId(id);
  //   MySharedPref.setUserName(name);
  //   MySharedPref.setUserImage(image);
  //   MySharedPref.setUserPhoneNumber(phone);
  // }

  // static void updateUserData({
  //   String? name,
  //   String? image,
  //   String? phone,
  //   String? about,
  // }) {
  //   if (name != null) {
  //     MySharedPref.setUserName(name);
  //   }

  //   if (image != null) {
  //     MySharedPref.setUserImage(image);
  //   }

  //   if (phone != null) {
  //     MySharedPref.setUserPhoneNumber(phone);
  //   }
  //   if (about != null) {
  //     MySharedPref.setUserAbout(about);
  //   }
  // }

  // static void deleteUser() {
  //   deleteUserId();
  //   deleteUserName();
  //   deleteUserImage();
  //   deleteUserPhoneNumber();
  // }

  // static void saveUser(User user) {
  //   setUserId(user.uid);
  //   setUserName(user.name);
  //   setUserImage(user.imageUrl);
  //   setUserPhoneNumber(user.phoneNumber);
  // }

  static Future<void> clearAllData() {
    return _storage.erase();
  }

  /// each chat has a counter, (used for file naming),
  /// this method retrives the counter.\
  /// the counter is `incremeted Automatically after each retrival`
  static int getChatCounter(String chatId, [bool incrementCounter = true]) {
    int counter = _storage.read(chatId) ?? 0;

    if (incrementCounter) {
      counter++;
      _storage.write(chatId, counter);
    }
    return counter;
  }
}
