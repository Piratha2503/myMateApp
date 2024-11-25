import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/rasiChartDesign.dart';
import '../../MyMateThemes.dart';
import 'MyProfileBodyWidgets.dart';
import 'MyProfileWidgets.dart';
import 'expectationPage.dart';
import 'MyProfileMain.dart';
import 'navamsaChartDesign.dart';

class AboutMe extends StatelessWidget {
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
            InfoRow('Education', 'Bsc Computer Science'),
            InfoRow('Height', '165 CM'),
            InfoRow('Religion', 'Hinduism'),
            InfoRow('Language', 'Tamil, English'),
            InfoRow('Caste', 'Optional'),
            InfoRow('Father\'s Name', 'Bsc Computer Science'),
            InfoRow('Mother\'s Name', 'Bsc Computer Science'),
            InfoRow('Siblings', '6'),
            SizedBox(height: 20),

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
            SizedBox(height: 10),

            // Expectations Widget
            Expectations(),
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
