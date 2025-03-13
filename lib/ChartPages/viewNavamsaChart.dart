import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:mymateapp/ChartPages/viewRasiChart.dart';
import 'package:mymateapp/Homepages/HomeScreenBeforeSubscribe.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/navamsaChartDesign.dart';
import 'package:mymateapp/MyMateCommonBodies/MyMateApis.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:http/http.dart' as http;
import '../Homepages/RegisterPages/ChartOptions.dart';
import '../Matching/RasiAndNadchathiram.dart';
import '../dbConnection/ClientDatabase.dart';
import 'AutoGenerateChart.dart';
import 'ManualChartEnter.dart';
import 'ManualNavamsaChartPage.dart';
import 'ManualRasiChartPage.dart';

class ViewNavamsaChartPage extends StatefulWidget {
  ClientData clientData;
  ViewNavamsaChartPage({super.key, required this.clientData});




  @override
  State<ViewNavamsaChartPage> createState() => _ViewNavamsaChartPageState();



}



class _ViewNavamsaChartPageState extends State<ViewNavamsaChartPage> {
  TextEditingController textEditingController = TextEditingController();
  String rasiDetails = "Enter Navamsa Chart details";
  String calculate = "to calculate Astrology chart ";
  String text1 = "For the manual entry, very first you";
  String text2 = "have to align the number of the chart ";
  String text3 = "which start from and second you need";
  String text4 = "to enter the planets in the box with ";
  String text5 = "appropriate number ";
  String district = "";
  ClientData clientData = ClientData();
  Astrology astrology = Astrology();


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          // Read width and height from constraints to use for responsive sizing.
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: MyMateThemes.primaryColor),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewRasiChartPage(clientData:clientData ,)));
                },
              ),

            ),
            body:
              Column(
                children: <Widget>[

                  Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(rasiDetails,
                        style: TextStyle( fontSize: width*0.054,fontWeight: FontWeight.w700 ,color: MyMateThemes.textColor,letterSpacing: 0.8),
                      ),
                      // SizedBox(height:5),
                      Text( calculate,
                        style: TextStyle( fontSize: width*0.054,fontWeight: FontWeight.w700 ,color: MyMateThemes.primaryColor,letterSpacing: 0.8),

                      ),
                      SizedBox(height: height*0.02),
                      Text(text1,style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.037,fontWeight: FontWeight.normal,letterSpacing: 0.8),),
                      Text(text2,style: TextStyle(color: MyMateThemes.textColor,fontSize:  width*0.037,fontWeight: FontWeight.normal,letterSpacing: 0.8),),
                      Text(text3,style: TextStyle(color: MyMateThemes.textColor,fontSize:  width*0.037,fontWeight: FontWeight.normal,letterSpacing: 0.8),),
                      Text(text4,style: TextStyle(color: MyMateThemes.textColor,fontSize:  width*0.037,fontWeight: FontWeight.normal,letterSpacing: 0.8),),
                      Text(text5,style: TextStyle(color: MyMateThemes.textColor,fontSize:  width*0.037,fontWeight: FontWeight.normal,letterSpacing: 0.8),),

                    ],
                  ),

                  SizedBox(height: height*0.03,),
                  GestureDetector(
                    onTap:(){Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManualNavamsaChartPage(clientData: clientData, astrology:astrology)));} ,
                    child: NavamsaChartDesign(context),

                  ),

                  SizedBox(height: height*0.09,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height*0.08,
                        width: width*0.35,
                        child: ElevatedButton(
                          onPressed: ()
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ManualNavamsaChartPage(clientData: clientData, astrology:astrology ,)));

                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
                            backgroundColor: MaterialStatePropertyAll(MyMateThemes.secondaryColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(width*0.01)
                                )),

                          ),
                          child:  Text(
                            "Edit",
                            style: TextStyle(fontSize: width*0.05),
                          ),
                        ),
                      ),
                      SizedBox(width: width*0.04),
                      SizedBox(
                        height: height*0.08,
                        width: width*0.35,
                        child: ElevatedButton(
                          onPressed: ()
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreenBeforeSubscibe(0, docId: '')));
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
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: width*0.04),
                          ),
                        ),
                      ),

                    ],
                  ),

                ],
              ),

          );
        }
    );
  }


}