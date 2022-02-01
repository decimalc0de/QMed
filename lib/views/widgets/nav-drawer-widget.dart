import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_report/_misc/global-properties.dart';
import 'package:med_report/_request/counsel-request.dart';
import 'package:med_report/views/consultants/consultant-page.dart';

import 'alert-message.dart';

class NavigationDrawerWidget extends StatelessWidget {

  final Map<String, dynamic>? userData;
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  const NavigationDrawerWidget({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = userData != null ? userData!['original-name']:'';
    final email = userData != null ? '${userData!['email']}':'';
    final urlImage = 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
    // const Color.fromRGBO(50, 75, 205, 1)
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Drawer(
      child: Material(
        color: isDarkMode ? darkColor0 : primaryColor,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              username: email,
              onClicked: () {
                // TODO:
              },
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildSearchField(),
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Profile',
                    leading: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 6),
                  buildMenuItem(
                    text: 'Medical History',
                    leading: Icons.history_toggle_off_sharp,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 6),
                  buildMenuItem(
                    text: 'Notifications',
                    leading: Icons.notifications_outlined,
                    trailing: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      constraints: const BoxConstraints(
                        maxWidth: 24,
                        maxHeight: 24,
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          '99+',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      )
                    ),
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 6),
                  buildMenuItem(
                    text: 'Disclaimer',
                    leading: Icons.warning_amber_outlined,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Settings',
                    leading: Icons.settings,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 5),
                  buildMenuItem(
                    text: 'Log out',
                    leading: Icons.power_settings_new,
                    onClicked: () => selectedItem(context, 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String username,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 20)),
          child: Column(
            children: [
              CircleAvatar(radius: 50, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 18, color: Colors.white,),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      username,
                      style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    const color = Colors.white;

    return TextField(
      onSubmitted: (diagnosis) {
        counsel(diagnosis.toLowerCase()).then((apiResponse) {
          if(apiResponse.success){
            Get.to(() => CounsellorsInfo(counselData: apiResponse.miscellaneousData));
            print(apiResponse.miscellaneousData);
          }
          else{
            AlertMessage.get(message: apiResponse.message);
          }
        });
      },
      textInputAction: TextInputAction.go,
      style: const TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData leading,
    Widget? trailing,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(leading, color: color),
      trailing: trailing,
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        // Nav to Page
        break;
      case 1:
      // Nav to Page
        break;
    }
  }
}
