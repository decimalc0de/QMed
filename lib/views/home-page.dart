import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_report/_misc/global-properties.dart';
import 'package:med_report/models/api-response.dart';
import 'package:med_report/views/widgets/nav-drawer-widget.dart';

class HomePage extends StatefulWidget {
  final ApiResponse? userData;

  const HomePage({Key? key, required this.userData, }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String title = "medA";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      drawer: NavigationDrawerWidget(userData: widget.userData?.miscellaneousData),
      // endDrawer: NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 1,
        // title: Text(title),
        shadowColor: primaryColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () { /*TODO*/ },
          ),
          const SizedBox(width: 10),
          const CircleAvatar(
            radius: 24,
            backgroundColor: Color.fromRGBO(30, 60, 168, 1),
            child: Icon(Icons.add_comment_outlined, color: Colors.white),
          ),
          const SizedBox(width: 15),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: isDarkMode ? darkColor0 : primaryColor
        ),
        backgroundColor: isDarkMode ? darkColor0 : primaryColor,
      ),
      body: Builder(
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            decoration:  BoxDecoration(
              color: isDarkMode ? darkColor0 : brightColor2,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              //TODO: replace text logo with your logo
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'medA',
                  style: GoogleFonts.poppins(
                    color: isDarkMode ? brightColor2 : darkColor1,
                    fontSize: size.height * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '+',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff3b22a1),
                    fontSize: size.height * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
