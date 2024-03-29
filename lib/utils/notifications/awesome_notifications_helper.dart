import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/storage/database/daos/chats_dao.dart';
import 'package:whatsapp_clone/storage/database/database.dart';
import 'package:whatsapp_clone/utils/exceptions/chat_exceptions.dart';

import '../../config/routes/app_pages.dart';

var chatChannel = NotificationChannel(
  channelGroupKey: NotificationChannels.chatChannelGroupKey,
  channelKey: NotificationChannels.chatChannelKey,
  channelName: NotificationChannels.chatChannelName,
  groupKey: NotificationChannels.chatGroupKey,
  channelDescription: NotificationChannels.chatChannelDescription,
  defaultColor: Colors.green,
  ledColor: Colors.white,
  channelShowBadge: true,
  playSound: true,
  importance: NotificationImportance.High,
);

var generalChannel = NotificationChannel(
  channelGroupKey: NotificationChannels.generalChannelGroupKey,
  channelKey: NotificationChannels.generalChannelKey,
  channelName: NotificationChannels.generalChannelName,
  groupKey: NotificationChannels.generalGroupKey,
  channelDescription: NotificationChannels.generalChannelDescription,
  defaultColor: Colors.green,
  ledColor: Colors.white,
  channelShowBadge: true,
  playSound: true,
  importance: NotificationImportance.High,
);

class AwesomeNotificationsHelper {
  AwesomeNotificationsHelper._();

  // Notification lib
  static final awesomeNotifications = AwesomeNotifications();

  /// initialize local notifications service, create channels and groups
  /// setup notifications button actions handlers
  static init() async {
    // request permission to show notifications
    await awesomeNotifications.requestPermissionToSendNotifications();
    // initialize local notifications
    await _initNotification();

    // await awesomeNotifications.setChannel(chatChannel);
    // await awesomeNotifications.setChannel(generalChannel);

    // list when user click on notifications
    listenToActionButtons();
  }

  /// when user click on notification or click on button on the notification
  static listenToActionButtons() {
    // Only after at least the action method is set, the notification events are delivered
    awesomeNotifications.setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod);
  }

  ///init notifications channels
  static _initNotification() async {
    await awesomeNotifications.initialize(
      // null mean it will show app icon on the notification (status bar)
      null,
      [
        NotificationChannel(
          channelGroupKey: NotificationChannels.generalChannelGroupKey,
          channelKey: NotificationChannels.generalChannelKey,
          channelName: NotificationChannels.generalChannelName,
          groupKey: NotificationChannels.generalGroupKey,
          channelDescription: NotificationChannels.generalChannelDescription,
          defaultColor: Colors.green,
          ledColor: Colors.white,
          channelShowBadge: true,
          playSound: true,
          importance: NotificationImportance.Max,
        ),
        NotificationChannel(
          channelGroupKey: NotificationChannels.chatChannelGroupKey,
          channelKey: NotificationChannels.chatChannelKey,
          channelName: NotificationChannels.chatChannelName,
          groupKey: NotificationChannels.chatGroupKey,
          channelDescription: NotificationChannels.chatChannelDescription,
          defaultColor: Colors.green,
          ledColor: Colors.white,
          channelShowBadge: true,
          playSound: true,
          importance: NotificationImportance.Max,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: NotificationChannels.generalChannelGroupKey,
          channelGroupName: NotificationChannels.generalChannelGroupName,
        ),
        NotificationChannelGroup(
          channelGroupKey: NotificationChannels.chatChannelGroupKey,
          channelGroupName: NotificationChannels.chatChannelGroupName,
        )
      ],
      debug: true,
    );
  }

  //display notification for user with sound
  static showNotification(
      {required String title,
      required String body,
      required int id,
      String? channelKey,
      String? groupKey,
      NotificationLayout? notificationLayout,
      String? summary,
      List<NotificationActionButton>? actionButtons,
      Map<String, String>? payload,
      String? largeIcon}) async {
    awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        awesomeNotifications.requestPermissionToSendNotifications();
      } else {
        // u can show notification
        awesomeNotifications.createNotification(
          content: NotificationContent(
            id: id,
            title: title,
            body: body,
            groupKey: groupKey ?? NotificationChannels.generalGroupKey,
            channelKey: channelKey ?? NotificationChannels.generalChannelKey,
            showWhen: true, // Hide/show the time elapsed since notification was displayed
            payload: payload, // data of the notification (it will be used when user clicks on notification)
            notificationLayout: notificationLayout ??
                NotificationLayout
                    .Default, // notification shape (message,media player..etc) For ex => NotificationLayout.Messaging
            autoDismissible: true, // dismiss notification when user clicks on it
            summary:
                summary, // for ex: New message (it will be shown on status bar before notificaiton shows up)
            largeIcon:
                largeIcon, // image of sender for ex (when someone send you message his image will be shown)
          ),
          actionButtons: actionButtons,
        );
      }
    });
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {}

  /// this method is called when a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {}

  /// this method called if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {}

  @pragma("vm:entry-point")
  // handle clicking on notification  or action button or action button
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    final payload = receivedAction.payload!;

    await MyDataBase.openDatabase();
    final chat = await ChatsDao.getChatByMyId(payload['chatId']!);

    if (chat == null) {
      FirebaseCrashlytics.instance.recordError(
        ChatException.chatDoesNotExists(),
        StackTrace.current,
      );
      return;
    }

    /// go to chat screen (that the message has come from)
    Get.key.currentState?.pushNamed(
      Routes.CHAT_SCREEN,
      arguments: chat,
    );
  }
}

class NotificationChannels {
  // chat channel (for messages only)
  static String get chatChannelKey => "chat_channel";
  static String get chatChannelName => "Chat channel";
  static String get chatGroupKey => "chat group key";
  static String get chatChannelGroupKey => "chat_channel_group";
  static String get chatChannelGroupName => "Chat notifications channels";
  static String get chatChannelDescription => "Chat notifications channels";

  // general channel (for all other notifications)
  static String get generalChannelKey => "general_channel";
  static String get generalGroupKey => "general group key";
  static String get generalChannelGroupKey => "general_channel_group";
  static String get generalChannelGroupName => "general notifications channel";
  static String get generalChannelName => "general notifications channels";
  static String get generalChannelDescription => "Notification channel for general notifications";
}
