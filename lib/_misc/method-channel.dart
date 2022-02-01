import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppMethodChannel {
  static const _methodChannel = MethodChannel(_channelName);
  static const String _channelName = "flutter.native/alarmManager";

  //
  static MethodChannel get currentChannel => _methodChannel;

  //
  static init() {
    _methodChannel.setMethodCallHandler((call) {
        switch(call.method) {
          case 'alarmUi': {
            alarmUi();
          }
          break;

          default: {/*TODO:*/}
        }
        return Future.value(_channelName) ;
      }
    );
  }

  //
  static void alarmUi() {
    Get.toNamed('/alarm');
  }

}