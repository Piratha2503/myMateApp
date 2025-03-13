import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Homepages/HomeScreenBeforeSubscribe.dart';
import '../Homepages/ProfilePageScreen/navamsaChartDesign.dart';
import '../Homepages/ProfilePageScreen/rasiChartDesign.dart';
import '../MyMateThemes.dart';
import '../dbConnection/ClientDatabase.dart';
import 'PlaceDateTimeInput.dart';


class AutogeneratechartPage extends StatefulWidget {
  const AutogeneratechartPage({super.key});

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
        title: Text('Your Horoscope', style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.05,fontWeight: FontWeight.w500)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: MyMateThemes.primaryColor),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlaceDateTimeInput(clientData: clientData,)));
          },
        ),

      ),
      body:SingleChildScrollView(
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
                    color: MyMateThemes.secondaryColor,
                    borderRadius: BorderRadius.circular(width * 0.02), // Responsive border radius
                  ),
                  child:
                  Center(
                    child: Text('name',style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.04,fontWeight: FontWeight.w500)),

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
                    child: Text('dob',style: TextStyle(color: Colors.white,fontSize: width*0.04,fontWeight: FontWeight.w500)),

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
                    color: MyMateThemes.secondaryColor,
                    borderRadius: BorderRadius.circular(width * 0.02), // Responsive border radius
                  ),
                  child:
                      Center(
                        child: Text('rasi',style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.04,fontWeight: FontWeight.w500)),

                      ),

                ),
                SizedBox(width: width*0.03,),
                Container(
                  height:height*0.08,
                  width: width*0.35,
                  decoration: BoxDecoration(
                    color: MyMateThemes.secondaryColor,
                    borderRadius: BorderRadius.circular(width * 0.02), // Responsive border radius
                  ),
                  child:  Center(
                    child: Text('nadchathira',style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.04,fontWeight: FontWeight.w500)),

                  ),

                ),

              ],
            ),
            SizedBox(height: height*0.03,),
            RasiChartDesign(context),
            SizedBox(height: height * 0.03),
            NavamsaChartDesign(context),
            SizedBox(height: height * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height:height * 0.06 ,
                  width: width * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreenBeforeSubscibe(0,docId: '',)));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyMateThemes.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.025),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal:width * 0.05,
                          vertical: height * 0.015,
                        ),
                        foregroundColor: Colors.white),
                    child: Text('Next'),
                  ),
                ),
                SizedBox(width: width * 0.06),

              ],
            ),
            SizedBox(height: height * 0.04),

          ],
        ),
      ) ,
    );
  }
}
