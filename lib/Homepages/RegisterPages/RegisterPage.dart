import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mymateapp/Homepages/RegisterPages/OTPPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';

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
            PhoneField(),
            ContinueButton(),
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

class PhoneField extends StatefulWidget{

  const PhoneField({super.key});

  @override
  State<PhoneField> createState() => _PhoneFieldState();

}

class _PhoneFieldState extends State<PhoneField>{

  String phoneNumber = "";
  String mobile_country_code = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(50),
          child: IntlPhoneField(
              onCountryChanged: (country) {
                print(country.code);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                hintText: "Phone number",
              ),
              onChanged: (number) {
                setState(() {
                  phoneNumber = number.completeNumber;
                }
                );
              }
              ),
      ),
    );
  }

}

class ContinueButton extends StatelessWidget{

  void handlePhoneNumber(BuildContext context) {
    print("Phone Number is:-");
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const otpPage()));

  }

  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 58,
        width: 166,
        child: ElevatedButton(
          onPressed: (){
            handlePhoneNumber(context);
          },
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
    );
  }
}
