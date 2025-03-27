import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Homepages/HomeScreenBeforeSubscribe.dart';
import '../Homepages/ProfilePageScreen/navamsaChartDesign.dart';
import '../Homepages/ProfilePageScreen/rasiChartDesign.dart';
import '../MyMateThemes.dart';
import '../dbConnection/ClientDatabase.dart';
import 'PlaceDateTimeInput.dart';


class AutogeneratechartPage extends StatefulWidget {
  final String docId;
  const AutogeneratechartPage({super.key,required this.docId});

  @override
  State<AutogeneratechartPage> createState() => _AutogeneratechartPageState();
}

class _AutogeneratechartPageState extends State<AutogeneratechartPage> {
  ClientData clientData = ClientData();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
      AppBar(
        backgroundColor: Colors.white,
        title: Text('Your Horoscope', style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.w500 ,color: MyMateThemes.textColor,letterSpacing: 0.6)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: MyMateThemes.primaryColor,size: height*0.025,),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlaceDateTimeInput(clientData: clientData,docId: widget.docId,)));
          },
        ),

      ),
      body:SingleChildScrollView(

        child: Center(
          child: Column(
            children: [
              SvgPicture.asset('assets/images/Line 11.svg',width: width*0.85,),
              SizedBox(height: height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    height:height*0.08,
                    width: width*0.35,
                    decoration: BoxDecoration(
                      color: MyMateThemes.containerColor,
                      borderRadius: BorderRadius.circular(width * 0.02), // Responsive border radius
                    ),
                    child:
                    Center(
                      child: Text('name',style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.04,fontWeight: FontWeight.normal)),

                    ),
                  ),
                  SizedBox(width: width*0.03,),
                  Container(
                    height:height*0.08,
                    width: width*0.35,
                    decoration: BoxDecoration(
                      color: MyMateThemes.primaryColor,
                      borderRadius: BorderRadius.circular(width * 0.02), // Responsive border radius
                    ),
                    child:
                    Center(
                      child: Text('dob',style: TextStyle(color: Colors.white,fontSize: width*0.04,fontWeight: FontWeight.normal)),

                    ),

                  ),
                ],
              ),
              SizedBox(height: height*0.02,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height:height*0.08,
                    width: width*0.35,
                    decoration: BoxDecoration(
                      color: MyMateThemes.containerColor,
                      borderRadius: BorderRadius.circular(width * 0.02), // Responsive border radius
                    ),
                    child:
                        Center(
                          child: Text('rasi',style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.04,fontWeight: FontWeight.normal)),

                        ),

                  ),
                  SizedBox(width: width*0.03,),
                  Container(
                    height:height*0.08,
                    width: width*0.35,
                    decoration: BoxDecoration(
                      color: MyMateThemes.containerColor,
                      borderRadius: BorderRadius.circular(width * 0.02), // Responsive border radius
                    ),
                    child:  Center(
                      child: Text('nadchathira',style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.04,fontWeight: FontWeight.normal)),

                    ),

                  ),

                ],
              ),
              SizedBox(height: height*0.03,),
              RasiChartDesign(context),
              SizedBox(height: height * 0.03),
              NavamsaChartDesign(context),
              SizedBox(height: height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: height*0.08,
                    width: width*0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreenBeforeSubscibe(0,docId: widget.docId,)));
                      },
                      style: CommonButtonStyle.commonButtonStyle(),
                      child:  Text(
                        "Next",
                        style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.06),

                ],
              ),
              SizedBox(height: height * 0.06),

            ],
          ),
        ),
      ) ,
    );
  }
}
