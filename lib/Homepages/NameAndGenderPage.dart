import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/ChartOptions.dart';
import 'package:mymateapp/MyMateThemes.dart';

class NameAndGender extends StatefulWidget {

  const NameAndGender({super.key});

  @override
  State<NameAndGender> createState() => _NameAndGenderState();

}

class _NameAndGenderState extends State<NameAndGender> {


  String Gender = "";
  void Changed(String gen) {
    setState(() {
      Gender = "Male";
    });
  }

  void onPressed() {
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>const ChartOptions()));
  }

  @override
  Widget build(BuildContext context) {

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
                  InputField("First name"),
                Container( height: 50,),
                  InputField("Last name"),
                Container( height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GenderButton("Male",Icons.male_rounded),
                    SizedBox(width: 50,),
                    GenderButton("Fe-Male",Icons.female_outlined),
                  ],
                ),
                const SizedBox(height: 65,),
                SizedBox(
                  height: 58,
                  width: 166,
                  child: ElevatedButton(onPressed: onPressed,
                    style: CommonButtonStyle.commonButtonStyle(),
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: MyMateThemes.buttonFontSize),
                    ),
                  ),
                ),
              ],
            ),
            )
          ],
        ),
      ),
    );
  }

}

ElevatedButton GenderButton(String gender,IconData icon){

  return ElevatedButton.icon(
    onPressed: (){
     _NameAndGenderState().Changed(gender);
    },
    label: const Text(""),
    icon: Icon(icon),
    style: const ButtonStyle(
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

SizedBox InputField(String inputName){
  return SizedBox(
    width: 300, // Set the width of the TextField
    height: 50, // Set the height of the TextField
    child: TextField(
      decoration: InputDecoration(
          hintText: inputName,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
    ),
  ),
  );
}


