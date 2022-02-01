
// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertMessage {
  final message;

  AlertMessage(this.message);

  static get({
    required message,
    String? title,
    Color background = Colors.redAccent,
    Color foreground = Colors.white}) {
    /*
     * Close current snack-bar b4 opening new one
     */
    if(Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.snackbar(
      '', '',
      borderRadius: 4,
      colorText: foreground,
      backgroundColor: background,
      // borderColor: darken(background)
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(minutes: 10),

      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      dismissDirection: DismissDirection.horizontal,

      titleText: title != null ?
        Text(
          title,
          style: TextStyle(
            color: foreground,
          )
        ) : Container(),
      messageText:
        Text(
          message,
          style: TextStyle(
            color: foreground
          ),
        ),
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    );
  }

  static show({required context, required message, required size, color}) {
    bool showSwipeIndicator = false;
    FocusManager.instance.primaryFocus?.unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: size.width,
        elevation: 1000,
        content: InkWell(
          onTap: (){
            context.setState(() {
              print('InkWell space');
              showSwipeIndicator = true;
            });
          },
          child: Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.topLeft,
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  //color: Colors.white,
                  decoration: BoxDecoration(
                      color: color ?? Colors.redAccent,
                      border: Border.all(
                          width: 1.0,
                          color: color ?? Colors.red
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:10, horizontal: 15),
                    child: Text(message),
                  ),
                ),
                showSwipeIndicator ? Image.asset('asset/img/swipe.gif'):Container(),
              ],
            ),
          ),
        ),
        duration: const Duration(seconds: 1500),
        backgroundColor: Colors.transparent.withAlpha(100),
        behavior: SnackBarBehavior.floating,
      )
    );
  }
}