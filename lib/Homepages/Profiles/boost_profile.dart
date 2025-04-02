import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../ProfilePageScreen/MyProfileMain.dart';

class boostprofile extends StatefulWidget {
  final String docId;

  const boostprofile({required this.docId});

  @override
  State<boostprofile> createState() => _boostprofileState();
}

class _boostprofileState extends State<boostprofile> {
  int _boostDays = 1;
  int _superBoostDays = 1;
  int _noOfTokens = 1;
  int _selectedTabIndex = 0;
  bool isLoading = true;

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * 0.01),
        child: SafeArea(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        selectedBottomBarIconIndex: 3,
                        docId: widget.docId,
                      ),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  'assets/images/chevron-left.svg',
                  height: MediaQuery.of(context).size.height * 0.015, // Adjust icon size
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.29), // Responsive spacing


                  Text(
                    "Boost Profile",
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.width * 0.05, // Responsive font size
                    ),
                  ),

            ],
          ),
        ),
      ),
    );
  }
  void _handleComplete() {
    if (_selectedTabIndex == 0) {
      _updateProfileType("Boosted");
    } else {
      _updateProfileType("Super Boosted");
    }
  }


  Future<void> _updateProfileType(String profileType) async {
    setState(() {
      isLoading = true;
    });

    final apiUrl = "https://backend.graycorp.io:9000/mymate/api/v1/updateClient";




    final payload = {
      "docId": widget.docId,
      "profile_type": profileType,
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile updated successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update profile: ${response.reasonPhrase}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }


  void _updateTokens() {
    setState(() {
      if (_selectedTabIndex == 0) {
        _noOfTokens = _boostDays;
      } else {
        _noOfTokens = _superBoostDays * 2;
      }
    });
  }

  void _handleDayIncrement() {
    setState(() {
      if (_selectedTabIndex == 0) {
        _boostDays++;
      } else {
        _superBoostDays++;
      }
      _updateTokens();
    });
  }

  void _handleDayDecrement() {
    setState(() {
      if (_selectedTabIndex == 0 && _boostDays > 1) {
        _boostDays--;
      } else if (_selectedTabIndex == 1 && _superBoostDays > 1) {
        _superBoostDays--;
      }
      _updateTokens();
    });
  }

  void _handleTabChange(int index) {
    setState(() {
      _selectedTabIndex = index;
      _updateTokens();
    });
  }

  void _handleClear() {
    setState(() {
      if (_selectedTabIndex == 0) {
        _boostDays = 1;
      } else {
        _superBoostDays = 1;
      }
      _updateTokens();
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * 0.02),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Adjust alignment
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            'assets/images/fire.svg',
                            height: screenWidth * 0.035, // Responsive icon size
                            width: screenWidth * 0.035,

                          ),
                          SizedBox(width: screenWidth * 0.001), // Responsive spacing
                          Text(
                            "78",
                            style: TextStyle(
                              color: MyMateThemes.textColor,
                              fontSize: screenWidth * 0.06, // Responsive font size
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // TextButton(
                      //   onPressed: () {  },
                      //   child: Text(
                      //     "+ Add Token",
                      //     style: TextStyle(
                      //       color: MyMateThemes.primaryColor,
                      //       fontSize: screenWidth * 0.04, // Responsive font size
                      //       fontWeight: FontWeight.normal,
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: (){},
                        child: Text(
                          "+ Add Tokens",
                          style: TextStyle(
                            color: MyMateThemes.primaryColor,
                            fontSize: screenWidth * 0.03, // Responsive font size
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.02), // Responsive spacing

              ],
            ),

            SizedBox(height:screenHeight * 0.025),
            buildBoostContainer(
              context,
              title: 'Boost',
              description:
              'Your profile will be boosted. It helps you that your profile will be prioritized suggestions to others every searches. It takes 1 token per day.',
              tokensPerDay: '× 1 / Day',
              backgroundColor: MyMateThemes.containerColor,
              textColor: MyMateThemes.textColor,
              titlecolor: MyMateThemes.textColor,
            ),
            SizedBox(height: screenHeight * 0.02), // Responsive spacing
            buildBoostContainer(
              context,
              title: 'Super Boost',
              description:
              'Your profile will be boosted. It helps you that your profile will be highly prioritized suggestions to others every searches. It takes 2 tokens per day.',
              tokensPerDay: '× 2 / Day',
              backgroundColor: MyMateThemes.primaryColor,
              textColor: Colors.white,
              titlecolor: MyMateThemes.premiumAccent,
            ),
            SizedBox(height: screenHeight * 0.05), // Responsive spacing
            _buildBoostCount(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBoostCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return
      DefaultTabController(
        length: 2,
        child: Column(
          children: [
              Container(
                height: screenHeight*0.05,
                width: screenWidth * 0.65,
                decoration: BoxDecoration(
                  color: MyMateThemes.containerColor, // light gray background like image
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                child:
                TabBar(
                  indicator: BoxDecoration(
                    color: MyMateThemes.primaryColor,
                    borderRadius: BorderRadius.circular(screenWidth * 0.03), // Responsive border radius
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,

                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: MyMateThemes.textColor,
                  labelStyle: TextStyle(
                    fontSize: screenWidth * 0.04, // Responsive font size
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: screenWidth * 0.04, // Responsive font size
                    fontWeight: FontWeight.normal,
                      letterSpacing: 0.5

                  ),
                  tabs: [
                    _buildTabButton(context,'Boost'),
                    _buildTabButton(context,'Super Boost'),
                  ],
                  onTap: _handleTabChange,
                ),
              ),

            SizedBox(height: screenHeight * 0.02), // Responsive spacing
            SizedBox(
              height: screenHeight * 0.16,
              child: _selectedTabIndex == 0
                  ? _buildBoostContent(
                noOfDays: _boostDays,
                noOfTokens: _noOfTokens,
              )
                  : _buildBoostContent(
                noOfDays: _superBoostDays,
                noOfTokens: _noOfTokens,
              ),
            ),
          SizedBox(height: screenHeight * 0.03), // Responsive spacing

            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01, horizontal: screenWidth * 0.03), // Responsive padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.435,
                    child: ElevatedButton(
                      onPressed: _handleClear,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: MyMateThemes.containerColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.02), // Responsive border radius
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.13), // Responsive button padding
                      ),
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          color: MyMateThemes.textColor,
                            fontSize: screenWidth * 0.045,fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03), // Responsive spacing
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.435,
                    child: ElevatedButton(
                      onPressed: _handleComplete,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: MyMateThemes.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.02), // Responsive border radius
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.1), // Responsive button padding
                      ),
                      child: Text(
                        'Complete',
                          style: TextStyle(color:Colors.white,fontSize: screenWidth * 0.045,fontWeight: FontWeight.normal), // Responsive font size

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildBoostContent({
    required int noOfDays,
    required int noOfTokens,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCounterRow(
            label: "No of Days",
            value: noOfDays,
            onIncrement: _handleDayIncrement,
            onDecrement: _handleDayDecrement,
            showLightningBolt: false,
            showControls: true, context: context,
          ),
           SizedBox(height:MediaQuery.of(context).size.height * 0.01),

          _buildCounterRow(
            label: "No of Tokens",
            value: noOfTokens,
            showLightningBolt: true,
            showControls: false,
            context: context,
          ),
        ],
      ),
    );
  }
}

Tab _buildTabButton(BuildContext context,String title) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return
    Tab(
    child: Container(
      width: screenWidth * 0.42, // Responsive width
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01, // Responsive vertical padding
        horizontal: screenWidth * 0.01, // Responsive horizontal padding
      ),
      child: Text(
      title,
      style: TextStyle(
        fontSize: screenWidth * 0.035, // Responsive font size
        fontWeight: FontWeight.normal,
      ),
    ),
    ),
  );
}


Widget buildBoostContainer(
    BuildContext context, {
      required String title,
      required Color titlecolor,
      required String description,
      required String tokensPerDay,
      required Color backgroundColor,
      required Color textColor,
    }) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    height: screenHeight*0.17,
    width: screenWidth*0.9,
    padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(screenWidth * 0.06), // Responsive border radius
    ),
    child: Stack(
      children: [
        Positioned(
            top: 0,
            left: 20,
            child:SvgPicture.asset(
              'assets/images/lightning-bolt.svg',
              height: screenWidth * 0.1, // Responsive icon size
              width: screenWidth * 0.1,
              color: title == 'Super Boost'
                  ? MyMateThemes.premiumAccent
                  : textColor,
            ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Adjust alignment
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.1), // Responsive spacing

                          SizedBox(width: screenWidth * 0.5), // Responsive spacing

                          SvgPicture.asset(
                            'assets/images/firenew.svg',
                            height: screenWidth * 0.04, // Responsive icon size
                            width: screenWidth * 0.04,
                            color: textColor,
                          ),
                          SizedBox(width: screenWidth * 0.01), // Responsive spacing
                          Text(
                            tokensPerDay,
                            style: TextStyle(
                              color: textColor.withOpacity(0.8),
                              fontSize: screenWidth *  0.0315, // Responsive font size
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.004), // Responsive spacing
                      Text(
                        title,
                        style: TextStyle(
                          color: titlecolor,
                          fontSize: screenWidth * 0.04, // Responsive font size
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.02), // Responsive spacing

              ],
            ),
            SizedBox(height: screenHeight * 0.01), // Responsive spacing
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.01),
              child: Text(
                description,
                style: TextStyle(
                    color: title == 'Super Boost'
                        ? Colors.white
                        : MyMateThemes.textColor,
                    fontSize: screenWidth * 0.031, // Responsive font size
                  fontWeight: FontWeight.w300,
                  letterSpacing:0.5
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


Widget _buildCounterRow({
  required String label,
  required int value,
  required bool showLightningBolt,
  required bool showControls,
  Function()? onIncrement,
  Function()? onDecrement,
  required BuildContext context,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.004,horizontal: screenWidth*0.005),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: screenWidth*0.05,),
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.033,
            color: MyMateThemes.textColor,
          ),
        ),
        SizedBox(width: screenWidth * 0.22),
        if (showControls)
          _circleButton(
            icon: Icons.remove,
            onTap: onDecrement ?? () {},
            color: MyMateThemes.textColor,
            backgroundcolor: MyMateThemes.containerColor,
            context: context,
          ),

        SizedBox(width: screenWidth * 0.01),
        if (showLightningBolt)
          SizedBox(width: screenWidth * 0.031),

        Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          height: screenHeight * 0.045,
          width: screenWidth*0.2,
          decoration: BoxDecoration(
            border: Border.all(color: MyMateThemes.textColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (showLightningBolt)

                  Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.02),
                  child: SvgPicture.asset(
                    'assets/images/firenew.svg',
                    height: screenWidth * 0.035,
                    color: MyMateThemes.primaryColor,
                  ),
                ),

              SizedBox(width: screenWidth * 0.05),
              Text(
                value.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  color: MyMateThemes.textColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.01),

        if (showControls)
          _circleButton(
            icon: Icons.add,
            onTap: onIncrement ?? () {},
            backgroundcolor: MyMateThemes.primaryColor,
            color:Colors.white,
            context: context,
          ),
      ],
    ),
  );
}

Widget _circleButton({
  required IconData icon,
  required VoidCallback onTap,
  required Color color,
  required Color backgroundcolor,
  required BuildContext context,
}) {
  double screenWidth = MediaQuery.of(context).size.width;

  return Material(
    color:backgroundcolor,
    shape: const CircleBorder(),
    elevation: 1,
    child: InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Icon(icon, size: screenWidth * 0.03, color: color),
      ),
    ),
  );
}


