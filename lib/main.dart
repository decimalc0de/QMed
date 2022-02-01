import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:med_report/views/alarm/alarm-ui.dart';
import 'package:med_report/views/alarm/enums.dart';
import 'package:med_report/views/alarm/menu_info.dart';
import 'package:med_report/views/auth/authentication-page.dart';
import 'package:med_report/views/consultants/consultant-page.dart';
import 'package:med_report/views/home-page.dart';
import 'package:provider/provider.dart';

import '_platform/alarm-notification.dart';
import '_misc/method-channel.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await NotificationService().init();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    AppMethodChannel.init();
    return GetMaterialApp(
      title: 'medA',
      initialRoute: '/auth',
      routes: {
        '/': (context) => const CounsellorsInfo(counselData: null),
        '/auth': (context) => const AuthPage(),
        '/index': (context) => const HomePage(userData: null),
        '/alarm': (context) => ChangeNotifierProvider<MenuInfo> (
          create: (_) => MenuInfo(MenuType.clock),
          builder: (context, widget) {
            return AlarmUi();
          },
        ),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
