import 'package:flutter/material.dart';
import 'package:kase_app/repository/otp_code_repository.dart';
import 'package:kase_app/repository/register_repository.dart';
import 'package:kase_app/screen/SignIn.dart';

OtpCodeRepository Otp_Code = new OtpCodeRepository();

TextEditingController pin1 = new TextEditingController();
TextEditingController pin2 = new TextEditingController();
TextEditingController pin3 = new TextEditingController();
TextEditingController pin4 = new TextEditingController();

FocusNode pin1Focus;
FocusNode pin2Focus;
FocusNode pin3Focus;
FocusNode pin4Focus;

class OTP extends StatefulWidget {
  OTP(
      {@required this.phoneNumber,
      this.fullName,
      this.password,
      this.requestId});
  final String phoneNumber, fullName, password, requestId;

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  RegisterRepository register = new RegisterRepository();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pin1Focus = FocusNode();
    pin2Focus = FocusNode();
    pin3Focus = FocusNode();
    pin4Focus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pin1Focus.dispose();
    pin2Focus.dispose();
    pin3Focus.dispose();
    pin4Focus.dispose();

    pin1.dispose();
    pin2.dispose();
    pin3.dispose();
    pin4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "OTP Verification",
              style: TextStyle(
                  color: Colors.green[500],
                  fontSize: 29,
                  fontWeight: FontWeight.bold),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 100.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_rounded,
                    color: Colors.green,
                    size: 80,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please enter the one time password to verify your account",
                    style: TextStyle(
                      color: Colors.green[400],
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text("A code has been sent to "),
                  Text("${hidePhoneNumber(widget.phoneNumber)}"),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        pinBox(pin1, pin1Focus, pin2Focus),
                        pinBox(pin2, pin2Focus, pin3Focus),
                        pinBox(pin3, pin3Focus, pin4Focus),
                        pinBox(pin4, pin4Focus, pin4Focus),
                      ],
                    ),
                  ),
                  buildTimer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          child: Text(
                            "Resend",
                            style: TextStyle(fontSize: 17),
                          ),
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed: () {
                            Otp_Code.getOtpCode(phone: widget.phoneNumber)
                                .then((response) => {
                                      if (!response.status)
                                        {print("failed")}
                                      else
                                        print("resend succeeded.")
                                    });
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            "Confirm",
                            style: TextStyle(fontSize: 17),
                          ),
                          color: Colors.green,
                          textColor: Colors.white,
                          onPressed: () {
                            String code =
                                pin1.text + pin2.text + pin3.text + pin4.text;
                            if (code != null) {
                              Map<String, dynamic> data = user(
                                  widget.fullName,
                                  widget.password,
                                  widget.phoneNumber,
                                  code,
                                  widget.requestId);
                              print(data);
                              register.register(data).then((response) => {
                                    if (!response.status)
                                      {
                                        print(response.status),
                                        print("error"),
                                      }
                                    else
                                      {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => SignIn()))
                                      }
                                  });
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}

Widget pinBox(
    TextEditingController pin, FocusNode pinFocus, FocusNode pin2Focus) {
  return SizedBox(
    width: 50,
    child: TextFormField(
      onChanged: (val) => {
        if (val.length > 0)
          {
            if (pinFocus != pin2Focus)
              pin2Focus.requestFocus()
            else
              pin2Focus.unfocus()
          }
      },
      textAlign: TextAlign.center,
      autofocus: false,
      focusNode: pinFocus,
      controller: pin,
      maxLength: 1,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        hintText: " ",
        counterText: "",
      ),
    ),
  );
}

Map<String, dynamic> user(String _fullname, String _password, String _phone,
    String vCode, String vId) {
  var data = {
    'name': _fullname,
    'password': _password,
    'phone': _phone,
    'requestId': vId,
    'verifyCode': vCode,
  };
  return data;
}



//Hide phone number
String hidePhoneNumber(String phone) {

String newNumber=phone;
//function for replacing string wtih *
String replaceCharAt(String oldString, int index, String newChar) {
       return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
     }


   for(int i=0; i<phone.length-4;i++){
         newNumber = replaceCharAt(newNumber, i, "*") ; 

    }

  return newNumber;}

   Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }


