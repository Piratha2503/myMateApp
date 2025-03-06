import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/rasiChartDesign.dart';
import 'package:mymateapp/MyMateCommonBodies/MyMateApis.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import '../../MyMateThemes.dart';
import 'MyProfileBodyWidgets.dart';
import 'MyProfileWidgets.dart';
import 'expectationPage.dart';
import 'MyProfileMain.dart';
import 'navamsaChartDesign.dart';

class AboutMe extends StatefulWidget {
  final String education;
  final PersonalDetails personalDetails;
  final docId;

  const AboutMe({super.key, required this.education,required this.personalDetails,required this.docId});

  @override
  State<AboutMe> createState() => _AboutMeState();
}



class _AboutMeState extends State<AboutMe>{
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height; // Screen height from MediaQuery

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),

            // Section Title
            SectionTitle( context,'About me'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.007),

            // Decorative Line
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                SvgPicture.asset(
                  'assets/images/Line 11.svg',
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.012),

            // Info Rows
            InfoRow(context, 'Education', widget.education),
            InfoRow(context, 'Height', widget.personalDetails.height.toString()),
            InfoRow(context, 'Religion', widget.personalDetails.religion.toString()),
            InfoRow(context, 'Language', widget.personalDetails.language.toString()),
            InfoRow(context, 'Caste', widget.personalDetails.caste.toString()),
            InfoRow(context, 'Father\'s Name', widget.personalDetails.first_name.toString()),
            InfoRow(context, 'Mother\'s Name', widget.personalDetails.mother_name.toString()),
            InfoRow(context, 'Siblings', widget.personalDetails.num_of_siblings.toString()),
            SizedBox(height: MediaQuery.of(context).size.height * 0.045),

            // Expectations Section
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Text(
                  'Expectations',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // Expectations Widget
            ExpectationsWidget(docId: widget.docId),
          ],
        ),
      ),
    );
  }

}





class AstrologySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
   final key ;// Assign key to the section

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.02),
          SectionTitle( context,'Astrology' ),
          SizedBox(height: screenHeight * 0.007),

          // Decorative Line
          Row(
            children: [
              SizedBox(width: screenWidth * 0.1),
              SvgPicture.asset('assets/images/Line 11.svg', width: screenWidth * 0.8),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

          // Row of Astrology Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First Info Card
              Container(
                height: screenHeight * 0.25,
                width: screenWidth * 0.4,
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.007),
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: MyMateThemes.containerColor,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: screenHeight * 0.01,
                      left: screenWidth * 0.03,
                      child: SvgPicture.asset('assets/images/Group.svg', width: screenWidth * 0.2),
                    ),
                    Positioned(
                      bottom: screenHeight * 0.01,
                      left: screenWidth * 0.01,
                      child: Column(
                        children: [
                          Text(
                            '19 OCT 1998',
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '10.30 AM',
                            style: TextStyle(
                              fontSize: screenWidth * 0.025,
                              color: MyMateThemes.textColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Jaffna, Sri Lanka',
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.04),

              // Second Info Card
              Container(
                height: screenHeight * 0.25,
                width: screenWidth * 0.4,
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.007),
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: MyMateThemes.primaryColor,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                child:
                Stack(
                  children: [
                    Positioned(
                      top: screenHeight * 0.01,
                      left: screenWidth * 0.02,
                      child: SvgPicture.asset('assets/images/Group 2217.svg', width: screenWidth * 0.15,height: screenHeight*0.16,),
                    ),
                    Positioned(
                      bottom: screenHeight * 0.005,
                      left: screenWidth * 0.15,
                      child: Column(
                        children: [
                          Text(
                            'Hastam',
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Virgo (kanni)',
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.05),

          // Center Content: Rasi and Navamsa Charts
          Center(
            child: Column(
              children: [
                RasiChartDesign(context),
                SizedBox(height: screenHeight * 0.06),
                NavamsaChartDesign(context),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ],
      ),
    );
  }}

