import 'dart:io' show Platform;

import 'package:flutter/services.dart';

class AlarmManager {
  static const platform = MethodChannel('flutter.native/alarmManager');

  static void init() async {
    if(Platform.isAndroid) {
      final String result = await  platform.invokeMethod(
          'scheduleAlarm', {'interval': 1 /*minute*/,}
      );
      print(result);
    }
  }

}