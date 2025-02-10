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
import 'package:shared_preferences/shared_preferences.dart';

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
        fontWeight: FontWeight.w700,
        color: MyMateThemes.textColor,
        letterSpacing: 0.8,

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
              color: MyMateThemes.textColor,
              fontFamily: "Work Sans",
              fontWeight: FontWeight.normal,
              letterSpacing: 0.6,
              wordSpacing: 0.5


          ),
        ),
      ),
      Center(
        child: Text(
          "You will receive your activation code",
          style: TextStyle(
              fontSize: 14,
              color: MyMateThemes.textColor,
              fontFamily: "Work Sans",
              fontWeight: FontWeight.normal,
              letterSpacing: 0.6,
              wordSpacing: 0.5



          ),
        ),
      ),
      Center(
        child: Text(
          "through it",
          style: TextStyle(
              fontSize: 14,
              color: MyMateThemes.textColor,
              fontFamily: "Work Sans",
              fontWeight: FontWeight.normal,
              letterSpacing: 0.6,
              wordSpacing: 0.5



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
  final TextEditingController _controller = TextEditingController();
  String phoneNumber = "";
  String mobile_country_code = "";
  String client_country = "";
  String mobile_code = "94";
  int? otp = 0;
  FirebaseDB firebaseDB = FirebaseDB();

  Future<String?> fetchDocIdByMobile(String mobile) async {


    try {
      final url = Uri.parse("https://backend.graycorp.io:9000/mymate/api/v1/getClientDataByMobile")
          .replace(queryParameters: {'mobile': mobile});

      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final docId = data['docId'];
        print("Fetched docId: $docId");
        return data['docId'];

      }

      else {
        print("Failed to fetch docId: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print("Error fetching docId: $e");
    }
    return null;
  }

  Future<void> addMobile() async{
    print("Running");
    var random = Random();
    otp = (random.nextInt(9999-1001)+1000);
    Address address = Address(country: client_country);
    String mobile = "+$mobile_code$phoneNumber";
    ContactInfo contactInfo = ContactInfo(
        mobile: "+$mobile_code$phoneNumber",
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
      final docId = await fetchDocIdByMobile(mobile);
      print(mobile);
      if (docId != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('docId', docId);

        Navigator.push( context,
          MaterialPageRoute(
            builder: (context) => OtpPinput(
              clientData: clientData,
              docId: docId,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(content: Text("Failed to fetch docId. Please try again.")

          ),

        );
      }
    } else {
      print("Failed to register mobile. Response: ${res.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${res.body}")),
      );
    }
  //   if(res.statusCode == 200){
  //     print(res.statusCode);
  //     String formattedPhoneNumber = "$mobile_code$phoneNumber";
  //
  //     final docId = await fetchDocIdByMobile("+94768835990");
  //     if (docId != null) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => OtpPinput(
  //             clientData: clientData,
  //             docId: docId,
  //           ),
  //         ),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Failed to fetch docId. Please try again.")),
  //       );
  //     }
  //   } else {
  //     print("Failed to register mobile. Response: ${res.body}");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error: ${res.body}")),
  //     );
  //
     }
  // }

  void _openPopupScreen(BuildContext context, String mobileNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height:10),
              Text(
                "Is this your Phone number",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: MyMateThemes.textColor,letterSpacing: 0.8),
              ),
              SizedBox(height: 10),

              TextField(
                controller: TextEditingController(text: mobileNumber),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: MyMateThemes.textColor,
                  fontWeight: FontWeight.bold,
                ),

              ),


              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      MyMateThemes.secondaryColor, // Background color
                      foregroundColor:MyMateThemes.primaryColor, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 16), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2), // Rounded corners
                      ),
                    ),

                    child: Text("Edit"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addMobile();
                      print("Number added");
                    },
                    style: CommonButtonStyle.commonButtonStyle(),

                    child: Text("Yes"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {


    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
            child: IntlPhoneField(
              readOnly: true,
              showCursor: false,
              dropdownIconPosition: IconPosition.leading,
              onCountryChanged: (country) {
                setState(() {
                  client_country = country.name;
                  mobile_country_code = country.code;
                  mobile_code = country.dialCode;
                });
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(hintText: client_country,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.grey
                  )),
            ),
          ),
        ),
        Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 45,
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1,color: Colors.grey))),
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: "+$mobile_code",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      style: TextStyle(fontSize: 18,color: Colors.grey),),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 235,
                    child: TextField(
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                      controller: _controller,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey))
                      ),
                      onChanged: (number){
                        setState(() {
                          phoneNumber = number;
                        });
                        print(phoneNumber);
                      },
                    ),
                  )
                ],
              )
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Center(
          child: SizedBox(
            height: 58,
            width: 166,
            child: ElevatedButton(
              onPressed: ()
              {
                _openPopupScreen(context,"+$mobile_code$phoneNumber");

              },

              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                backgroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)
                ),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),

      ],
    );
  }
}