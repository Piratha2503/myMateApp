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
    clientProfile.name = "Piratha";
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyMateThemes.backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            Form(
                child: Column(
                  children: [
                  InputField("First name",firstNameController),
                    SizedBox(height: 50,),
                  InputField("Last name",lastNameController),
                    SizedBox( height: 50,),
                  GenderButtons(),
                    SizedBox(height: 65,),
                  NextButton(clientProfile),
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
    height: 50, // Set the height of the TextField
    child: TextField(
      controller: nameController,
      decoration: InputDecoration(
        hintText: inputName,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 25,
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
  void onPressed(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=> ChartOptions(clientProfile: clientProfile)));
  }
    NextButton(this.clientProfile, {super.key});

    @override
    Widget build(BuildContext context){

      return SizedBox(
        height: 58,
        width: 166,
        child: ElevatedButton(
          onPressed: (){
            onPressed(context);
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

