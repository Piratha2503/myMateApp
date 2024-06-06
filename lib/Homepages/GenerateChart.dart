import 'package:csc_picker/dropdown_with_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/ThirdpartyLibraries/GoogleAPIs.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';

class GenerateChart extends StatefulWidget {
  const GenerateChart({super.key});
  @override
  State<GenerateChart> createState() => _GenerateChartState();
}

class _GenerateChartState extends State<GenerateChart> {

  void onDateChanged() {
    print("Hi");
  }

  void onPressed() {
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
              SizedBox( height: 10,),
               Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(
                  "Enter birth details",
                  style: TextStyle(
                    fontSize: MyMateThemes.nomalFontSize,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "to calculate your Astrology chart",
                  style: TextStyle(
                      fontSize: MyMateThemes.subHeadFontSize,
                      color: MyMateThemes.textColor),
                ),
                SizedBox(height: 15),
              ],
            ),
            Container(
              width: 300,
              child: Column(
                children: [

                  SizedBox( height: 15,),
                  GooglePlacesAPI("Place of birth (city)"),
                  SizedBox( height: 7,),
                  ScrollDate(),
                  SizedBox( height: 7,),
                  RasiNadchathiramInput("Rasi"),
                  SizedBox( height: 7,),
                  RasiNadchathiramInput("Nadchathiram"),
                ],
              ),
            ),
            SizedBox( height: 30,),
            SizedBox(
              height: 58,
              width: 166,
              child: ElevatedButton(
                onPressed: onPressed,
                style: CommonButtonStyle.commonButtonStyle(),
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: MyMateThemes.buttonFontSize),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget RasiNadchathiramInput(String args){
    String Rasi = "Your $args";
    bool Nadchathiram = false;

    List<String> rasiList = [
      "Mesham", "Rishabam", "Mithunam", "Kadagam", "Simmam", "Kanni",
      "Thulam", "Viruchigam", "Thanusu", "Magaram", "Kumbam", "Meenam"
    ];
    List<String> nadchathiraList = [
      "Ashwini",  "Bharani", "Krittika", "Rohini", "Mrigashira",
      "Arunthathi", "PunarPoosam", "Poosam", "Aayilyam", "Magam",
      "Pooram", "Uththaram", "Hastham", "Chithra", "Swathi",
      "Vishakam", "Anusham", "Keddai", "Moolam", "Pooradam",
      "Utharadam", "Sathaya", "Thiruvonam", "Aviddam", "Pooraddathi",
      "Uththaradathi", "Revathi",

    ];
    if(args == "Nadchathiram") Nadchathiram = true;
    return DropdownWithSearch(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black45,
            width: 1.5,
          ),
        ),
      ),
        title: "$args",
        placeHolder: "Search your $args",
        items: Nadchathiram ? nadchathiraList : rasiList,
        onChanged: (val){
          Rasi = val;
          print(Rasi);
        },
        selected: Rasi,
        label: "",
      itemStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      selectedItemStyle: TextStyle(
        color: Colors.black54,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
Widget ScrollDate(){
  DateTime _selectedDate = DateTime.now();
    void onDateTimeChanged(DateTime date){
      print(date);
    }
    return SizedBox(
      height: 200,
      child: ScrollWheelDatePicker(

          theme: FlatDatePickerTheme(
              backgroundColor: MyMateThemes.backgroundColor,
              itemTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              )
          )
      ),
    );
}
}

class GenerateChartsInputs extends InputDecoration {
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

/*

 */