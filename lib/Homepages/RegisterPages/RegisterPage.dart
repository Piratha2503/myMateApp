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
import 'package:country_picker/country_picker.dart';

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
        // appBar: AppBar(),
        body: LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              double height = constraints.maxHeight;
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: height*0.1,),

                  EnterYourPhoneNumber(),
                  SizedBox(height: height*0.02,),
                  TextInstructions(),
                  PhoneFieldAndNextButton(),
                ],
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
              fontSize: width*0.046,
              fontWeight: FontWeight.w500,
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
                    fontSize: width*0.035,
                    color: MyMateThemes.textColor,
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
                    fontSize: width*0.035,
                    color: MyMateThemes.textColor,
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
                    fontSize: width*0.035,
                    color: MyMateThemes.textColor,
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

  String country_flag = '🇱🇰'; // Default flag for Sri Lanka


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
    // Declare the state variable outside the inner builder so it persists.
    bool isYesButtonDisabled = false;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;


    showDialog(
      context: context,
      builder: (BuildContext context) {

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth*0.03),
              ),
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: screenWidth*0.08,vertical: screenheight*0.05),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                    "Is this your Phone number",
                    style: TextStyle(
                      fontSize: screenWidth*0.04,
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.8,

                    ),
                  ),
                 // SizedBox(height: screenheight*0.01),
                  TextField(
                    controller: TextEditingController(text: mobileNumber),
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      fontSize: screenWidth*0.045,
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.normal,
                      // color: MyMateThemes.textColor,

                    ),
                  ),
                  SizedBox(height: screenheight*0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(MyMateThemes.primaryColor),

                          backgroundColor: MaterialStateProperty.all(MyMateThemes.secondaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              )),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0), // Adjust values as needed
                          ),

                        ),
                        child:  Text("Edit",style: TextStyle(color: MyMateThemes.primaryColor,fontSize: screenWidth*0.04,letterSpacing: 0.5),),
                      ),
                      SizedBox(width: screenWidth*0.02,),
                      ElevatedButton(
                        onPressed: isYesButtonDisabled
                            ? null
                            : () {
                          // Disable the button after it's pressed.
                          setState(() {
                            isYesButtonDisabled = true;
                          });
                          // Call your addMobile function.
                          addMobile();
                          print("Number added");
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey; // Disabled background color.
                              }
                              return MyMateThemes.primaryColor; // Enabled background color.
                            },
                          ),
                          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.black; // Disabled text color.
                              }
                              return Colors.white; // Enabled text color.
                            },
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              )),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0), // Adjust values as needed
                          ),

                        ),

                        child:  Text("Yes",style: TextStyle(color: Colors.white,fontSize: screenWidth*0.04,letterSpacing: 0.5)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Builder(
      builder: (context) {
        return Column(
          children: <Widget>[
            SizedBox(height: screenHeight * 0.05),

            /// Country selector
// At the top of your widget (State)


            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.1,
                vertical: screenHeight * 0.015,
              ),
              child: GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false, // hides +94
                    onSelect: (Country country) {
                      setState(() {
                        client_country = country.name;
                        mobile_country_code = country.countryCode;
                        mobile_code = country.phoneCode;
                        country_flag = country.flagEmoji;
                      });
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.01,
                    vertical: screenHeight * 0.015,
                  ),
                  // inputFormatters: [
                  //   LengthLimitingTextInputFormatter(10),
                  //   FilteringTextInputFormatter.digitsOnly,
                  // ],
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: MyMateThemes.textColor.withOpacity(0.8),
                        width: screenWidth * 0.001,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [

                          Text(
                            client_country.isNotEmpty
                                ? '$country_flag  $client_country'
                                : '🇱🇰   Sri Lanka',
                            style: TextStyle(
                              fontSize: screenWidth * 0.042,
                              fontWeight: FontWeight.w600,
                              color: client_country.isNotEmpty
                                  ? MyMateThemes.textColor  // New style after selection
                                  : MyMateThemes.textColor.withOpacity(0.5), // Default style
                            ),
                          ),
                        ],
                      ),

                      Icon(Icons.keyboard_arrow_down_outlined, color: MyMateThemes.textColor.withOpacity(0.6)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),

            /// Phone number field
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.11),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.15,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: MyMateThemes.textColor.withOpacity(0.8),
                            width: screenWidth * 0.001,
                          ),
                        ),
                      ),
                      child: TextField(
                        readOnly: true,
                        showCursor: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal:screenWidth* 0.025), // Adjust padding
                          hintText: "+$mobile_code",
                          hintStyle: TextStyle(color: MyMateThemes.textColor, fontSize: screenWidth*0.042,fontWeight: FontWeight.w600
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyMateThemes.textColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyMateThemes.textColor, // active color on focus
                              width: 1.0,
                            ),
                          ),
                        ),

                        style: TextStyle( fontSize: screenWidth*0.042,color: MyMateThemes.textColor,fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Container(
                      width: screenWidth * 0.6,

                      child: TextField(
                        style: TextStyle(
                          fontSize: screenWidth*0.042,
                          color: MyMateThemes.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: _controller,
                        keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal:screenWidth* 0.025), // Adjust padding
                          hintText: "Phone number",
                          hintStyle: TextStyle(color: MyMateThemes.textColor.withOpacity(0.5), fontSize: screenWidth*0.042,fontWeight: FontWeight.w600
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyMateThemes.textColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyMateThemes.textColor, // active color on focus
                              width: 1.0,
                            ),
                          ),

                        ),

                        onChanged: (number) {
                          setState(() {
                            phoneNumber = number;
                          });
                          print(phoneNumber);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.06),

            /// Button
            Center(
              child: SizedBox(
                height: screenHeight * 0.07,
                width: screenWidth * 0.45,
                child: ElevatedButton(
                  onPressed: () {
                    _openPopupScreen(context, "+$mobile_code$phoneNumber");
                  },
                  style: ButtonStyle(
                    foregroundColor:
                    MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(
                        MyMateThemes.primaryColor),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0), // Adjust values as needed
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
      },
    );
  }

}