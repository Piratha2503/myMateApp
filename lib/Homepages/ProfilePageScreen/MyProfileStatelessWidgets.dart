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
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            // Section Title
            SectionTitle('About me'),
            SizedBox(height: 5),

            // Decorative Line
            Row(
              children: [
                SizedBox(width: 40),
                SvgPicture.asset('assets/images/Line 11.svg'),
              ],
            ),
            SizedBox(height: 10),

            // Info Rows
            InfoRow('Education', widget.education),
            InfoRow('Height', widget.personalDetails.height.toString()),
            InfoRow('Religion', widget.personalDetails.religion.toString()),
            InfoRow('Language', widget.personalDetails.language.toString()),
            InfoRow('Caste', widget.personalDetails.caste.toString()),
            InfoRow('Father\'s Name', widget.personalDetails.first_name.toString()),
            InfoRow('Mother\'s Name', widget.personalDetails.mother_name.toString()),
            InfoRow('Siblings', widget.personalDetails.num_of_siblings.toString()),
            SizedBox(height: 35),

            // Expectations Section
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 40),
                Text(
                  'Expectations',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            // Expectations Widget
            ExpectationsWidget(docId:widget.docId),
          ],
        ),
      ),
    );
  }

}





class AstrologySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height; // Screen height from MediaQuery

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          SectionTitle("Astrology"),
          SizedBox(height: 5),

          // Decorative Line
          Row(
            children: [
              SizedBox(width: 42),
              SvgPicture.asset('assets/images/Line 11.svg'),
            ],
          ),
          SizedBox(height: 16),

          // Row of Astrology Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First Info Card
              Container(
                height: screenHeight * 0.2, // Adjust height relative to screen height
                width: 140,
                margin: EdgeInsets.symmetric(vertical: 5.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: MyMateThemes.containerColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: SvgPicture.asset('assets/images/Group.svg'),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 5,
                      child: Column(
                        children: [
                          Text(
                            '19 OCT 1998',
                            style: TextStyle(
                              fontSize: 12,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '10.30 AM',
                            style: TextStyle(
                              fontSize: 10,
                              color: MyMateThemes.textColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Jaffna, Sri Lanka',
                            style: TextStyle(
                              fontSize: 12,
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
              SizedBox(width: 15),

              // Second Info Card
              Container(
                height: screenHeight * 0.2, // Adjust height relative to screen height
                width: 140,
                margin: EdgeInsets.symmetric(vertical: 5.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: MyMateThemes.primaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      left: 6.5,
                      child: SvgPicture.asset('assets/images/Group 2217.svg'),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 48,
                      child: Column(
                        children: [
                          Text(
                            'Hastam',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Virgo (kanni)',
                            style: TextStyle(
                              fontSize: 12,
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

          SizedBox(height: 40),

          // Center Content: Rasi and Navamsa Charts
          Center(
            child: Column(
              children: [
                RasiChartDesign(),
                SizedBox(height: 48),
                NavamsaChartDesign(),
                SizedBox(height: 13),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

