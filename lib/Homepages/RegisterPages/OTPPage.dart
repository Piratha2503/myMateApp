import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymateapp/Homepages/RegisterPages/NameAndGenderPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:pinput/pinput.dart';

class otpPage extends StatefulWidget {
  const otpPage({super.key});

  @override
  State<otpPage> createState() => _otpPage();
}

class _otpPage extends State<otpPage> {
  void Check() {
    ClientData clientData = ClientData();
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>Pinput()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyMateThemes.backgroundColor,
        body:
        LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              double height = constraints.maxHeight;
            return SafeArea(child:
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: height*0.11,
                ),
               Center(
                child:
                Text(
                  "Enter verification code",
                  style: TextStyle(
                    fontSize: width*0.05,
                    color: MyMateThemes.textColor,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: height*0.03,
              ),
              Center(
                child: Text("Enter the code from the sms we sent",
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: width*0.04
                    )),
              ),
              Center(
                child: Text(
                  "to +94 xx xxxxxxx",
                  style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: width*0.04
                  ),
                ),
              ),
                SizedBox(
                  height: height*0.15,
                ),
              Center(
                    child: Form(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,

                          children: [
                            SizedBox(
                              width: width*0.05,
                            ),
                            OtpSizedBox(),
                            SizedBox(
                              width: width*0.001,
                            ),
                            OtpSizedBox(),
                            SizedBox(
                              width: width*0.001,
                            ),
                            OtpSizedBox(),
                            SizedBox(
                              width: width*0.001,
                            ),
                            OtpSizedBox(),
                            SizedBox(
                              width: width*0.05,
                            ),
                          ],
                        )
                    )

              ),
              SizedBox(
                height: height*0.03,
              ),

              Center(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(
                      "Resend OTP again in ",
                      style: TextStyle(
                        fontSize:width*0.05,
                          color: MyMateThemes.textColor
                      ),
                    ),
                    Text(
                      " 01.44",
                      style: TextStyle(
                          fontSize: width*0.05,
                          fontWeight: FontWeight.bold,
                          color: MyMateThemes.primaryColor),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height*0.05,
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
                      style: TextStyle(fontSize: width*0.05),
                    ),
                  ),
                ),
              )
            ],
            )

            );
          }
        ),
    );
  }

  Widget OtpSizedBox(){
    return  LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
        return SizedBox(
          height: 68,
          width: 64,
          child: TextField(
            onChanged: (value){
              FocusScope.of(context).nextFocus();
            },
            style: TextStyle(
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
    );
  }

}

class MyTextStyle extends TextStyle {
  @override
  // TODO: implement fontSize
  double? get fontSize => 14;

}

