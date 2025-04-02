import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mymateapp/ChartPages/PlaceDateTimeInput.dart';
import 'package:mymateapp/MyMateCommonBodies/MyMateApis.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:http/http.dart' as http;

import 'ChartOptions.dart';

class NameAndGender extends StatefulWidget {
  final ClientData clientData;
  final String docId;

   const NameAndGender({super.key, required this.clientData, required this.docId});

  @override
  State<NameAndGender> createState() => _NameAndGenderState();
}

class _NameAndGenderState extends State<NameAndGender> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String selectedGender = "";

  @override
  void initState() {
    super.initState();
    getClientData();
  }

  Future<void> getClientData() async {
    final url = Uri.parse(MyMateAPIs.get_client_by_mobile).replace(
      queryParameters: {'mobile': widget.clientData.contactInfo!.mobile},
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> clientDocs = jsonDecode(response.body);
      widget.clientData.docId = clientDocs.values.firstOrNull;
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        PersonalDetails personalDetails = PersonalDetails();

        return Scaffold(
          backgroundColor:Colors.white,
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(height: height * 0.1),
                  Text(
                    'Enter your details',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  InputField("First name", firstNameController),
                  SizedBox(height: height * 0.02),
                  InputField("Last name", lastNameController),
                  SizedBox(height: height * 0.05),
                  GenderButtons(personalDetails),
                  SizedBox(height: height * 0.1),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: NextButton(
                      clientData: widget.clientData,
                      personalDetails: personalDetails,
                      docId: widget.docId,
                      firstTextController: firstNameController,
                      lastTextController: lastNameController,
                      selectedGender: selectedGender,

                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget GenderButtons(PersonalDetails personalDetails) {

    return Builder(
      builder: (context) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenderButton(
              gender: "Male",
              icon: Icons.male_outlined,
              isSelected: selectedGender == "Male",
              onSelected: () {
                setState(() {
                  selectedGender = "Male";
                  personalDetails.gender = selectedGender;
                });
              },
            ),
            SizedBox(width: width * 0.05),
            GenderButton(
              gender: "Female",
              icon: Icons.female_outlined,
              isSelected: selectedGender == "Female",
              onSelected: () {
                setState(() {
                  selectedGender = "Female";
                  personalDetails.gender = selectedGender;
                });
              },
            ),
          ],
        );
      }
    );
  }
}

class GenderButton extends StatelessWidget {
  final String gender;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelected;

  const GenderButton({
    required this.gender,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height*0.145,
      width: width*0.27,

      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? MyMateThemes.primaryColor.withOpacity(0.8) : MyMateThemes.textColor.withOpacity(0.3),
          width:  isSelected ? width * 0.004 :width * 0.002 , // Use constraints
        ),
        borderRadius: BorderRadius.circular(width*0.01),
      ),
      child: ElevatedButton(
        onPressed: onSelected,
        style: ElevatedButton.styleFrom(
          backgroundColor:Colors.white,
          elevation:0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width*0.01),
          ),
          // padding: EdgeInsets.all(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: width * 0.15, color: MyMateThemes.primaryColor),
            SizedBox(height: width * 0.02),
            Text(
              gender,
              style: TextStyle(fontWeight: FontWeight.normal,color: MyMateThemes.textColor, fontSize: width * 0.04),
            ),
          ],
        ),
      ),
    );
  }
}

Widget InputField(String inputName, TextEditingController nameController) {

  return Builder(
    builder: (context) {
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;

      return SizedBox(
        width: width * 0.8,
        height: height*0.08,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height*0.01),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal:width* 0.02), // Adjust padding

              hintText: inputName,
              hintStyle: TextStyle(color: MyMateThemes.textColor.withOpacity(0.5), fontSize: width*0.045,fontWeight: FontWeight.normal),
                  enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: MyMateThemes.textColor.withOpacity(0.3),
                  width: width*0.0025,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: MyMateThemes.textColor.withOpacity(0.4), // active color on focus
                  width: width*0.003,
                ),
              ),
            ),
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: MyMateThemes.textColor,
              fontSize: width*0.045,
            ),
          ),
        ),
      );
    }
  );
}


class NextButton extends StatelessWidget {
  final ClientData clientData;
  final PersonalDetails personalDetails;
  final TextEditingController firstTextController;
  final TextEditingController lastTextController;
  final String selectedGender;
  final String docId;

  NextButton({
    required this.clientData,
    required this.personalDetails,
    required this.firstTextController,
    required this.lastTextController,
    required this.selectedGender,
    required this.docId,
    super.key,

  });

  Future<void> updateClientProfile(BuildContext context) async {
    personalDetails.first_name = firstTextController.text;
    personalDetails.last_name = lastTextController.text;
    personalDetails.gender = selectedGender;
    clientData.personalDetails = personalDetails;


    print("docId before toMap: ${clientData.docId}");

    print("clientData.toMap before API call: ${jsonEncode(clientData.toMap())}");


    final url = Uri.parse(MyMateAPIs.save_client_API);
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(clientData.toMap()),
    );

    if (response.statusCode == 200) {
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceDateTimeInput(clientData: clientData,docId:docId,)),
      );
    } else {
      print("Error Status: ${response.statusCode}");
      print("Error Body: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.08,
      width: width * 0.50,
      child: ElevatedButton(
        onPressed: () => updateClientProfile(context),
        style: CommonButtonStyle.commonButtonStyle(),
        child: Text(
          "Get Started",
          style: TextStyle(fontSize: width * 0.04,fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
