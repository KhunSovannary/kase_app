
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kase_app/Register.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:kase_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


TextEditingController _phoneNumber = TextEditingController();
TextEditingController _passWord = TextEditingController();
// ignore: must_be_immutable
class SignIn extends StatefulWidget {



  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<Map<String, dynamic>> signIn (String phoneNumber, String password) async{
    final Map<String,dynamic> data = {
      'phone': phoneNumber,
      'password': password,
      'fcm_token':"test",
      'device_type':"Android",

    };
    var url = Uri.parse('https://apidev.chabhuoy.online/api/login');
    var jsonData;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post(url,body: data);
    print(jsonDecode(response.body));
    if(response.statusCode==200){
      print(response.body);
      jsonData= jsonDecode(response.body);
      setState(() {});

      sharedPreferences.setString("token",jsonData["token"]);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context)=>HomePage()),
              (Route<dynamic> route) => false);
    }
    else
      print(response.body);
  }
  @override

 Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          child:Center(child:SingleChildScrollView(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('Kase App',style:TextStyle(color:Colors.green, fontWeight: FontWeight.bold,fontSize: 50)),
              Text('Log in Your Account here!',style:TextStyle(fontSize: 20)),
              SizedBox(height:10),
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
                controller: _passWord,
                decoration: InputDecoration(
                  border:OutlineInputBorder(
                  ),
                  prefixIcon: Icon(Icons.lock, size: 30,),
                  hintText: "Password",
                  hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey
                  ),


                ),
              ),
              SizedBox(height: 10),
              RaisedButton(
                child:Text("SIGN IN"),

                color: Colors.green,
                textColor: Colors.white, onPressed: () {
                  signIn(_phoneNumber.text,_passWord.text);

              },
              ),
              SizedBox(height: 10),
              Text("Forgot Password?",
                  style:TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [Text("Don't have an account?",style:TextStyle(fontSize: 20)),
                      InkWell(child:Text("Sign Up",style:TextStyle(color:Colors.blue,fontSize: 20)),onTap: (){ Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Register()));})
            ],)])),)));
  }
}


