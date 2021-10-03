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
              style: TextStyle(color: Colors.green),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
              
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                                Text(
                                  "Enter Your Verification Code",
                                  style: TextStyle(color: Colors.green, fontSize: 25),
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
                                  ),
                                )
                              ],
        ))));
  }
}

Widget pinBox() {
  return SizedBox(
    width: 40,
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
