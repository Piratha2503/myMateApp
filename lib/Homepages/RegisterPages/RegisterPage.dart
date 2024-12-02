import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mymateapp/Homepages/RegisterPages/NameAndGenderPage.dart';
import 'package:mymateapp/Homepages/RegisterPages/OTPPage.dart';
import 'package:mymateapp/Homepages/RegisterPages/Pinput.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:mymateapp/dbConnection/Firebase_DB.dart';

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
  FirebaseDB firebaseDB = FirebaseDB();
  Future<void> addMobile() async{
    Address address = Address(country: client_country);
    ContactInfo contactInfo = ContactInfo(
        mobile: phoneNumber,
        mobile_country_code: mobile_country_code,
        address: address);
    ClientData clientData = ClientData(contactInfo: contactInfo);
    await firebaseDB.addClient(clientData);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>otpPage()));
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
