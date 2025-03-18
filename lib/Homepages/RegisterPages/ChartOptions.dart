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
      backgroundColor: MyMateThemes.backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            return Center(
              child: Column(
                children: [
                  SizedBox(height: height * 0.1),
                  ChartOptionsTexts(width, height),
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
                                  return PlaceDateTimeInput(clientData: clientData,docId:clientData.docId!,);
                                }
                              )));
                    },
                    child: buildOptionContainer(
                      "Generate the chart",
                      Icons.table_chart,
                      _selectedOptionIndex == 1,
                      width * 0.8,
                      height * 0.2,
                    ),
                  ),
                  SizedBox(height: height * 0.035),
                  SvgPicture.asset('assets/images/or.svg', width: width * 0.8),
                  SizedBox(height: height * 0.035),
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
                      Icons.ads_click,
                      _selectedOptionIndex == 2,
                      width * 0.8,
                      height * 0.2,
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

  Widget ChartOptionsTexts(double width, double height) {
    return Column(
      children: [
        Text(
          "Choose Preferred",
          style: TextStyle(
            fontSize: width*0.055,
            fontWeight: FontWeight.w700,
            color: MyMateThemes.textColor,
            letterSpacing: 0.8,
          ),
        ),
        Text(
          "Astrology chart input method",
          style: TextStyle(
            fontSize: width*0.05,
            fontWeight: FontWeight.w700,
            color: MyMateThemes.primaryColor,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: height * 0.02),
        Text(
          'You can generate astrology chart with ',
          style: TextStyle(color: MyMateThemes.textColor, fontSize: width * 0.04, fontWeight: FontWeight.normal, letterSpacing: 0.5),
        ),
        Text(
          'required birth details ',
          style: TextStyle(color: MyMateThemes.textColor, fontSize: width * 0.04, fontWeight: FontWeight.normal, letterSpacing: 0.5),
        ),
        Text(
          'or you can enter manually',
          style: TextStyle(color: MyMateThemes.textColor, fontSize: width * 0.04, fontWeight: FontWeight.normal, letterSpacing: 0.5),
        ),
        SizedBox(height: height * 0.03),
      ],
    );
  }

  Widget buildOptionContainer(String title, IconData icon, bool isSelected, double width, double height) {
    return Container(
      height: height*1,
      width: width,
      decoration: BoxDecoration(
        color: MyMateThemes.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: MyMateThemes.secondaryColor,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? MyMateThemes.primaryColor : MyMateThemes.backgroundColor,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: height * 0.4,
            color: MyMateThemes.primaryColor,
          ),
          SizedBox(height: height * 0.1),
          Text(
            title,
            style: TextStyle(
              fontSize: width * 0.06,
              fontWeight: FontWeight.w600,
              color: MyMateThemes.textGray,
            ),
          ),
        ],
      ),
    );
  }
}
