import 'package:kase_app/response model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class OtpCodeRepository {

  Future<ResponseModel> getOtpCode({String phone}) async {
    try {
      final response = await http.post(
        Uri.parse("https://apidev.chabhuoy.online/api/get-otp-code"),
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