import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mymateapp/Homepages/OTPPage.dart';
import 'package:mymateapp/MyMateThemes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String phoneNumber = "";

  void Check() {
    print("Hello");
  }

  void handlePhoneNumber() {
    print("Phone Number is:- $phoneNumber");
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const otpPage()));

  }

  @override
  Widget build(BuildContext context) {
    void CountrySet(country) {
      print(country);
    }

    return Scaffold(
        backgroundColor: Color(0xFFFBFFFB),
        appBar: AppBar(
          title: const Text(""),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
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
            SizedBox(height: 15,),
            Center(
              child: Text("Make sure this number can receive SMS.",
                  style: MyTextStyle(),
              ),
            ),
            Center(
              child: Text(
                "You will receive your activation code",
                style: MyTextStyle(),
              ),
            ),
            Center(
              child: Text(
                "through it",
                style: MyTextStyle(),
              ),
            ),
            Center(
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
                      decoration: const InputDecoration(
                        hintText: "Phone number",
                      ),
                      onChanged: (number) {
                        setState(() {
                          phoneNumber = number.completeNumber;
                        });
                      })),
            ),
            Center(
              child: SizedBox(
                height: 58,
                width: 166,
                child: ElevatedButton(
                  onPressed: handlePhoneNumber,
                  style: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    backgroundColor: WidgetStatePropertyAll(MyMateThemes.primaryColor),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}

TextStyle MyTextStyle(){
  return TextStyle(
    fontSize: 14,
  );
}
