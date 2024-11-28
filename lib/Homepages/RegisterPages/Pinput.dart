import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';
import '../../MyMateThemes.dart';
import '../../dbConnection/Firebase.dart';
import 'OTPPage.dart';

class OtpPinput extends StatefulWidget {
  final String docId;
  const OtpPinput({Key? key, required this.docId}) : super(key: key);

  @override
  State<OtpPinput> createState() => _OtpPinputState(docId: docId);
}

class _OtpPinputState extends State<OtpPinput> {
  final String docId;
  _OtpPinputState({required this.docId});

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
                InstructionTexts(),
                SizedBox( height: 90,),
                OtpBoxes(this.docId),
                SizedBox( height: 65,),
                OtpResend(),
                SizedBox( height: 50, ),
                VerifyButton(),
              ]
          ),

      ),
    );
  }
}

Widget InstructionTexts(){
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
      Text("to +94 xx xxxxxxx", style: MyTextStyle(),),
    ],
  );
}

class OtpBoxes extends StatefulWidget{
  final String docId;
  const OtpBoxes(this.docId, {super.key});

  @override
  State<OtpBoxes> createState() => _OtpBoxesState();

}

class _OtpBoxesState extends State<OtpBoxes>{
  _OtpBoxesState();
  Firebase firebase = Firebase();
  String pin = "";

  Future<void> getClient() async {

    DocumentSnapshot client = await firebase.clients.doc(widget.docId).get();

    setState(() {
      pin = client['pin'] ?? "N/A";

    });
  }
  @override
  void initState() {
    super.initState();
    getClient();
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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => const SizedBox(width: 12),
        validator: (value) {
          return value == pin ? null : 'Incorrect Pin';
        },
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: (pin) {
          if(pin == pin) debugPrint('onCompleted: $pin');
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

Widget VerifyButton(){
  return Center(
    child: SizedBox(
      height: 58,
      width: 166,
      child: ElevatedButton(
        onPressed: (){},
        style: CommonButtonStyle.commonButtonStyle(),
        child: Text("Verify", style: TextStyle(fontSize: MyMateThemes.buttonFontSize),
        ),
      ),
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




