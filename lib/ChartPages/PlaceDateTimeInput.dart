import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:mymateapp/MyMateCommonBodies/MyMateApis.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:http/http.dart' as http;
import '../Homepages/RegisterPages/ChartOptions.dart';
import '../dbConnection/ClientDatabase.dart';

class PlaceDateTimeInput extends StatefulWidget {
  ClientData clientData;
  PlaceDateTimeInput({super.key, required this.clientData});

  @override
  State<PlaceDateTimeInput> createState() => _PlaceDateTimeInputState();

  String date_default_text = "Date of birth";
  String time_default_text = 'Time of birth';
}

class _PlaceDateTimeInputState extends State<PlaceDateTimeInput> {
  TextEditingController textEditingController = TextEditingController();
  String birthDetails = "Enter birth details";
  String calculate = "to calculate Astrology chart ";
  String text1 = "Make sure this number can receive SMS.";
  String text2 = "You will receive your activation code";
  String text3 = "through it.";
  String district = "";


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          // Read width and height from constraints to use for responsive sizing.
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(birthDetails,
                      style: TextStyle( fontSize: width*0.054,fontWeight: FontWeight.w700 ,color: MyMateThemes.textColor,letterSpacing: 0.8),
                    ),
                    // SizedBox(height:5),
                    Text( calculate,
                      style: TextStyle( fontSize: width*0.054,fontWeight: FontWeight.w700 ,color: MyMateThemes.primaryColor,letterSpacing: 0.8),

                    ),
                    SizedBox(height: height*0.02),
                    Text(text1,style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.038,fontWeight: FontWeight.normal,letterSpacing: 0.5),),
                    Text(text2,style: TextStyle(color: MyMateThemes.textColor,fontSize:  width*0.038,fontWeight: FontWeight.normal,letterSpacing: 0.5),),
                    Text(text3,style: TextStyle(color: MyMateThemes.textColor,fontSize:  width*0.038,fontWeight: FontWeight.normal,letterSpacing: 0.5),),

                    SizedBox(height: height*0.03),
                  ],
                ),
                Center(
                  child: SizedBox(
                    width: width*0.8,
                    child: GooglePlaceAutoCompleteTextField(
                      countries: ["LK"],
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: width*0.045,
                          color:MyMateThemes.textColor
                      ),
                      boxDecoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1.0,color:MyMateThemes.textColor.withOpacity(0.3)))
                      ),
                      textEditingController: textEditingController,
                      googleAPIKey: "AIzaSyAFhnkirk4iFypOdxfiECUWKRVOtE0azMo",
                      inputDecoration: InputDecoration(
                        hintText: "Place of birth (city)",
                        hintStyle: TextStyle(
                          color:MyMateThemes.textColor.withOpacity(0.3),
                          fontWeight: FontWeight.w600,
                          fontSize: width*0.045,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      debounceTime: 400,
                      isLatLngRequired: true,
                      getPlaceDetailWithLatLng: (Prediction prediction) {
                        print("placeDetails${prediction.lat}");
                      },
                      itemClick: (Prediction prediction) {
                        List<String>? stringList = prediction.description?.split(",");
                        setState(() {
                          district = stringList![0].toString();

                        });
                        textEditingController.text = prediction.description ?? "";
                        textEditingController.selection = TextSelection.fromPosition(
                            TextPosition(offset: prediction.description?.length ?? 0));
                      },
                      seperatedBuilder: Divider(),
                      containerHorizontalPadding: width*0.03,
                      itemBuilder: (context, index, Prediction prediction) {
                        return Container(
                          padding: EdgeInsets.all(width*0.01),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: width*0.02),
                              Expanded(
                                  child: Text(
                                    prediction.description ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: width*0.03,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        );
                      },
                      isCrossBtnShown: true,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                      width: width*0.8,

                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color: MyMateThemes.textColor.withOpacity(0.3)))
                      ),

                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:width*0.028),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon:  Icon(Icons.calendar_month,color: MyMateThemes.primaryColor,),
                            hintText:  widget.date_default_text,

                            hintStyle: TextStyle(

                              color: MyMateThemes.textColor.withOpacity(0.3),
                              fontWeight: FontWeight.w600,
                              fontSize: width*0.045,),

                          ),
                          onTap: (){
                            DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                onConfirm: (date){
                                  print(date.toLocal());
                                  setState(() {
                                    String year = date.year.toString().padLeft(2, '0');
                                    String month = date.month.toString().padLeft(2, '0');
                                    String day = date.day.toString().padLeft(2, '0');
                                    widget.date_default_text = '$year-$month-$day';

                                  });
                                }
                            );
                          },
                        ),
                      )
                  ),
                ),
                Center(
                  child: Container(
                      width: width*0.77,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color: MyMateThemes.textColor.withOpacity(0.3)))
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(width*0.01),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.alarm,color: MyMateThemes.primaryColor,),
                              hintText: widget.time_default_text,
                              hintStyle: TextStyle(
                                color: MyMateThemes.textColor.withOpacity(0.3),
                                fontWeight: FontWeight.w600,
                                fontSize: width*0.045,
                              ),
                              border: InputBorder.none
                          ),
                          onTap: (){
                            DatePicker.showTimePicker(
                                context,
                                showTitleActions: true,
                                onConfirm: (date){
                                  print(date.toLocal());
                                  setState(() {
                                    String hour = date.hour.toString().padLeft(2, '0');
                                    String minute = date.minute.toString().padLeft(2, '0');
                                    String second = date.second.toString().padLeft(2, '0');
                                    print('$hour-$minute-$second');
                                    widget.time_default_text =   "$hour:$minute:$second";

                                  });
                                }
                            );
                          },
                        ),
                      )
                  ),
                ),
                SizedBox(height: height*0.1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: height*0.08,
                      width: width*0.35,
                      child: ElevatedButton(
                        onPressed: ()
                        {
                          updatePlaceDateTime();
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(Colors.white),
                          backgroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(width*0.01)
                              )),

                        ),
                        child:  Text(
                          "Next",
                          style: TextStyle(fontSize: width*0.05),
                        ),
                      ),
                    ),
                    SizedBox(width: width*0.1,),

                  ],
                ),

              ],
            ),
          ),
        );
      }
    );
  }

  Future<void> updatePlaceDateTime() async{

    Astrology astrology = Astrology();
    astrology.dob = widget.date_default_text;
    astrology.dot = widget.time_default_text;
    astrology.birth_location = district;
    widget.clientData.astrology = astrology;
    print(jsonEncode(widget.clientData.toMap()));

    final url = Uri.parse("https://backend.graycorp.io:9000/mymate/api/v1/updateClient");
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(widget.clientData.toMap()),
    );
    if(response.statusCode == 200){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChartOptions(clientData: widget.clientData)),
      );
    }
    else {
      print(response.body);
    }
  }

}