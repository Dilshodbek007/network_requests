

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:network_request_openbudget/user2_detail.dart';
import 'package:network_request_openbudget/user_detail.dart';

class NetworkRequests {
  // 1
  static const base = 'admin.openbudget.uz';
  static Map<String, String> header = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  //api
  static String apiPost = '/api/v1/user/validate_phone/';

  static Future<String?> POST(String api, Map<String?, String?> params) async {
    var uri = Uri.https(base, api);
    var response = await post(uri, headers: header, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    print(response.body + ': response.body');
    print('${response.reasonPhrase}: reasonphrase');
    return null;
  }

  // http params

  static Map<String, String> paramsCreate(User user) {
    Map<String, String> params = {};
    params.addAll({
      'application': '78233',
      'phone': user.phone
    });
    return params;
  }
}


//2
class NetworkRequest2{
  static const base='admin.openbudget.uz';
  static Map<String, String> header = {
    'Content-type': 'application/json; charset=UTF-8'
  };
  //api
  static String apiSMS = '/api/v1/user/temp/vote/';
  static Future<String?> POST(String api, Map<String?, String?> params) async {
try {
  var uri = Uri.https(base, api);
  var response = await post(uri, headers: header, body: jsonEncode(params));
  if (response.statusCode == 200 || response.statusCode == 201) {
    return response.body;
  }
  print('response.status code: '+response.statusCode.toString());
  print('${response.reasonPhrase}: reasonphrase');
}catch(e){
  print('xatolarin $e');
}

    return 'null';               //shuni qaytaryaptikan

  }
  // http params
  static Map<String?,String?> paramsCreateSMS(User2 user2){
    Map<String, String?> params={};
    params.addAll({
      'application':'78233',
      'otp':user2.otp,
      'phone':user2.phone,
      'token':user2.token,
    });
    return params;
  }

}



// "https://admin.openbudget.uz/api/v1/user/temp/vote/";