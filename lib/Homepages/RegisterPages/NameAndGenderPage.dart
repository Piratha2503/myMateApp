import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateCommonBodies/MyMateApis.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:mymateapp/dbConnection/Firebase_DB.dart';
import 'package:http/http.dart' as http;

import 'ChartOptions.dart';

class NameAndGender extends StatefulWidget {
  final ClientData clientData;
  const NameAndGender({super.key,required this.clientData});

  @override
  State<NameAndGender> createState() => _NameAndGenderState();

}

class _NameAndGenderState extends State<NameAndGender> {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.clientData.contactInfo?.mobile);
    getClientData();
  }

  Future<void> getClientData() async{

    final url = Uri.parse(MyMateAPIs.get_client_by_mobile);
    final response = await http.get(url);
    print(response);
    if(response.statusCode == 200){
      Map<String,dynamic> clientDocs = jsonDecode(response.body);
      widget.clientData.docId = clientDocs.values.firstOrNull;
      print(widget.clientData.docId);
    }
    else{
      print(response.statusCode);
      print(response.body);
    }

  }

  @override
  Widget build(BuildContext context) {

    PersonalDetails? personalDetails = PersonalDetails();

    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Form(
                child: Column(
                  children: [

                    SizedBox(height: 85,),
                    ElevatedButton(onPressed: (){
                      getClientData();
                      print("OK");
                    },
                        child: Text("Click")),
                  InputField("First name",firstNameController),
                    SizedBox(height: 10,),
                  InputField("Last name",lastNameController),
                    SizedBox( height: 50,),
                  GenderButtons(widget.clientData,personalDetails),
                    SizedBox(height: 60,),
                  NextButton(clientData: widget.clientData,personalDetails: personalDetails,firstTextController: firstNameController,lastTextController: lastNameController,),
              ],
                ),
            )
          ],
        ),
      ),
    );
  }

}

Widget InputField(String inputName, TextEditingController nameController){
  return SizedBox(
    width: 300, // Set the width of the TextField
    height: 75, // Set the height of the TextField
    child: TextField(
      controller: nameController,
      decoration: InputDecoration(
        label: Text(inputName,),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        fontWeight: FontWeight.w600,
            fontSize: 20,
      ),
    ),
  );
}

Widget GenderButtons(ClientData clientData, PersonalDetails? personalDetails){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GenderButton(clientData: clientData,personalDetails: personalDetails,gender: "Male",icon: Icons.male_outlined,),
      SizedBox(width: 50,),
      GenderButton(clientData: clientData,personalDetails: personalDetails,gender: "FeMale",icon: Icons.female_outlined,),
    ],
  );
}

class GenderButton extends StatefulWidget{
  ClientData? clientData;
  PersonalDetails? personalDetails;
  String? gender;
  IconData? icon;
  GenderButton({this.clientData,this.personalDetails,this.gender,this.icon,super.key});

  @override
  State<GenderButton> createState() => _GenderButtonState();

}

class _GenderButtonState extends State<GenderButton>{

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
         onPressed: (){
           setState(() {
            widget.personalDetails?.gender = widget.gender;
           });
           print(widget.personalDetails?.gender);
      },
      label: Text(""),
      icon: Icon(widget.icon),
      style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.indigo),
          alignment: Alignment.center,
          textStyle: MaterialStatePropertyAll(TextStyle(
              fontWeight: FontWeight.w800
          ),
          ),
          iconSize: MaterialStatePropertyAll(70),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder()),
          fixedSize: MaterialStatePropertyAll(Size(120, 120))
      ),
    );
  }
}

class NextButton extends StatelessWidget{
  final ClientData clientData;
  final PersonalDetails personalDetails;
  final TextEditingController firstTextController;
  final TextEditingController lastTextController;

  NextButton({required this.clientData,required this.personalDetails,required this.firstTextController,required this.lastTextController,super.key,});

  FirebaseDB firebaseDB = FirebaseDB();
  Future<void> updateClientProfile(BuildContext context) async{
    PersonalDetails updatedPersonalDetails = personalDetails;
    updatedPersonalDetails.first_name = firstTextController.text;
    updatedPersonalDetails.last_name = lastTextController.text;
    clientData.personalDetails = updatedPersonalDetails;
    firebaseDB.updateClient(clientData);
    Navigator.push(context,
     MaterialPageRoute(builder: (context)=> ChartOptions(clientData: clientData)));
  }

    @override
    Widget build(BuildContext context){

      return SizedBox(
        height: 58,
        width: 166,
        child: ElevatedButton(
          onPressed: (){
            updateClientProfile(context);
          },
          style: CommonButtonStyle.commonButtonStyle(),
          child: Text(
            "Next",
            style: TextStyle(fontSize: MyMateThemes.buttonFontSize),
          ),
        ),
      );

    }
}

