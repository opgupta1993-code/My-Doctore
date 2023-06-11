import "dart:async";
import 'dart:convert';
import "dart:io";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static late final AndroidNotificationChannel _channel;

  static Future<void> setupFCMListener() async {
    // for ios only
    if (Platform.isIOS) {
      await _getPermissionsOnIOS();

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // debugPrint('Got a message whilst in the foreground!');
      // debugPrint('Message data: ${message.data}');

      if (message.notification != null && Platform.isAndroid) {
        // debugPrint('Message also contained a notification: ${message.notification}');
        _flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              // this is required parameter,
              // if we skip this, we will get errors and notification won't display
              icon: "ic_launcher",
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // debugPrint(
      //     'Got a message when app opened from bg state (not terminated)');
      // debugPrint('Message Data: ${message.data}');

      if (message.notification != null) {
        // debugPrint('Notification Data : ${message.notification?.title}');
        // debugPrint('Notification Data : ${message.notification?.body}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // available only for iOS
    // allows notifications to show even when app is in foreground
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await _setupLocalNotifications();
  }

  static Future<void> _getPermissionsOnIOS() async {
    final NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // debugPrint("User has granted notification permission!");
    } else {
      // debugPrint("User has not granted notification permission!");
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    // debugPrint("Handling a background message data : ${message.data}");
    // debugPrint(
    //     "Handling a background notification data: ${message.notification?.title}");
  }

  static Future<void> _setupLocalNotifications() async {
    _channel = const AndroidNotificationChannel(
      'homeshef_notification_channel', // id
      'Homeshef Notifications', // title
      importance: Importance.high,
    );

    _flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: const AndroidInitializationSettings("ic_launcher"),
        iOS: DarwinInitializationSettings(
          onDidReceiveLocalNotification: (_, __, ___, ____) {},
        ),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse val) {
        // debugPrint("Local Notification Clicked :::: $val");

        if (val.payload != null) {
          // ignore: unused_local_variable
          final Map<String, dynamic> data = jsonDecode(val.payload!);
        }
      },
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }
}
