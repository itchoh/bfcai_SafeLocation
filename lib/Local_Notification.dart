import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse> streamController =
  StreamController();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  /// Request Notification Permission (Android 13+, iOS)
  static Future requestPermission() async {
    // ANDROID 13+ Permission
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }

    // iOS Permission
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future init() async {
    // Request permission BEFORE initializing
    await requestPermission();

    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static Future showBasicNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'default_channel_id',
      'Default Notifications',
      channelDescription: 'Basic alerts',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: android,
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      'Basic Notification',
      'This is your message.',
      details,
      payload: "data",
    );
  }
}
