import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:med_report/_misc/global-properties.dart';
import 'package:med_report/models/api-response.dart';

import 'http-exception.dart';

Future<ApiResponse> _login(username, password) async {
  try{

    /*
     * Request Url
     */
    var uri = Uri.parse(host + '/sign-in');
    /*
     * Request Header
     */
    var header = <String, String>{'Content-Type': 'application/json; charset=UTF-8'};
    /*
     * Request Body
     */
    var body = jsonEncode(<String, String>{'username': username, 'password': password});
    /*
     * Post Request
     */
    Response response = await http.post(uri, headers: header, body: body);
    /*
    * Decode response body into ApiResponse object
    */
    return ApiResponse.fromJson(jsonDecode(response.body));
  }
  /*
   * SocketException:
   * Usually thrown when there is no network
   */
  on SocketException catch(e) {
    throw const ApiHttpException("No internet connection, try again later");
  }
  /*
   * SocketException:
   * Usually thrown when there is no network
   */
  on FormatException catch(e) {
    throw const ApiHttpException("Bad response format, try again later");
  }
  /*
   * Other errors arising
   */
  on Object {
    // ignore: prefer_const_constructors
    throw ApiHttpException("An unexpected Error occurred, try again later");
  }

}

Future<ApiResponse> login(username, password) async{
  return await
  _login(username, password).then((value) { return value; })
                            .catchError((error){
                              return ApiResponse(success: false, message: error.message);
                            });
}

