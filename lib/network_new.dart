import 'dart:convert';

import 'package:http/http.dart';
import 'package:network_request_openbudget/user2_detail.dart';
import 'package:network_request_openbudget/user_detail.dart';

class Network1 {
  static String token='...';
  // 1
  static const base = 'admin.openbudget.uz';
  static Map<String, String> header = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  //api
  static String apiPost = '/api/v1/user/validate_phone/';

  static Future<String> method1(String api, Map<String?, String?> params) async {
    var uri = Uri.https(base, api);
    var response = await post(
      uri,
      headers: header,
      body: jsonEncode(params),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      token= response.body;
      return 'SMS Jo\'natildi';
    }
    return 'Ovoz berilgan';
  }

  // http params

  static Map<String, String> paramsCreate(User user) {
    Map<String, String> params = {};
    params.addAll({'application': '114350', 'phone': user.phone});
    return params;
  }
}

//2
class Network2 {
  static String token2='.';
  static const base = 'admin.openbudget.uz';
  static Map<String, String> header = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  //api
  static String apiSMS = '/api/v1/user/temp/vote/';

  static Future method2(String api, Map<String?, String?> params) async {
    var uri = Uri.https(base, api);
    var response = await post(uri, headers: header, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201){
        token2=jsonDecode(response.body);

      return 'Ovoz Berildi';
    }

    return 'Xato';
  }

  // http params
  static Map<String?, String?> paramsCreateSMS(User2 user2) {
    Map<String, String?> params = {};
    params.addAll({
      'application': '114350',
      'OTP': user2.OTP,
      'phone': user2.phone,
      'token': user2.token,
    });
    return params;
  }
}

