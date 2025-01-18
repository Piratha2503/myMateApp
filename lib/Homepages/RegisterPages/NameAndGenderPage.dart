import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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
  String selectedGender = ""; // To track the selected gender

  void updateSelectedGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.clientData.contactInfo?.mobile);
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
    PersonalDetails? personalDetails = PersonalDetails();

    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      body: Column(
        children: [
          Form(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 75),
                  Text('Enter your details',style: TextStyle(color: MyMateThemes.textColor,fontSize: 24,fontWeight: FontWeight.w800,letterSpacing: 0.8),),
                  SizedBox(height: 30),
                  InputField("First name", firstNameController),
                  SizedBox(height: 10),
                  InputField("Last name", lastNameController),
                  SizedBox(height: 30),
                  GenderButtons(personalDetails),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NextButton(
                clientData: widget.clientData,
                personalDetails: personalDetails,
                firstTextController: firstNameController,
                lastTextController: lastNameController,
              ),
              SizedBox(width: 25),
            ],
          ),
        ],
      ),
    );
  }

  Widget GenderButtons(PersonalDetails? personalDetails) {
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
              personalDetails?.gender = selectedGender;
            });
          },
        ),
        SizedBox(width: 40),
        GenderButton(
          gender: "Female",
          icon: Icons.female_outlined,
          isSelected: selectedGender == "Female",
          onSelected: () {
            setState(() {
              selectedGender = "Female";
              personalDetails?.gender = selectedGender;
            });
          },
        ),
      ],
    );
  }
}

class GenderButton extends StatefulWidget {
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
  _GenderButtonState createState() => _GenderButtonState();
}

class _GenderButtonState extends State<GenderButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onSelected,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyMateThemes.backgroundColor),
        foregroundColor: MaterialStateProperty.all(MyMateThemes.primaryColor),
        side: MaterialStateProperty.all(
          BorderSide(
            color: widget.isSelected
                ? MyMateThemes.primaryColor
                : MyMateThemes.secondaryColor,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        fixedSize: MaterialStateProperty.all(Size(120, 120)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder()),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 70,
            color: MyMateThemes.primaryColor,
          ),
          SizedBox(height: 8),
          Text(
            widget.gender,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: MyMateThemes.textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

Widget InputField(String inputName, TextEditingController nameController) {
  return SizedBox(
    width: 300,
    height: 75,
    child: TextField(
      controller: nameController,
      decoration: InputDecoration(
        label: Text(inputName),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: MyMateThemes.textColor.withOpacity(0.6),
          fontSize: 20,
          letterSpacing: 0.8,
        ),
      ),
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: MyMateThemes.textColor,
        fontSize: 20,
      ),
    ),
  );
}

class NextButton extends StatelessWidget {
  final ClientData clientData;
  final PersonalDetails personalDetails;
  final TextEditingController firstTextController;
  final TextEditingController lastTextController;

  NextButton({
    required this.clientData,
    required this.personalDetails,
    required this.firstTextController,
    required this.lastTextController,
    super.key,
  });

  Future<void> updateClientProfile(BuildContext context) async {
    personalDetails.first_name = firstTextController.text;
    personalDetails.last_name = lastTextController.text;
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
        MaterialPageRoute(builder: (context) => ChartOptions(clientData: clientData)),
      );
    } else {
      print("Error Status: ${response.statusCode}");
      print("Error Body: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: 166,
      child: ElevatedButton(
        onPressed: () {
          updateClientProfile(context);
        },
        style: CommonButtonStyle.commonButtonStyle(),

        child: Text(
          "Get Started",
          style: TextStyle(fontSize: MyMateThemes.buttonFontSize),
        ),
      ),
    );
  }
}
