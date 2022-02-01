import 'dart:convert';
import 'package:http/http.dart';
import 'package:med_report/_misc/global-properties.dart';
import 'package:med_report/models/api-response.dart';

import 'http-exception.dart';

Future<ApiResponse> _counsel(diagnosis) async {
  try{
    /*
     * Request Url
     */
    var uri = Uri.parse(host + '/v1/counsel?diagnosis=$diagnosis');
    /*
     * Get Request
     */
    Response response = await http.get(uri);
    /*
    * Decode response body into ApiResponse object
    */
    return ApiResponse.fromJson(jsonDecode(response.body));
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

Future<ApiResponse> counsel(diagnosis) async{
  return await
    _counsel(diagnosis).then((value) { return value; })
                        .catchError((error){
                          return ApiResponse(success: false, message: error.message);
                        });
}
