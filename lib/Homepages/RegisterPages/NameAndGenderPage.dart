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
          backgroundColor: MyMateThemes.backgroundColor,
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
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  InputField("First name", firstNameController, width,height),
                  SizedBox(height: height * 0.02),
                  InputField("Last name", lastNameController, width,height),
                  SizedBox(height: height * 0.05),
                  GenderButtons(personalDetails, width),
                  SizedBox(height: height * 0.1),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: NextButton(
                      clientData: widget.clientData,
                      personalDetails: personalDetails,
                      firstTextController: firstNameController,
                      lastTextController: lastNameController,
                      selectedGender: selectedGender,
                      width: width,
                      height: height,

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

  Widget GenderButtons(PersonalDetails personalDetails, double width) {
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
          width: width,
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
          width: width,
        ),
      ],
    );
  }
}

class GenderButton extends StatelessWidget {
  final String gender;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelected;
  final double width;

  const GenderButton({
    required this.gender,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSelected,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyMateThemes.backgroundColor),
        side: MaterialStateProperty.all(
          BorderSide(
            color: isSelected ? MyMateThemes.primaryColor : MyMateThemes.secondaryColor,
            width: 2,
          ),
        ),
        fixedSize: MaterialStateProperty.all(Size(width * 0.3, width * 0.3)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder()),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: width * 0.1, color: MyMateThemes.primaryColor),
          SizedBox(height: width * 0.02),
          Text(
            gender,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: width * 0.04),
          ),
        ],
      ),
    );
  }
}

Widget InputField(String inputName, TextEditingController nameController, double width,double height) {

  return SizedBox(
    width: width * 0.8,
    height: height*0.08,
    child: TextField(
      controller: nameController,
      decoration: InputDecoration(
        label: Text(inputName),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: MyMateThemes.textColor.withOpacity(0.6),
          fontSize:width*0.05 ,
          letterSpacing: 0.8,
        ),
      ),
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: MyMateThemes.textColor,
        fontSize: width*0.05,
      ),
    ),
  );
}


class NextButton extends StatelessWidget {
  final ClientData clientData;
  final PersonalDetails personalDetails;
  final TextEditingController firstTextController;
  final TextEditingController lastTextController;
  final String selectedGender;
  final double width;
  final double height;

  NextButton({
    required this.clientData,
    required this.personalDetails,
    required this.firstTextController,
    required this.lastTextController,
    required this.selectedGender,
    required this.width,
    required this.height,

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
        MaterialPageRoute(builder: (context) => PlaceDateTimeInput(clientData: clientData)),
      );
    } else {
      print("Error Status: ${response.statusCode}");
      print("Error Body: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.08,
      width: width * 0.42,
      child: ElevatedButton(
        onPressed: () => updateClientProfile(context),
        style: CommonButtonStyle.commonButtonStyle(),
        child: Text(
          "Get Started",
          style: TextStyle(fontSize: width * 0.04),
        ),
      ),
    );
  }
}
