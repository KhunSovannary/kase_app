import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:kase_app/model/response_model.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class RegisterRepository with ChangeNotifier{
  Future<ResponseModel> register (Map<String,dynamic> user) async{
    try {
      final response = await http.post(Uri.parse("https://kasefarm1.kasegro.com/api/register"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode (<String, String>{
        'full_name': user['name'] ,
        'password': user['password'],
        'phone': user['phone'],
        'verified_request_id': user['requestId'],
        'verified_code': user ['verifyCode'],
        'fcm_token':'test',
        'device_type': 'android',
      }),);
      return ResponseModel.fromJson(jsonDecode(response.body),[],response.statusCode);
    }
      catch(e){
      throw Exception ("error");

      }
    }
  }
