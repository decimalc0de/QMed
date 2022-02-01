import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final NotificationService _notificationService = NotificationService._internal();
  // static const CHANNEL_NAME = 'medA';
  // static const CHANNEL_ID = '8080-185';
  // static const CHANNEL_DESCRIPTION = 'Treatment Alert';

  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  get onDidReceiveLocalNotification => null;

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: null
    );

    tz.initializeTimeZones();
    print('timeZoneName ${tz.getLocation('Europe/Zurich')}');
    // tz.setLocalLocation(tz.getLocation(Platform.localeName));

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: _selectNotification
    );

  }

  Future _selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }

}