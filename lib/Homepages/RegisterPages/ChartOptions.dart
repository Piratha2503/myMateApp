import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/ChartPages/GenerateChart.dart';
import 'package:mymateapp/ChartPages/ManualRasiChartPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:mymateapp/dbConnection/Clients.dart';

import '../../ChartPages/ManualChartEnter.dart';
import '../../ChartPages/PlaceDateTimeInput.dart';

class ChartOptions extends StatefulWidget {
  final ClientData clientData;
  ChartOptions({super.key, required this.clientData});

  static List<String> rasiListOrder = [
    "Mesham",
    "Rishabam",
    "Mithunam",
    "Kadagam",
    "Simmam",
    "Kanni",
    "Thulam",
    "Viruchigam",
    "Thanusu",
    "Magaram",
    "Kumbam",
    "Meenam",
  ];
  static List<String> nadchathiraList = [
    "Ashwini"
        "Bharani"
        "Kiruthigai"
        "Rohini"
        "Mirugasheeridam"
        "Thiruvathirai"
        "Punarpusham"
        "Pusham"
        "Aayilyam"
        "Magham"
        "pooram"
        "Uththaram"
        "Ashththam"
        "Chitrai"
        "Swathi"
        "Vishakham"
        "Anusham"
        "Keddai"
        "Moolam"
        "pooradam"
        "Uththaradam"
        "Thiruvonam"
        "Aviddam"
        "Sathayam"
        "pooraddaathi"
        "Uththaraddathi"
        "Revathi"
  ];


  @override
  State<ChartOptions> createState() => _ChartOptionsState();
}

class _ChartOptionsState extends State<ChartOptions> {
  int? _selectedOptionIndex;

  ClientData clientData = ClientData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;

            return Center(
              child: Column(
                children: [
                  SizedBox(height: height * 0.08),
                  ChartOptionsTexts(),
                  SizedBox(height: height * 0.015),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedOptionIndex = 1;
                      });
                      print(widget.clientData.personalDetails?.first_name);
                      print(widget.clientData.personalDetails?.last_name);
                      print(widget.clientData.personalDetails?.gender);
                      print(widget.clientData.contactInfo?.mobile);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Builder(
                                builder: (context) {
                                 // return PlaceDateTimeInput(clientData: clientData,docId:clientData.docId!,);
                                  return PlaceDateTimeInput(clientData: clientData, docId: '',);

                                }
                              )));
                    },
                    child: buildOptionContainer(
                      "Generate the chart",
                      'assets/images/chart.svg',
                      _selectedOptionIndex == 1,

                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  SvgPicture.asset('assets/images/or.svg', width: width * 0.75),
                  SizedBox(height: height * 0.04),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedOptionIndex = 2;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManualChartEnter(clientData: widget.clientData),
                        ),
                      );
                    },
                    child: buildOptionContainer(
                      "Enter chart manually",
                      'assets/images/pointer.svg',
                      _selectedOptionIndex == 2,

                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget ChartOptionsTexts() {
    return Builder(
      builder: (context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Column(
          children: [
            Text(
              "Choose Preferred",
              style: TextStyle(
                fontSize: width*0.05,
                fontWeight: FontWeight.w600,
                color: MyMateThemes.textColor,
                letterSpacing: 0.8,
              ),
            ),
            Text(
              "Astrology chart input method",
              style: TextStyle(
                fontSize: width*0.05,
                fontWeight: FontWeight.w600,
                color: MyMateThemes.primaryColor,
                letterSpacing: 0.8,
              ),
            ),
            SizedBox(height: height * 0.025),
            Text(
              'You can generate astrology chart with ',
              style: TextStyle(color: MyMateThemes.textColor, fontSize: width * 0.036, fontWeight: FontWeight.normal),
            ),
            Text(
              'required birth details ',
              style: TextStyle(color: MyMateThemes.textColor, fontSize: width * 0.036, fontWeight: FontWeight.normal),
            ),
            Text(
              'or you can enter manually',
              style: TextStyle(color: MyMateThemes.textColor, fontSize: width * 0.036, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: height * 0.03),
          ],
        );
      }
    );
  }

  Widget buildOptionContainer(String title, svg, bool isSelected) {
    return Builder(
      builder: (context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Container(
          height: height*0.14,
          width: width * 0.73,
          decoration: BoxDecoration(
            color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //     color: MyMateThemes.secondaryColor,
            //     spreadRadius: 1,
            //     offset: Offset(0, 0),
            //   ),
            // ],
            borderRadius: BorderRadius.circular(width*0.015),
            border: Border.all(
              color: isSelected ? MyMateThemes.primaryColor : MyMateThemes.primaryColor.withOpacity(0.3),
              width: width*0.004,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(svg,height:height*0.047),
              // Icon(
              //   icon,
              //   size: height * 0.05,
              //   color: MyMateThemes.primaryColor,
              // ),
              SizedBox(height: height * 0.015),
              Text(
                title,
                style: TextStyle(
                  fontSize: width * 0.042,
                  fontWeight: FontWeight.w500,
                  color: MyMateThemes.textColor,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
