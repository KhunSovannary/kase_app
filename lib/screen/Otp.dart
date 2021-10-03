import 'package:flutter/material.dart';

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "OTP Verification",
              style: TextStyle(color: Colors.green[500]),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            
            child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 100.0),
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                                  Text(
                                    "Enter Your Verification Code",
                                    style: TextStyle(color: Colors.green[400], fontSize: 20),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        pinBox(),
                                        pinBox(),
                                        pinBox(),
                                        pinBox(),
                                      
                                      ],
                                    ),),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                                RaisedButton(
                                                  child:Text("Resend"),
                                                  color: Colors.red,
                                                  textColor: Colors.white, onPressed: () {
                                                  },
                                                ),
                                                RaisedButton(
                                                  child:Text("Confirm"),
                                                  color: Colors.green,
                                                  textColor: Colors.white, onPressed: () {
                                                  },
                                                ),
                                      
                                      ],
                                    ),),
                                  
                                              ],
                      )),
                          ));
                }
              }

Widget pinBox() {
  return SizedBox(
    width: 50,
    child: TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        hintText: " ",
        
      ),
    ),
  );
}
