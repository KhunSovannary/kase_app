import 'package:flutter/src/widgets/editable_text.dart';
import 'package:kase_app/model/response%20model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class OtpCodeRepository {

  Future<ResponseModel> getOtpCode( {String phone}) async {
    try {
      final response = await http.post(
        Uri.parse("https://kasefarm1.kasegro.com/api/get-otp-code"),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': phone,
        }),
      );
      return ResponseModel.fromJson(
          jsonDecode(response.body),
          response.statusCode == 200 ?
          jsonDecode(response.body)['data']['verify_request_id'] : 0,
          response.statusCode);
    } catch (e) {
      throw Exception('Opp there an error:$e');
    }
  }

}