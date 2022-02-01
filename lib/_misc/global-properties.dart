import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:med_report/_request/http-interceptor.dart';

/*
* Notification Badge counter
*/
int nBadgeCounter = 0;

/*
* Number extension
*/
extension Range on num {
  bool isBetween(num inf, num sup) {
    return inf < this && this < sup;
  }
}

/*
* String extension
*/
extension StringExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

/*
* Colors
*/
const brightColor0 = Colors.white;
const brightColor2 = Color(0xffADA4A5);
const darkColor0 = Color(0xff151f2c);
const darkColor1 = Color(0xff1D1617);
const primaryColor = Color.fromRGBO(30, 60, 168, .9);

/*
* Request path
*/
const String host = 'http://192.168.43.185:8080/api';

/*
* Request Interceptor
*/
Client http = InterceptedClient.build(interceptors:[HttpInterceptor(),]);