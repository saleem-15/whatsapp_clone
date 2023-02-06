import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:whatsapp_clone/app/api/user_api.dart';
import 'package:whatsapp_clone/app/models/messages/message_interface.dart';
import 'package:whatsapp_clone/storage/database/daos/messages_dao.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import 'awesome_notifications_helper.dart';

class FcmHelper {
  // prevent making instance
  FcmHelper._();

  // FCM Messaging
  static late FirebaseMessaging messaging;

  /// this function will initialize firebase and fcm instance
  static Future<void> initFcm() async {
    while (!MySharedPref.getIsMyDocExists) {
      await Future.delayed(const Duration(seconds: 10));
    }

    try {
      // initialize fcm and firebase core
      await Firebase.initializeApp();

      // initialize firebase
      messaging = FirebaseMessaging.instance;

      // notification settings handler
      await _setupFcmNotificationSettings();

      // generate token if it not already generated and store it on shared pref
      await _generateFcmToken();

      // background and foreground handlers
      FirebaseMessaging.onMessage.listen((event) => _fcmForegroundHandler);
      FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
    } on FirebaseException catch (error) {
      // if you are connected to firebase and still get error
      // check the todo up in the function else ignore the error
      // or stop fcm service from main.dart class
      Logger().e(error);
    }
  }

  ///handle fcm notification settings (sound,badge..etc)
  static Future<void> _setupFcmNotificationSettings() async {
    //show notification with sound and badge
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    //NotificationSettings settings
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
    );
  }

  /// generate and save fcm token if its not already generated (generate only for 1 time)
  static Future<void> _generateFcmToken() async {
    try {
      var token = await messaging.getToken();
      if (token != null) {
        MySharedPref.setFcmToken(token);
        _sendFcmTokenToServer();
      } else {
        // retry generating token
        await Future.delayed(const Duration(seconds: 5));
        _generateFcmToken();
      }
    } on FirebaseException catch (error) {
      Logger().e(error);
    }
  }

  /// this method will be triggered when the app generate fcm
  /// token successfully
  static _sendFcmTokenToServer() {
    UserApi.setUserFcmToken();
  }

  // Without this annotaion the code may not work correctly
  // for details go to:  https://stackoverflow.com/a/67083337
  @pragma('vm:entry-point')
  static Future<void> _fcmBackgroundHandler(RemoteMessage remoteMessage) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    final msg = MessageInterface.fromNotificationPayload(remoteMessage.data);
    await MessagesDao.addMsg(msg);

    log("Handling a background message:");
    _logNotification(remoteMessage);
    AwesomeNotificationsHelper.showNotification(
      id: 1,
      title: remoteMessage.notification?.title ?? 'Title',
      body: remoteMessage.notification?.body ?? 'Body',
      payload: remoteMessage.data.cast(),
    );
  }

  ///To handle messages while your application is in the foreground
  static void _fcmForegroundHandler(RemoteMessage remoteMessage) {
    Logger().d('Got a message in the foreground!');
    _logNotification(remoteMessage);

    AwesomeNotificationsHelper.showNotification(
      id: 1,
      title: remoteMessage.notification?.title ?? 'Title',
      body: remoteMessage.notification?.body ?? 'Body',
      payload: remoteMessage.data.cast(),
    );
  }

  static void _logNotification(RemoteMessage message) {
    Logger().d(
        'title: ${message.notification?.title}\nbody: ${message.notification?.body}\nMessage data: ${message.data}');
  }
}
