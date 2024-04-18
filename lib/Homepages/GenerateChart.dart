import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';

import 'NameAndGenderPage.dart';


class GenerateChart extends StatefulWidget{
  const GenerateChart({super.key});
  @override
  State<GenerateChart> createState() => _GenerateChartState();
}

class _GenerateChartState extends State<GenerateChart>{
  List<DropdownMenuItem> dropdownMenuEntries =[
DropdownMenuItem(child: Text("Jaffna")),
    DropdownMenuItem(child: Text("Kokkuvil"))
  ];
  void onDateChanged(){
    print("Hi");
  }
  void onPressed(){
    print("object");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundWhite,
      body: SafeArea(

          child: Center(
            child: Column(
              children: [
                Container(
                  height: 10,
                ),
                const Flex(direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Enter birth details",
                      style: TextStyle(fontSize: MyMateThemes.nomalFontSize,
                      ),),
                    SizedBox(height: 10),
                    Text("to calculate your Astrology chart",
                      style: TextStyle(fontSize: MyMateThemes.subHeadFontSize,
                          color: MyMateThemes.textGreen),),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16 ),
                      child:Text("Make sure this number can receive SMS. "
                          "You will receive your activation code "
                          "through it."),),
                    SizedBox(height: 30),
                  ],),
                Container(
                  width: 300,
                  child: Column(
                    children: [
                      CalendarDatePicker(initialDate: null, firstDate: DateTime.timestamp(), lastDate: DateTime.timestamp(), onDateChanged: (value) => {Colors.red},),
                      SizedBox(height: 15,),
                      TextField(
                        decoration: GenerateChartsInputs("Place of birth (city)"),
                      ),
                      SizedBox(height: 15,),
                      TextField(
                        decoration: GenerateChartsInputs("Place of birth (city)"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 58,
                  width: 166,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: CommonButtonStyle.commonButtonStyle(),
                    child: Text(
                      "Next"
                      ,style: TextStyle(fontSize: MyMateThemes.buttonFontSize),),
                  ),
                ),


              ],
            ),
          )),
    );
  }

}

class GenerateChartsInputs extends InputDecoration{
  final String myHint;

  const GenerateChartsInputs(this.myHint);
  @override
  // TODO: implement hintText
  String? get hintText => myHint;


  @override
  // TODO: implement hintStyle
  TextStyle? get hintStyle => const TextStyle(
    fontSize: 20,
    fontFamily: "Work Sans",
  );
}