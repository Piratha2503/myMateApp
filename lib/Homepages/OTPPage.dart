import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mymateapp/Homepages/NameAndGenderPage.dart';
import 'package:mymateapp/MyMateThemes.dart';

class otpPage extends StatefulWidget {
  const otpPage({super.key});

  @override
  State<otpPage> createState() => _otpPage();
}

class _otpPage extends State<otpPage> {
  void Check() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const NameAndGender()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyMateThemes.backgroundColor,
        appBar: AppBar(
          title: const Text(""),
          backgroundColor: MyMateThemes.backgroundColor,
        ),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          const Center(
            child: Text(
              "Enter your phone number",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text("Enter the code from the sms we sent",
                style: MyTextStyle()),
          ),
          Center(
            child: Text(
              "to +94 xx xxxxxxx",
              style: MyTextStyle(),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Center(
            child: SizedBox(
                width: 350,
                child: Form(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OtpSizedBox(),
                    OtpSizedBox(),
                    OtpSizedBox(),
                    OtpSizedBox(),
                  ],
                ))),
          ),
          Container(
            height: 50,
          ),

          const Center(
           child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Text(
                  "Resend OTP again in ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  " 01.44",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: MyMateThemes.textColor),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: SizedBox(
              height: 58,
              width: 166,
              child: ElevatedButton(
                onPressed: Check,
                style: CommonButtonStyle.commonButtonStyle(),
                child: Text(
                  "Verify",
                  style: TextStyle(fontSize: MyMateThemes.buttonFontSize),
                ),
              ),
            ),
          )
        ]));
  }
}

class MyTextStyle extends TextStyle {
  @override
  // TODO: implement fontSize
  double? get fontSize => 14;
}


Widget OtpSizedBox(){
  return SizedBox(
    height: 68,
    width: 64,
    child: TextField(
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly
      ],
    ),
  );
}
