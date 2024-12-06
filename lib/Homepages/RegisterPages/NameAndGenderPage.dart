import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/RegisterPages/ChartOptions.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/Clients.dart';

class NameAndGender extends StatefulWidget {

  const NameAndGender({super.key});

  @override
  State<NameAndGender> createState() => _NameAndGenderState();

}

class _NameAndGenderState extends State<NameAndGender> {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();


  String Gender = "";
  void Changed(String gen) {
    setState(() {
      Gender = "Male";
    });
  }

  @override
  Widget build(BuildContext context) {

    TestClient clientProfile = TestClient();
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,

      body: Center(
        child: Column(
          children: [
            Form(
                child: Column(
                  children: [
                    SizedBox(height: 85,),
                  InputField("First name",firstNameController),
                    SizedBox(height: 10,),
                  InputField("Last name",lastNameController),
                    SizedBox( height: 50,),
                  GenderButtons(),
                    SizedBox(height: 60,),
                  NextButton(clientProfile,firstNameController,lastNameController),
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

Widget GenderButtons(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GenderButton("Male",Icons.male_rounded),
      SizedBox(width: 50,),
      GenderButton("Fe-Male",Icons.female_outlined),
    ],
  );
}

Widget GenderButton(String gender,IconData icon){

  return ElevatedButton.icon(
    onPressed: (){
     _NameAndGenderState().Changed(gender);
    },
    label: Text(""),
    icon: Icon(icon),
    style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.indigo),
        alignment: Alignment.center,
        textStyle: MaterialStatePropertyAll(TextStyle(
            fontWeight: FontWeight.w800
        )),
        iconSize: MaterialStatePropertyAll(70),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder()),
        fixedSize: MaterialStatePropertyAll(Size(120, 120))
    ),
  );
}

class NextButton extends StatelessWidget{
  TestClient clientProfile;
  TextEditingController firstNameController;
  TextEditingController lastNameController;

  NextButton(this.clientProfile,this.firstNameController,this.lastNameController, {super.key,});

  void onPressed(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=> ChartOptions(clientProfile: clientProfile)));
  }

    @override
    Widget build(BuildContext context){
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;

      return SizedBox(
        height: 58,
        width: 166,
        child: ElevatedButton(
          onPressed: (){
            clientProfile.name = "$firstName $lastName";
            onPressed(context);
            print(clientProfile.name);
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

