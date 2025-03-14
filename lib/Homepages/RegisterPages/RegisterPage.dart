import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
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
        backgroundColor: Colors.white,
        body: LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              double height = constraints.maxHeight;
              return SafeArea(child:
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: height*0.09),
                  EnterYourPhoneNumber(),
                  SizedBox(height: height*0.02),
                  TextInstructions(),
                  SizedBox(height: height*0.04),
                  PhoneFieldAndNextButton(width,height),
                ],
              )
              );

            }
        )
    );
  }
}



Widget EnterYourPhoneNumber(){
  return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        return Center(
          child: Text(
            "Enter your phone number",
            style: TextStyle(
              fontSize:width*0.046,
              fontFamily: "Work Sans",
              fontWeight: FontWeight.w600,
              color: MyMateThemes.textColor,
              letterSpacing: 0.8,

            ),
          ),
        );
      }
  );
}

Widget TextInstructions(){
  return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        return Column(
          children: <Widget>[
            Center(
              child: Text("Make sure this number can receive SMS.",
                style: TextStyle(
                    fontSize: width*0.036,
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
                    fontSize: width*0.036,
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
                    fontSize: width*0.036,
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
  );
}

class PhoneFieldAndNextButton extends StatefulWidget {
  final double width;
  final double height;

  const PhoneFieldAndNextButton(this.width, this.height, {super.key});

  @override
  State<PhoneFieldAndNextButton> createState() =>
      _PhoneFieldAndNextButtonState();
}

class _PhoneFieldAndNextButtonState extends State<PhoneFieldAndNextButton> {
  final TextEditingController _controller = TextEditingController();
  String phoneNumber = "";
  String mobile_country_code = "";
  String client_country = "";
  String mobile_code = "+94";
  int? otp = 0;
  FirebaseDB firebaseDB = FirebaseDB();

  Future<String?> fetchDocIdByMobile(String mobile) async {

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    try {
      final url = Uri.parse(
              "https://backend.graycorp.io:9000/mymate/api/v1/getClientDataByMobile")
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
      } else {
        print(
            "Failed to fetch docId: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print("Error fetching docId: $e");
    }
    return null;
  }

  Future<void> addMobile() async {
     final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    String? token = await _firebaseMessaging.getToken();
    print("Running");
    var random = Random();
    otp = (random.nextInt(9999 - 1001) + 1000);
    Address address = Address(country: client_country);
    String formattedPhoneNumber = "+$mobile_code$phoneNumber";
    ContactInfo contactInfo = ContactInfo(
        mobile: "+$mobile_code$phoneNumber",
        mobile_country_code: mobile_country_code,
        otp: otp,
        address: address);
    ClientData clientData = ClientData(contactInfo: contactInfo);
    final url = Uri.parse(MyMateAPIs.mobile_number_registration_API);
    final res = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(clientData.toMap()));

    if (res.statusCode == 200) {
      print(res.statusCode);

      final docId = await fetchDocIdByMobile(formattedPhoneNumber);
      print('formatted phone number is $formattedPhoneNumber');

      if (docId != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('docId', docId);
         await prefs.setString('token', token!);

        print('token is :$token');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpPinput(
              clientData: clientData,
              docId: docId,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Failed to fetch docId. Please try again.")),
        );
      }
    } else {
      print("Failed to register mobile. Response: ${res.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${res.body}")),
      );
    }
    if (res.statusCode == 200) {
      print(res.statusCode);
      final docId = await fetchDocIdByMobile(phoneNumber);
      print('phone number is $phoneNumber');
      if (docId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpPinput(
              clientData: clientData,
              docId: docId,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to fetch docId. Please try again.")),
        );
      }
    } else {
      print("Failed to register mobile. Response: ${res.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${res.body}")),
      );

    }
  }

  void _openPopupScreen(BuildContext context, String mobileNumber) {
    showDialog(
      context: context, // Ensure `context` is available
      builder: (BuildContext context) {
        return LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              double height = constraints.maxHeight;
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height:height*0.02),
                    Text(
                      "Is this your Phone number",
                      style: TextStyle(fontSize: width*0.04 ,fontWeight: FontWeight.w500,color: MyMateThemes.textColor,letterSpacing: 0.8),
                    ),
                    SizedBox(height:height*0.01),

                    TextField(
                      controller: TextEditingController(text: mobileNumber),
                      textAlign: TextAlign.center, // Aligns the text to the center
                      style: TextStyle(
                        fontSize: width*0.05,
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.normal,
                      ),

                    ),

                    SizedBox(height:height*0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                            // Add your "Edit" button functionality here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            MyMateThemes.secondaryColor, // Background color
                            foregroundColor:MyMateThemes.primaryColor, // Text color
                            padding: EdgeInsets.symmetric(horizontal: width*0.1,vertical: height*0.015), // Padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width*0.02), // Rounded corners
                            ),
                          ),

                          child: Text("Edit"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            addMobile();
                            print("Number added");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            MyMateThemes.primaryColor, // Background color
                            foregroundColor:Colors.white, // Text color
                            padding: EdgeInsets.symmetric(horizontal: width*0.1,vertical: height*0.015), // Padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width*0.02), // Rounded corners
                            ),
                          ),

                          child: Text("Yes"),
                        ),

                      ],
                    ),
                  ],
                ),
              );
            }
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:widget.width*0.13,vertical: widget.height*0.01),
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
                      fontWeight: FontWeight.normal,
                      fontSize: widget.width*0.05,
                      color: MyMateThemes.textColor.withOpacity(0.5)
                  )),
            ),
          ),
        ),
        Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal:widget.width*0.13,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: widget.width*0.13,
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width:widget.width*0.001,color:MyMateThemes.textColor.withOpacity(0.5)))),
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: "+$mobile_code",
                          hintStyle: TextStyle(color: MyMateThemes.textColor)
                      ),
                      style: TextStyle(fontSize:  widget.width * 0.05,color: Colors.grey),),
                  ),
                  SizedBox(
                    width: widget.width*0.03,
                  ),
                  Container(
                    width: widget.width * 0.58, // Responsive width for text field
                    child: TextField(
                      style:  TextStyle(fontSize:  widget.width * 0.05, fontWeight: FontWeight.normal,color: MyMateThemes.textColor),
                      controller: _controller,
                      decoration:  InputDecoration(
                        hintText: "Phone number",
                        hintStyle: TextStyle(color: MyMateThemes.textColor.withOpacity(0.7)),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: widget.width * 0.01, color: Colors.grey),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (number) {
                        setState(() {
                          phoneNumber = number;
                        });
                        print(phoneNumber);
                      },
                    ),
                  ),                ],
              )
          ),
        ),

        SizedBox(height: widget.height * 0.06), // Adjust spacing dynamically
        Center(
          child: SizedBox(
            height: widget.height * 0.07,
            width: widget.width * 0.4,
            child: ElevatedButton(
              onPressed: () {
                _openPopupScreen(context, "+$mobile_code $phoneNumber");
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(MyMateThemes.primaryColor),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(widget.width*0.01)
                    )),
              ),
              child:  Text(
                "Get Started",
                style: TextStyle(fontSize:  widget.width * 0.045),
              ),
            ),
          ),
        ),

      ],
    );
  }
}