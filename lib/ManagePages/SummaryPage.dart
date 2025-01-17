import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'ManagePage.dart';

class Summarypage extends StatefulWidget {
  final docId;
  const Summarypage({super.key,required this.docId});

  @override
  State<Summarypage> createState() => _SummarypageState();
}

class _SummarypageState extends State<Summarypage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Row(
                children: [
                  SizedBox(width: screenWidth * 0.02),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ManagePage(docId: widget.docId,)),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/images/chevron-left.svg',
                      width: screenWidth * 0.06,
                      height: screenHeight * 0.03,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Summary",
                    style: TextStyle(
                      color: MyMateThemes.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.06,
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.1),
                Text(
                  'Hi, Name',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: MyMateThemes.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.1),
                Text(
                  'Here is your summary',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: MyMateThemes.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSummaryCard(
                  context,
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.2,
                  color: MyMateThemes.primaryColor,
                  textColor: Colors.white,
                  title: '187',
                  subtitle1: 'Interests',
                  subtitle2: 'received',
                ),
                SizedBox(width: screenWidth * 0.05),
                _buildSummaryCard(
                  context,
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.2,
                  color: MyMateThemes.secondaryColor,
                  textColor: MyMateThemes.primaryColor,
                  title: '1K',
                  subtitle1: 'Interests',
                  subtitle2: 'sent',
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            // _buildSummaryCard(
            //   context,
            //   width: screenWidth * 0.9,
            //   height: screenHeight * 0.2,
            //   color: MyMateThemes.secondaryColor,
            //   textColor: MyMateThemes.primaryColor,
            //   title: '217',
            //   subtitle1: 'Interested',
            //   subtitle2: '',
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 340,
                  height: 177,
                  decoration: BoxDecoration(
                    color: MyMateThemes.secondaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 7,
                          right: 15,
                          child: Text(
                            '217',
                            style: TextStyle(
                                fontSize: 48,
                                color: MyMateThemes.primaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                        bottom: 15,
                        left: 20,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Interested',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: MyMateThemes.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSummaryCard(
                  context,
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.2,
                  color: MyMateThemes.secondaryColor,
                  textColor: MyMateThemes.primaryColor,
                  title: '1K',
                  subtitle1: 'Matches',
                  subtitle2: 'sent',
                ),
                SizedBox(width: screenWidth * 0.05),
                _buildSummaryCard(
                  context,
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.2,
                  color: MyMateThemes.primaryColor,
                  textColor: Colors.white,
                  title: '187',
                  subtitle1: 'Matches',
                  subtitle2: 'received',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context,
      {required double width,
        required double height,
        required Color color,
        required Color textColor,
        required String title,
        required String subtitle1,
        required String subtitle2}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          Positioned(
            top: height * 0.1,
            left: width * 0.5,
            child: Text(
              title,
              style: TextStyle(
                fontSize: width * 0.25,
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.15,
            left: width * 0.07,
            child: Text(
              subtitle1,
              style: TextStyle(
                fontSize: width * 0.13,
                color: textColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8
              ),
            ),
          ),
          if (subtitle2.isNotEmpty)
            Positioned(
              bottom: height * 0.07,
              left: width * 0.08,
              child: Text(
                subtitle2,
                style: TextStyle(
                  fontSize: width * 0.09,
                  color: textColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
