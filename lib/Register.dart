import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kase_app/main.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kase_app/register_repository.dart';
import 'package:kase_app/otp_code_repository.dart';
import 'package:kase_app/register_repository.dart';
// ignore: must_be_immutable
TextEditingController _fullName = TextEditingController();
TextEditingController _phoneNumber= TextEditingController();
TextEditingController _password = TextEditingController();
TextEditingController _conpassword = TextEditingController();
class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final OtpCodeRepository otpCodeRepository = OtpCodeRepository();
  final RegisterRepository registerRepository= RegisterRepository();
  @override
  void initState(){
    super.initState();
  }
  void dispose(){
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          child:Center(child:SingleChildScrollView(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('Welcome! to\n Kase App',style:TextStyle(color:Colors.green, fontWeight: FontWeight.bold,fontSize: 50)),
              Text('Sign Up here!'),
              SizedBox(height:10),
              TextFormField(
                controller: _fullName,
                decoration: InputDecoration(
                  border:OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, size: 30,),
                  hintText: "Full Name",
                  hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey
                  ),),),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneNumber,
                  decoration: InputDecoration(
                  border:OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_android_outlined, size: 30,),
                  hintText: "Phone Number",
                  hintStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.grey
                  ),

                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                  controller: _password,
                decoration: InputDecoration(
                  border:OutlineInputBorder(
                  ),
                  prefixIcon: Icon(Icons.lock, size: 30,),
                  hintText: "Password",
                  hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey
                  ),)),
              SizedBox(height: 10),
                TextFormField(
                  controller: _conpassword,
                  decoration: InputDecoration(
                  border:OutlineInputBorder(
                  ),
                  prefixIcon: Icon(Icons.lock, size: 30,),
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.grey
                  ),
                ),
              ),
              SizedBox(height: 10),
              RaisedButton(
                child:Text("Register"),

                color: Colors.green,
                textColor: Colors.white, onPressed: () {
                  if ( _conpassword.text == _password.text){
                    otpCodeRepository.getOtpCode(phone:_phoneNumber.text).then((response)=>{
                      if(!response.status) _showMyDialog(context, message: response.msg)
                    }
                        //  if(!response.status){
                        //   Navigator.pop(context),
                        //    print(response.data),
                        //    print(response.status),
                        //
                        // }
                        //  else print(response.data)}
                       /* else
                          // registerRepository.register(user( "2234",response.data))*/

                     );
                  }
                  else
                    print("not match");
                   }
              ),],),),)));
  }
}

Map <String,dynamic> user(String vCode,String vId) {
  var data = {
    'name': _fullName ,
    'password': _password,
    'phone': _phoneNumber,
    'requestId': vId ,
    'verifyCode': vCode,
  };
  return data;

}

Future<void> _showMyDialog(BuildContext context, {String message}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Login Failed !'),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text(message ?? ''),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

/*createData () async {
  var fullName= _fullName.text;
  var phoneNumber= _phoneNumber.text;
  var password = _password.text;
  //var conpassword = _conpassword.text;

  var data = jsonEncode(
        { "phone": phoneNumber,
          "full_name":fullName,
          "password": password,
          'fcm_token':"test",
          'device_type':"Android",
        }
         );
  var header={
    "Content-Type": "application/json",
    "Accept": "application/json"
  };
  var url = Uri.parse("https://apidev.chabhuoy.online/api/register");
  var response = await http.post(url,headers: header,body: data);
  if(response.statusCode==200)
    print("Successful");
  else
    print("Error");

}*/


