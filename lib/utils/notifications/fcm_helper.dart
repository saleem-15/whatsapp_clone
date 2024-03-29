import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:whatsapp_clone/app/api/user_api.dart';
import 'package:whatsapp_clone/app/models/messages/message.dart';
import 'package:whatsapp_clone/config/routes/app_pages.dart';
import 'package:whatsapp_clone/storage/database/daos/chats_dao.dart';
import 'package:whatsapp_clone/storage/database/database.dart';
import 'package:whatsapp_clone/storage/my_shared_pref.dart';

import 'awesome_notifications_helper.dart';
import '../../storage/database/daos/messages_dao.dart';

class FcmHelper {
  FcmHelper._();

  static late FirebaseMessaging messaging;

  /// this function will initialize firebase and fcm instance
  static Future<void> initFcm() async {
    await AwesomeNotificationsHelper.init();

    try {
      // initialize fcm and firebase core
      await Firebase.initializeApp();

      // initialize firebase
      messaging = FirebaseMessaging.instance;

      // notification settings handler
      // await _setupFcmNotificationSettings();

      // generate token if it not already generated and store it on shared pref
      await _generateFcmToken();

      // background and foreground handlers
      FirebaseMessaging.onMessage.listen(_fcmForegroundHandler);
      FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
      // FirebaseMessaging.onMessage.listen((event) => _fcmForegroundHandler(event));
      // FirebaseMessaging.onBackgroundMessage((message) => _fcmBackgroundHandler(message));

      /// handle any interaction when the app is in the background
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        Logger().i('Notificaation is pressed');
        _handleMessage(event);
      });

      await setupInteractedMessage();
    } on FirebaseException catch (error) {
      // if you are connected to firebase and still get error
      // check the todo up in the function else ignore the error
      // or stop fcm service from main.dart class
      Logger().e(error);
    }
  }

  /// generate and save fcm token if its not already generated (generate only for 1 time)
  static Future<void> _generateFcmToken() async {
    final storedToken = MySharedPref.getFcmToken;

    if (storedToken == null) {
      final token = await messaging.getToken();

      MySharedPref.setFcmToken(token!);
      UserApi.setUserFcmToken(token);
    }

    messaging.onTokenRefresh.listen((newToken) {
      Logger().e(newToken);
      MySharedPref.setFcmToken(newToken);
      UserApi.setUserFcmToken(newToken);
    });

    // try {
    //   var token = await messaging.getToken();
    //   final storedToken = MySharedPref.getFcmToken;
    //   Logger().e(token);
    //   bool isNewToken = storedToken != token;
    //   log('isNewToken: $isNewToken');

    //   if (token != null && isNewToken) {
    //     MySharedPref.setFcmToken(token);
    //     UserApi.setUserFcmToken(token);
    //   } else {
    //     // retry generating token
    //     await Future.delayed(const Duration(seconds: 5));
    //     _generateFcmToken();
    //   }
    // } on FirebaseException catch (error) {
    //   Logger().e(error);

    //   FirebaseCrashlytics.instance.recordError(error, error.stackTrace);
    // }
  }

  // Without this annotaion the code may not work correctly
  // for details go to:  https://stackoverflow.com/a/67083337
  @pragma('vm:entry-point')
  static Future<void> _fcmBackgroundHandler(RemoteMessage remoteMessage) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `Firebase.initializeApp()` before using other Firebase services.
    log("Handling a background message");
    _logNotification(remoteMessage);

    await _saveMessageToDatabse(remoteMessage);

    // _handleMessage(remoteMessage);

    showMessageNotification(remoteMessage);
  }

  static void showMessageNotification(RemoteMessage remoteMessage) {
    final payload = remoteMessage.data;

    final title = payload[Message.SENDER_NAME_KEY];

    String body;

    // Set notification body based on message type
    switch (payload[Message.MESSAGE_TYPE_KEY]) {
      case 'text':
        body = payload['text'];
        break;
      case 'image':
        body = 'Photo';
        break;
      case 'video':
        body = 'Video';
        break;
      case 'audio':
        body = 'Audio';
        break;
      case 'file':
        body = 'File';
        break;
      default:
        body = 'New message';
    }

    AwesomeNotificationsHelper.showNotification(
      id: 1,
      title: remoteMessage.notification?.title ?? title,
      body: remoteMessage.notification?.body ?? body,
      channelKey: NotificationChannels.chatChannelKey,
      // groupKey: NotificationChannels.chatChannelGroupKey,
      payload: remoteMessage.data.cast(),
    );
  }

  ///To handle messages while your application is in the foreground
  static Future<void> _fcmForegroundHandler(RemoteMessage remoteMessage) async {
    Logger().d('Got a message in the foreground!');
    _logNotification(remoteMessage);

    await _saveMessageToDatabse(remoteMessage);

    showMessageNotification(remoteMessage);
  }

  static Future<void> _saveMessageToDatabse(RemoteMessage remoteMessage) async {
    try {
      await MyDataBase.openDatabase();
      final msg = Message.fromNotificationPayload(remoteMessage.data);
      await MessagesDao.addMsg(msg);
    } on Exception catch (e) {
      Logger().e(e);
    }
  }

  // It is assumed that all messages contain a data field with the key 'type'
  static Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  static Future<void> _handleMessage(RemoteMessage message) async {
    Logger().i('Notification is pressed ${message.data}');

    final messageChatId = message.data[Message.CHAT_ID_KEY];

    final chat = await ChatsDao.getChatByMyId(messageChatId);
    Get.toNamed(
      Routes.CHAT_SCREEN,
      arguments: chat!,
    );
  }

  static void _logNotification(RemoteMessage message) {
    debugPrint(
      '''sound:${message.notification?.android?.sound}
title: ${message.notification?.title}
body: ${message.notification?.body}
Message data: ${message.data}''',
    );
  }
}
