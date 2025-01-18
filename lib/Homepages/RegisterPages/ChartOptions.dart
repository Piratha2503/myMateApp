import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/ChartPages/GenerateChart.dart';
import 'package:mymateapp/ChartPages/ManualRasiChartPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:mymateapp/dbConnection/Clients.dart';

class ChartOptions extends StatefulWidget{
  ClientData clientData;
  ChartOptions({super.key, required this.clientData});

  @override
  State<ChartOptions> createState() => _ChartOptionsState();
}

class _ChartOptionsState extends State<ChartOptions> {
  // Add a variable to track the selected option
  int? _selectedOptionIndex;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              ChartOptionsTexts(),
              SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOptionIndex = 1; // Select the first option
                  });
                  print(widget.clientData.personalDetails?.first_name);
                  print(widget.clientData.personalDetails?.last_name);
                  print(widget.clientData.personalDetails?.gender);
                  print(widget.clientData.contactInfo?.mobile);
                  // Navigate or perform desired action
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateChart()));
                },
                child: buildOptionContainer(
                  "Generate the chart",
                  Icons.table_chart,
                  _selectedOptionIndex == 1, // Highlight when selected
                ),
              ),
              SizedBox(height: 30),
              SvgPicture.asset('assets/images/or.svg'),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOptionIndex = 2; // Select the second option
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ManualRasiChartPage(clientData: widget.clientData),
                    ),
                  );
                },
                child: buildOptionContainer(
                  "Enter chart manually",
                  Icons.ads_click,
                  _selectedOptionIndex == 2, // Highlight when selected
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget ChartOptionsTexts(){
    return  Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text( "Choose Preferred",
          style: TextStyle( fontSize: MyMateThemes.subHeadFontSize,fontWeight: FontWeight.w700 ,color: MyMateThemes.textColor,letterSpacing: 0.8),
        ),
       // SizedBox(height:5),
        Text( "Astrology chart input method",
          style: TextStyle( fontSize: MyMateThemes.subHeadFontSize,fontWeight: FontWeight.w700 ,color: MyMateThemes.primaryColor,letterSpacing: 0.8),

        ),
        SizedBox(height: 20),
        Text('You can generate astrology chart with ',style: TextStyle(color: MyMateThemes.textColor,fontSize: 14,fontWeight: FontWeight.normal,letterSpacing: 0.5),),
        Text('required birth details ',style: TextStyle(color: MyMateThemes.textColor,fontSize: 14,fontWeight: FontWeight.normal,letterSpacing: 0.5),),
        Text('or you can enter manually',style: TextStyle(color: MyMateThemes.textColor,fontSize: 14,fontWeight: FontWeight.normal,letterSpacing: 0.5),),

        SizedBox(height: 30),
      ],
    );
  }


  // Method to build the option container with dynamic styling
  Widget buildOptionContainer(String title, IconData icon, bool isSelected) {
    return Container(
      height: 125,
      width: 300,
      decoration: BoxDecoration(
        color: MyMateThemes.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: MyMateThemes.secondaryColor,
            spreadRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? MyMateThemes.primaryColor : MyMateThemes.backgroundColor, // Change color when selected
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: MyMateThemes.primaryColor,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: MyMateThemes.textGray,
            ),
          ),
        ],
      ),
    );
  }
}
