import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/RegisterPages/NameAndGenderPage.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:mymateapp/dbConnection/Firebase_DB.dart';
import 'package:pinput/pinput.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';
import 'package:smart_auth/smart_auth.dart';

import '../../MyMateThemes.dart';
import '../ProfilePageScreen/MyProfileMain.dart';
import 'OTPPage.dart';

class OtpPinput extends StatefulWidget {
  final ClientData clientData;
  final String docId;
  OtpPinput({super.key, required this.clientData, required this. docId});

  @override
  State<OtpPinput> createState() => _OtpPinputState();
}

class _OtpPinputState extends State<OtpPinput> {

  _OtpPinputState();


  late final SmsRetriever smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    smsRetriever = SmsRetrieverImpl(
      SmartAuth(),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child:Column(
            children: <Widget>[
              InstructionTexts(widget.clientData.contactInfo?.mobile),
              SizedBox( height: height*0.08,),
              OtpBoxes(clientData: widget.clientData, docId: widget.docId,),
              SizedBox( height: height*0.03,),
              OtpResend(),
              SizedBox( height:height*0.05, ),
            ]
        ),

      ),
    );
  }
}

Widget InstructionTexts(String? mobile){
  return Builder(
    builder: (context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      return Column(
        children: <Widget>[
          Text(
            "Enter verification code",
            style: TextStyle(
              fontSize: width*0.05,
              color: MyMateThemes.textColor,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5
            ),
          ),
          SizedBox( height: 15,),
          Text("Enter the code from the sms we sent",
            style: TextStyle(
            fontSize: width*0.038,
            color: MyMateThemes.textColor,
            fontWeight: FontWeight.normal,
          ),
          ),
          Text("to $mobile",    style: TextStyle(
            fontSize: width*0.038,
            color: MyMateThemes.textColor,
            fontWeight: FontWeight.normal,
          )
            ,),
        ],
      );
    }
  );
}

class OtpBoxes extends StatefulWidget{
  final ClientData clientData;
  final String docId;
  const OtpBoxes({required this.clientData,required this.docId,super.key});

  @override
  State<OtpBoxes> createState() => _OtpBoxesState();

}

class _OtpBoxesState extends State<OtpBoxes>{
  _OtpBoxesState();
  FirebaseDB firebase = FirebaseDB();

  @override
  void initState() {
    print(widget.clientData);
    super.initState();
  }

  static const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
  static const fillColor = Color.fromRGBO(243, 246, 249, 0);
  static const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

  final defaultPinTheme = PinTheme(
    width: 60,
    height: 60,
    textStyle:  TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: MyMateThemes.primaryColor
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),

      border: Border.all(color:MyMateThemes.primaryColor,width: 1),
    ),
  );

  @override
  Widget build(BuildContext context){
    String otp = "${widget.clientData.contactInfo?.otp}";
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) =>  SizedBox(width: width*0.025),
        validator: (value) {
          return value == otp ? null : 'Incorrect Pin';
        },
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: (pin) async {
          if (pin == otp) {
            debugPrint('OTP Correct: $pin');

            String docId = widget.docId;
            if (docId.isEmpty) {
              debugPrint("Error: docId is missing!");
              return;
            }

            try {
              final response = await http.get(
                Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/getClientDataByDocId?docId=$docId'),
              );

              if (response.statusCode == 200) {
                Map<String, dynamic> userData = jsonDecode(response.body);
                bool page3Complete = userData['completeProfilePending']['_page3_complete'] ?? false;
                print(page3Complete);

                if (page3Complete) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(docId: docId, selectedBottomBarIconIndex: 3,),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NameAndGender(
                        clientData: widget.clientData,
                        docId: docId,
                      ),
                    ),
                  );
                }
              } else {
                debugPrint("API Error: ${response.statusCode} - ${response.body}");
              }
            } catch (e) {
              debugPrint("Error fetching user data: $e");
            }
          } else {
            debugPrint("Incorrect OTP!");
          }
        },
        onChanged: (pin) {
          debugPrint('onChanged: $pin');
        },
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin:  EdgeInsets.only(bottom: height*0.01),
              width: width*0.1,
              height: height*0.001,
              color: MyMateThemes.textColor,

            ),
          ],
        ),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width*0.02),
            border: Border.all(color: MyMateThemes.primaryColor,width:width*0.002),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width*0.02),
            border: Border.all(color: MyMateThemes.primaryColor,width:width*0.004),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: Color(0xF8F81628)),
        ),
      ),
    );
  }
}



Widget OtpResend() {
  return _OtpResendWidget();
}

class _OtpResendWidget extends StatefulWidget {
  @override
  __OtpResendWidgetState createState() => __OtpResendWidgetState();
}

class __OtpResendWidgetState extends State<_OtpResendWidget> {
  int resendTime = 120;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendTime == 0) {
        timer.cancel();
      } else {
        setState(() {
          resendTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, // Force vertical center alignment
        children: <Widget>[
          Text(
            resendTime == 0 ? '' : "Resend OTP in ",
            style: TextStyle(
              fontSize: width * 0.05,
              color: MyMateThemes.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          resendTime == 0
              ? TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero, // Removes vertical padding
              minimumSize: Size(0, 0), // Removes min height constraint
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft, // Aligns the text inside properly
            ),
            onPressed: () {
              setState(() {
                resendTime = 120;
                startTimer();
              });
            },
            child: Text(
              'Resend OTP',
              style: TextStyle(
                color: MyMateThemes.primaryColor,
                fontSize: width * 0.045, // Match font size
                fontWeight: FontWeight.w600,
              ),
            ),
          )
              : Text(
            formatTime(resendTime),
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w600,
              color: MyMateThemes.primaryColor,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final signature = await smartAuth.getAppSignature();
    debugPrint('App Signature: $signature');
    final res = await smartAuth.getSmsCode(
      useUserConsentApi: true,
    );
    if (res.succeed && res.codeFound) {
      return res.code!;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}


