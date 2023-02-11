import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  static init() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true, announcement: false, badge: true, carPlay: false, criticalAlert: false, provisional: false, sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) print('User granted permission');
    if (settings.authorizationStatus == AuthorizationStatus.provisional) print('User granted provisional permission');
    if (settings.authorizationStatus == AuthorizationStatus.denied) print('User declined or has not accepted permission');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: $message');
      _handleNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp: $message');
      _handleNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  static Future<void> _handleNotification(RemoteMessage message) async {
    print('handleNotification, ${message.data.toString()}');
    String title = message.notification?.title ?? '';
    String body = message.notification?.body ?? '';

    if (message.data.isNotEmpty) {
      title = title == '' ? message.data['title'] : title;
      body = body == '' ? message.data['body'] : body;
    }

    try {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
      const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
      final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();

      final InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      var androidPlatformChannelSpecifics = AndroidNotificationDetails('1', 'Notifications',
          channelDescription: 'App Notifications', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
      var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics, payload: 'Default_Sound');
    } catch (e) {
      print('myMessageHandlerERROR, ${e.toString()}');
    }
  }
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  if (Platform.isIOS) return;
  if (Platform.isAndroid) return;

  String title = message.notification?.title ?? '';
  String body = message.notification?.body ?? '';

  if (message.data.isNotEmpty) {
    title = title == '' ? message.data['title'] : title;
    body = body == '' ? message.data['body'] : body;
  }

  try {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails('1', 'Background Notifications',
        channelDescription: 'App Notifications', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics, payload: 'Default_Sound');
  } catch (e) {
    print('myBackgroundMessageHandlerERROR, ${e.toString()}');
  }
}
