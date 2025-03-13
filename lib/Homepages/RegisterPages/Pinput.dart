import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/RegisterPages/NameAndGenderPage.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:mymateapp/dbConnection/Firebase_DB.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

import '../../MyMateThemes.dart';
import 'OTPPage.dart';

class OtpPinput extends StatefulWidget {
  final ClientData clientData;
  OtpPinput({super.key, required this.clientData, required String docId});

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child:
      LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;
          return Form(
            key: formKey,
            child:Column(
                children: <Widget>[
                  SizedBox( height: height*0.1),
                  InstructionTexts(widget.clientData.contactInfo?.mobile),
                  SizedBox( height:height*0.12),
                  OtpBoxes(clientData: widget.clientData,),
                  SizedBox( height:height*0.05),
                  OtpResend(),
                  SizedBox( height: 50, ),
                ]
            ),

          );
        }
      ),
      ),



    );
  }
}

Widget InstructionTexts(String? mobile){
  return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
      return Column(
        children: <Widget>[
          Text(
            "Enter verification code",
            style: TextStyle(
              fontSize: width*0.05,
              color: MyMateThemes.textColor,
              fontFamily: "Work Sans",
              fontWeight: FontWeight.w700,
            ),
          ),
        SizedBox(height: 10),
          Text("Enter the code from the sms we sent",
              style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: width*0.04
              )),
          Text("to $mobile", style: TextStyle(
        color: MyMateThemes.textColor,
        fontSize: width*0.04
        ),),
        ],
      );
    }
  );
}

class OtpBoxes extends StatefulWidget{
  final ClientData clientData;


  const OtpBoxes({required this.clientData,super.key});



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

  static const focusedBorderColor =MyMateThemes.primaryColor;
  static const fillColor =Colors.white;
  static const borderColor = MyMateThemes.textColor;
  static const textColor = MyMateThemes.textColor;

  final defaultPinTheme =
  PinTheme(
    width: 65,
    height: 65,
    textStyle:  TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: MyMateThemes.primaryColor,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: MyMateThemes.primaryColor,width: 1),
    ),
  );

  final defaultTextTheme =
  PinTheme(
    width: 65,
    height: 65,
    textStyle:  TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: MyMateThemes.textColor,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: MyMateThemes.primaryColor,width: 1),
    ),

  );


  @override
  Widget build(BuildContext context){
    String otp = "${widget.clientData.contactInfo?.otp}";
    return
    LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Pinput(
            defaultPinTheme: defaultPinTheme,
            separatorBuilder: (index) => SizedBox(width: width*0.02),
            validator: (value) {
              return value == otp ? null : 'Incorrect Pin';
            },
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            onCompleted: (pin) {
              if(pin == otp) {
                debugPrint('onCompleted: $pin');
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NameAndGender(clientData: widget.clientData, docId:  widget.clientData.docId ?? "Unknown",)));
              }
            },
            onChanged: (pin) {
              debugPrint('onChanged: $pin');
            },
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  width:width*0.03,
                  height: height*0.01,
                  color: MyMateThemes.textColor,
                ),
              ],
            ),
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(width*0.02),
                border: Border.all(color: MyMateThemes.primaryColor,width: width*0.005),
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width*0.02),
                border: Border.all(color: focusedBorderColor, width:width*0.005),
              ),
            ),
            errorPinTheme: defaultTextTheme.copyBorderWith(

              border: Border.all(color: Colors.red),
            ),
          ),
        );
      }
    );
  }
}

Widget OtpResend(){
  return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
      return Center(
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
          ),

          ],
        ),
      );
    }
  );
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



