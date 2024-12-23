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
  OtpPinput({super.key, required this.clientData});

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
      appBar: AppBar(),
      body: Form(
        key: formKey,
          child:Column(
              children: <Widget>[
                InstructionTexts(widget.clientData.contactInfo?.mobile),
                SizedBox( height: 90,),
                OtpBoxes(clientData: widget.clientData,),
                SizedBox( height: 65,),
                OtpResend(),
                SizedBox( height: 50, ),
              ]
          ),

      ),
    );
  }
}

Widget InstructionTexts(String? mobile){
  return Column(
    children: <Widget>[
      Text(
        "Enter your Pin number",
        style: TextStyle(
          fontSize: 20,
          fontFamily: "Work Sans",
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox( height: 15,),
      Text("Enter the code from the sms we sent", style: MyTextStyle(),),
      Text("to $mobile", style: MyTextStyle(),),
    ],
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

  static const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
  static const fillColor = Color.fromRGBO(243, 246, 249, 0);
  static const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

  final defaultPinTheme = PinTheme(
    width: 65,
    height: 65,
    textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.deepPurple
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.indigo,width: 1),
    ),
  );

  @override
  Widget build(BuildContext context){
    String otp = "${widget.clientData.contactInfo?.otp}";

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => const SizedBox(width: 12),
        validator: (value) {
          return value == otp ? null : 'Incorrect Pin';
        },
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: (pin) {
          if(pin == otp) {
            debugPrint('onCompleted: $pin');
            Navigator.push(context, MaterialPageRoute(builder: (context)=>NameAndGender(clientData: widget.clientData)));
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
              width: 30,
              height: 3,
              color: Colors.indigo,
            ),
          ],
        ),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyMateThemes.primaryColor,width: 3),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: Color.fromRGBO(232,232,232,100),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: focusedBorderColor, width: 2),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: Colors.redAccent),
        ),
      ),
    );
  }
}

Widget OtpResend(){
  return Center(
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text( "Resend OTP again in ", style: TextStyle( fontSize: 20,),),
        Text( "01.44", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: MyMateThemes.textColor),
        )
      ],
    ),
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




