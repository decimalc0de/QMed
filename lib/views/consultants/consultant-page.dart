import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_report/_misc/global-properties.dart';
import 'package:med_report/_platform/android/alarm-manager.dart';

class CounsellorsInfo extends StatefulWidget {
  final counselData;
  const CounsellorsInfo({Key? key, required this.counselData}) : super(key: key);

  @override
  _CounsellorsInfoState createState() => _CounsellorsInfoState();
}

class _CounsellorsInfoState extends State<CounsellorsInfo> {
  late Size size;
  late bool isDarkMode;
  late List<dynamic> data;
  @override
  Widget build(BuildContext context) {
    var _info = widget.counselData;
    size = MediaQuery.of(context).size;
    if(_info == null) return Container();
    data = <dynamic>[
      _info['name'].toString().toCapitalized(),
      _info['counsellor'].toString().toCapitalized(),
      _info['treatment'].join(', ').toString().toTitleCase(),
      _info['dosage']['Adult'],
      _info['dosage']['children'],
      _info['description'],
    ];
    var brightness = MediaQuery.of(context)
                                .platformBrightness;
    isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? darkColor0 : brightColor0,
        elevation: 2.0,
        iconTheme: IconThemeData(
          color: isDarkMode ? brightColor0 : darkColor0,
        ),
        systemOverlayStyle: isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? darkColor0 : brightColor0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                      radius: size.width * .22,
                      backgroundColor: Colors.amber,
                      backgroundImage: const AssetImage("assets/doctor4.png"),
                  ),

                  const SizedBox(width: 20,),

                  SizedBox(
                    width: size.width - 225,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data[1],
                          style: TextStyle(
                            fontSize: size.width * .1,
                            color: isDarkMode ? brightColor0 : darkColor0,
                          ),
                        ),
                        const Text(
                          "Health Specialist",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconTile(
                    backColor: const Color(0xffFFECDD),
                    imgAssetPath: "assets/email.png",
                  ),
                  IconTile(
                    backColor: const Color(0xffFEF2F0),
                    imgAssetPath: "assets/call.png",
                  ),
                  IconTile(
                    backColor: const Color(0xffEBECEF),
                    imgAssetPath: "assets/video_call.png",
                  ),
                ],
              ),
              counselModelElement(
                'About',
                "${data[1]} is a health specialist in Nashville & "
                    "affiliated with multiple hospitals in the  area. "
                    "He received his medical degree from Duke University "
                    "School of Medicine and has been in practice for more than 20 years. ",
                indent: 0
              ),
              counselModelElement('Prescribed Drugs', data[2]),
              counselModelDosage('Dosage'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Diagnosis :-\t',
                    style: TextStyle(
                      fontSize: size.width * .07,
                      color: isDarkMode ? brightColor0 : darkColor0,
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(data[0], style: TextStyle(fontSize: 18, color: Colors.amber.shade900)),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Container(
                width: size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                  color: isDarkMode ? darkColor0 : brightColor0,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0)
                  ),
                ),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Reminder",
                      style: TextStyle(
                        color: isDarkMode ? brightColor0 : darkColor0,
                        fontSize: size.width * .05,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(height: 30,),
                    SizedBox(
                      height: 50,
                      width: size.width - 20,
                      child: ElevatedButton.icon(
                        onPressed: (){
                          // NotificationService().setAlarm();
                          /*
                           * Start alarm here
                           */
                          AlarmManager.init();
                        },
                        icon: Icon(
                          Icons.notifications_active_outlined,
                          size: size.width * .08,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Start now', style: TextStyle(fontSize: size.width * .06)),
                        )
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }

  Column counselModelElement(title, content, {double? titleSize, double? indent}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: TextStyle(
            fontSize: titleSize ?? size.width * .07,
            color: isDarkMode ? brightColor0 : darkColor0,
          )
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(content, style: TextStyle(fontSize: size.width * .045, color: Colors.amber.shade900)),
            ),
          ],
        ),
      ],
    );
  }

  Column counselModelDosage(title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: TextStyle(
            fontSize: size.width * .07,
            color: isDarkMode ? brightColor0 : darkColor0,
          )
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.label_important_outline,
              color: isDarkMode ? brightColor0 : darkColor0,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'Children',
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkMode ? brightColor0 : darkColor0,
                  )
                ),
                Text('${data[4]}', style: TextStyle(color: Colors.green.shade800))
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.label_important_outline,
              color: isDarkMode ? brightColor0 : darkColor0,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adult',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode ? brightColor0 : darkColor0,
                    )
                  ),
                  Text(data[3], style: TextStyle(color: Colors.green.shade800),)
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

}


class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({required this.imgAssetPath, required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath,
          width: 20,
        ),
      ),
    );
  }
}
