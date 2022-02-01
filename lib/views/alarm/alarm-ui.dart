
import 'package:flutter/material.dart';
import 'package:med_report/views/alarm/theme_data.dart';
import 'package:provider/provider.dart';

import 'alarm_page.dart';
import 'clock_page.dart';
import 'data.dart';
import 'enums.dart';
import 'menu_info.dart';

class AlarmUi extends StatefulWidget {
  const AlarmUi({Key? key}) : super(key: key);
  @override
  _AlarmUiState createState() => _AlarmUiState();
}

class _AlarmUiState extends State<AlarmUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),
          VerticalDivider(
            color: CustomColors.dividerColor,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget? child) {
                if (value.menuType == MenuType.clock) {
                  return ClockPage();
                } else if (value.menuType == MenuType.alarm) {
                  return AlarmPage();
                } else {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('TODO', style: TextStyle(fontSize: 20, color: Colors.white70)),
                        Text(value.title ?? '', style: TextStyle(fontSize: 48, color: Colors.white70)),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
            primary: currentMenuInfo.menuType == value.menuType
                                    ? CustomColors.menuBackgroundColor
                                    : Colors.transparent,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(32))
            ),
          ),
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                currentMenuInfo.imageSource ?? '',
                scale: 1.5,
              ),
              const SizedBox(height: 16),
              Text(
                currentMenuInfo.title ?? '',
                style: TextStyle(
                    fontFamily: 'avenir',
                    color: CustomColors.primaryTextColor,
                    fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
