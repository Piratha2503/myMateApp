import 'dart:convert';
import 'package:flutter/widgets.dart';
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
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * 0.03),
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
                  height: MediaQuery.of(context).size.height * 0.025, // Adjust icon size
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01), // Responsive spacing
              Expanded(
                child: Center(
                  child: Text(
                    "Boost Profile",
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05, // Responsive font size
                    ),
                  ),
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
        padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * 0.06),
        child: Column(
          children: [
            SizedBox(height:MediaQuery.of(context).size.height * 0.03),
            buildBoostContainer(
              context,
              title: 'Boost',
              description:
              'Your profile will be boosted. It helps you that your profile will be prioritized suggestions to others every searches. It takes 1 token per day.',
              tokensPerDay: '× 1 Token per day',
              backgroundColor: MyMateThemes.containerColor,
              textColor: MyMateThemes.textGray,
              titlecolor: MyMateThemes.textGray,
            ),
            SizedBox(height: screenHeight * 0.02), // Responsive spacing
            buildBoostContainer(
              context,
              title: 'Super Boost',
              description:
              'Your profile will be boosted. It helps you that your profile will be highly prioritized suggestions to others every searches. It takes 2 tokens per day.',
              tokensPerDay: '× 2 Tokens per Day',
              backgroundColor: MyMateThemes.primaryColor,
              textColor: Colors.white,
              titlecolor: MyMateThemes.premiumAccent,
            ),
            SizedBox(height: screenHeight * 0.03), // Responsive spacing
            _buildBoostCount(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBoostCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), // Responsive padding
            child: Container(
              decoration: BoxDecoration(
                color: MyMateThemes.containerColor,
                borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: MyMateThemes.primaryColor,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
                ),
                labelColor: Colors.white,
                unselectedLabelColor: MyMateThemes.primaryColor,
                labelStyle: TextStyle(
                  fontSize: screenWidth * 0.04, // Responsive font size
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  _buildTabButton(context,'Boost'),
                  _buildTabButton(context,'Super Boost'),
                ],
                onTap: _handleTabChange,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // Responsive spacing
          SizedBox(
            height: screenHeight * 0.2, // Adjust TabBarView height dynamically
            child: TabBarView(
              children: [
                _buildBoostContent(
                  noOfDays: _boostDays,
                  noOfTokens: _noOfTokens,
                ),
                _buildBoostContent(
                  noOfDays: _superBoostDays,
                  noOfTokens: _noOfTokens,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.01, horizontal: screenWidth * 0.03), // Responsive padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _handleClear,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyMateThemes.containerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03), // Responsive border radius
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02, horizontal: screenWidth * 0.13), // Responsive button padding
                  ),
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      color: MyMateThemes.primaryColor,
                      fontSize: screenWidth * 0.04, // Responsive font size
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.05), // Responsive spacing
                ElevatedButton(
                  onPressed: _handleComplete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyMateThemes.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03), // Responsive border radius
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02, horizontal: screenWidth * 0.1), // Responsive button padding
                  ),
                  child: Text(
                    'Complete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04, // Responsive font size
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
            showControls: true,
             context: context,
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

  return Tab(
    child: Container(
      width: screenWidth * 0.4, // Responsive width
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.015, // Responsive vertical padding
        horizontal: screenWidth * 0.03, // Responsive horizontal padding
      ),          child: Text(
      title,
      style: TextStyle(
        fontSize: screenWidth * 0.04, // Responsive font size
        fontWeight: FontWeight.w500,
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
    padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(screenWidth * 0.07), // Responsive border radius
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                          fontSize: screenWidth * 0.035, // Responsive font size
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.005), // Responsive spacing
                  Text(
                    title,
                    style: TextStyle(
                      color: titlecolor,
                      fontSize: screenWidth * 0.045, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.02), // Responsive spacing
            SvgPicture.asset(
              'assets/images/lightning-bolt.svg',
              height: screenWidth * 0.06, // Responsive icon size
              width: screenWidth * 0.06,
              color: title == 'Super Boost'
                  ? MyMateThemes.premiumAccent
                  : textColor,
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.015), // Responsive spacing
        Text(
          description,
          style: TextStyle(
            color: textColor.withOpacity(0.7),
            fontSize: screenWidth * 0.035, // Responsive font size
          ),
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

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        label,
        style:  TextStyle(
            fontSize: screenWidth * 0.04,
        ),
      ),
      Row(
        children: [
          if (showControls)
            Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: onDecrement,
                color: Colors.grey,
                splashRadius: screenWidth * 0.05,
              ),
            ),
          // Conditionally apply the padding for "No of Tokens" only
          if (label == "No of Tokens")
            Padding(
              padding: const EdgeInsets.only(right: 55.0), // Adjust padding as needed
              child: Container(
                width: screenWidth * 0.20,
                height: screenHeight * 0.04,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth*0.02),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showLightningBolt)
                      SvgPicture.asset(
                        'assets/images/firenew.svg',
                        height: screenHeight*0.02,
                        width: screenWidth*0.04,
                        color: MyMateThemes.primaryColor,
                      ),
                    if (showLightningBolt)  SizedBox(width:screenWidth*0.01 ),
                    Text(
                      value.toString().padLeft(2, '0'),
                      style:  TextStyle(
                          fontSize:screenWidth * 0.04,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              width: screenWidth*0.20,
              height: screenHeight*0.04,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showLightningBolt)
                    SvgPicture.asset(
                      'assets/images/firenew.svg',
                      height: screenHeight*0.04,
                      width: screenWidth*0.04,
                      color: MyMateThemes.primaryColor,
                    ),
                  if (showLightningBolt)  SizedBox(width:screenWidth * 0.01 ),
                  Text(
                    value.toString().padLeft(2, '0'),
                    style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          if (showControls)
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: onIncrement,
                color: MyMateThemes.primaryColor,
                splashRadius: screenWidth*0.05,
              ),
            ),
        ],
      ),
    ],
  );
}
