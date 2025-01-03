import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mymateapp/Homepages/RegisterPages/Pinput.dart';
import 'package:mymateapp/MyMateCommonBodies/MyMateApis.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/Firebase_DB.dart';
import '../../dbConnection/ClientDatabase.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  void Check() {
    print("Hello");
  }

  @override
  Widget build(BuildContext context) {
    void CountrySet(country) {
      print(country);
    }

    return Scaffold(
        backgroundColor: Color(0xFFFBFFFB),
        appBar: AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            EnterYourPhoneNumber(),
            SizedBox(height: 15,),
            TextInstructions(),
            PhoneFieldAndNextButton(),
          ],
        )
    );
  }
}

Widget EnterYourPhoneNumber(){
  return Center(
    child: Text(
      "Enter your phone number",
      style: TextStyle(
        fontSize: 20,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget TextInstructions(){
  return Column(
    children: <Widget>[
      Center(
        child: Text("Make sure this number can receive SMS.",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      Center(
        child: Text(
          "You will receive your activation code",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      Center(
        child: Text(
          "through it",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    ],
  );
}

class PhoneFieldAndNextButton extends StatefulWidget{

  const PhoneFieldAndNextButton({super.key});

  @override
  State<PhoneFieldAndNextButton> createState() => _PhoneFieldAndNextButtonState();

}

class _PhoneFieldAndNextButtonState extends State<PhoneFieldAndNextButton>{
  String phoneNumber = "";
  String mobile_country_code = "";
  String client_country = "";
  String otp = "";
  FirebaseDB firebaseDB = FirebaseDB();

  Future<void> addMobile() async{
    print("Running");
    var random = Random();
    otp = (random.nextInt(9999-1001)+1000).toString();
    Address address = Address(country: client_country);
    ContactInfo contactInfo = ContactInfo(
        mobile: phoneNumber,
        mobile_country_code: mobile_country_code,
        otp: otp,
        address: address
    );
    ClientData clientData = ClientData(contactInfo: contactInfo);
    final url = Uri.parse(MyMateAPIs.mobile_number_registration_API);
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json',},
      body: jsonEncode(clientData.toMap())
    );

   if(res.statusCode == 200){
     print(res.statusCode);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpPinput(clientData: clientData,)));
   }
   else {
     print(res.body);
   }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
            Center(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: IntlPhoneField(
                            onCountryChanged: (country) {
                              setState(() {
                              client_country = country.name;
                              mobile_country_code = country.code;
                              });
                          },
                            inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                              ],
                          decoration: InputDecoration(hintText: "Phone number",),
                          onChanged: (number) {
                          setState(() {
                            phoneNumber = number.completeNumber;
                                });
                        }
                  ),
              ),
          ),
        Center(
          child: SizedBox(
            height: 58,
            width: 166,
            child: ElevatedButton(
              onPressed: addMobile,
              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                backgroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
