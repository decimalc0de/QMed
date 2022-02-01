import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpInterceptor implements InterceptorContract {

  Future<Map<String, String>> _getHeaders() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var authToken = sharedPref.getString("authorization");
    if(authToken != null) {
      return {
        'Authorization': authToken,
      };
    }
    throw Exception("No cached auth token found");
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if(true) {
      await _getHeaders().then(
        (value) {
          data.headers.addAll(value);
          data.headers["Content-Type"] = "application/json; charset=UTF-8";
        }
      )
      .catchError((error){print(error.message);});
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    var _authHeader = data.headers!["authorization"];
    if(_authHeader != null) {
      SharedPreferences _sharedPref = await SharedPreferences.getInstance();
      _sharedPref.setString("authorization", _authHeader);
    }
    return data;
  }

}