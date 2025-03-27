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
import 'AutoGenerateChart.dart';

class PlaceDateTimeInput extends StatefulWidget {
  ClientData clientData;
  final String docId;
  PlaceDateTimeInput({super.key, required this.clientData,required this.docId});

  @override
  State<PlaceDateTimeInput> createState() => _PlaceDateTimeInputState();

  String date_default_text = "Date of birth";
  String time_default_text = 'Time of birth';
}


class _PlaceDateTimeInputState extends State<PlaceDateTimeInput> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  String birthDetails = "Enter birth details";
  String calculate = "to calculate Astrology chart ";
  String text1 = "Make sure this number can receive SMS.";
  String text2 = "You will receive your activation code";
  String text3 = "through it.";
  String district = "";
  ClientData clientData = ClientData();



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, size:height*0.025,color: MyMateThemes.primaryColor),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChartOptions(clientData:clientData )));
              },
            ),

          ),
          body: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                SizedBox(height: height*0.01),

                Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(birthDetails,
                      style: TextStyle( fontSize: width*0.05,fontWeight: FontWeight.w500 ,color: MyMateThemes.textColor,letterSpacing:0.8),
                    ),
                    // SizedBox(height:5),
                    Text( calculate,
                      style: TextStyle( fontSize: width*0.05,fontWeight: FontWeight.w500 ,color: MyMateThemes.primaryColor,letterSpacing: 0.8),

                    ),
                    SizedBox(height: height*0.02),
                    Text(text1,style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.036,fontWeight: FontWeight.normal),),
                    Text(text2,style: TextStyle(color: MyMateThemes.textColor,fontSize:  width*0.036,fontWeight: FontWeight.normal),),
                    Text(text3,style: TextStyle(color: MyMateThemes.textColor,fontSize:  width*0.036,fontWeight: FontWeight.normal),),

                    SizedBox(height: height*0.03),
                  ],
                ),

                Center(
                  child: SizedBox(
                    width: width*0.8,
                    child: GooglePlaceAutoCompleteTextField(
                      countries: ["LK"],
                      // textStyle: TextStyle(
                      //     fontWeight: FontWeight.w600,
                      //     fontSize: width*0.045,
                      //     color:MyMateThemes.textColor
                      // ),
                      boxDecoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(width: 1.0,color:MyMateThemes.textColor.withOpacity(0.3)))
                      ),
                      textEditingController: textEditingController,
                      googleAPIKey: "AIzaSyAFhnkirk4iFypOdxfiECUWKRVOtE0azMo",
                      inputDecoration: InputDecoration(
                        hintText: "Place of birth (city)",
                        hintStyle: TextStyle(
                          color:MyMateThemes.textColor.withOpacity(0.3),
                          fontWeight: FontWeight.normal,
                          fontSize: width*0.042,
                        ),

                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: MyMateThemes.textColor,
                        fontSize: width*0.042,
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
                      seperatedBuilder: Container(
                        height: height*0.002,
                        color: Colors.transparent, // Ensure transparent background
                        child: Divider(
                          color: MyMateThemes.textColor,
                        ),
                      ),
                      containerHorizontalPadding: width*0.03,

                      itemBuilder: (context, index, Prediction prediction) {
                        return Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(width*0.006),
                          // decoration: ,
                          child: Row(
                            children: [
                              Icon(Icons.location_on,color: MyMateThemes.textColor,),
                              SizedBox(width: width*0.02),
                              Expanded(
                                  child: Text(
                                    prediction.description ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: MyMateThemes.textColor,
                                      fontSize: width*0.035,
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
                SizedBox(height: height*0.01),

                Center(
                  child: Container(
                    width: width * 0.8,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: MyMateThemes.textColor.withOpacity(0.3),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.028),
                      child: TextField(
                        controller: _dateController, // Use _dateController directly
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.calendar_month, color: MyMateThemes.primaryColor),
                          hintText: widget.date_default_text,
                          hintStyle: TextStyle(
                            color: MyMateThemes.textColor.withOpacity(0.3),
                            fontWeight: FontWeight.normal,
                            fontSize: width * 0.042,
                          ),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: MyMateThemes.textColor,
                          fontSize: width * 0.042,
                        ),
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              setState(() {
                                String year = date.year.toString().padLeft(2, '0');
                                String month = date.month.toString().padLeft(2, '0');
                                String day = date.day.toString().padLeft(2, '0');
                                _dateController.text = '$year-$month-$day';
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height*0.01),

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
                          controller: _timeController, // Use _dateController directly
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.alarm,color: MyMateThemes.primaryColor,),
                              hintText: widget.time_default_text,
                              hintStyle: TextStyle(
                                color: MyMateThemes.textColor.withOpacity(0.3),
                                fontWeight: FontWeight.normal,
                                fontSize: width*0.042,
                              ),
                              border: InputBorder.none
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: MyMateThemes.textColor,
                            fontSize: width*0.042,
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
                                    _timeController.text =   "$hour:$minute:$second";

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
                        onPressed:  () async
                        {
                         await updatePlaceDateTime();
                        await  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AutogeneratechartPage(docId:widget.docId)));
                        },
                        style: CommonButtonStyle.commonButtonStyle(),

                        child:  Text(
                          "Next",
                          style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.normal),
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



  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();

    super.dispose();
  }
  Future<void> updatePlaceDateTime() async{

    Astrology astrology = Astrology();
    astrology.dob = widget.date_default_text;
    astrology.dot = widget.time_default_text;
    astrology.birth_location = district;
    widget.clientData.astrology = astrology;
    print(jsonEncode(widget.clientData.toMap()));
    print('docId in place dateinput :${clientData.docId}');

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