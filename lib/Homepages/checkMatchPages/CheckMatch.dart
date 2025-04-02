import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../dbConnection/Firebase.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../ProfilePageScreen/navamsaChartDesign.dart';
import '../ProfilePageScreen/rasiChartDesign.dart';

class CheckmatchPage extends StatefulWidget {
  final String clientDocId;
  final String soulDocId;


  const CheckmatchPage({
    super.key,
    required this.clientDocId,
    required this.soulDocId,
  });

  @override
  State<CheckmatchPage> createState() => _CheckmatchPageState();
}

class _CheckmatchPageState extends State<CheckmatchPage> {
  final Firebase firebase = Firebase();
  String soulfull_name = "";
  String? soulprofilePicUrl;
  String souldob = "";
  String souldot = "";
  String soulcity = "";
  String soulcountry = "";

  String? clientprofilePicUrl;
  String? clientfull_name="";
  String? clientdob="";
  String? clientdot="";
  String? clientcity="";
  String? clientcountry="";

  bool _isExpanded = false;

  int _selectedIndex = 0;
  int? _expandedTileIndex;

  void _handleTileExpansion(int index, bool isExpanded) {
    setState(() {
      _expandedTileIndex = isExpanded ? index : null;
    });
  }



  Map<String, Map<String, dynamic>> categorizedMatchResults = {
    "Essential Matches": {
      "description": "Highly recommended for successful match.",
      "matches": [
        "Viruksha Matching",
        "mahendra Matching",
        "Thina Matching",
        "Kana Matching",

      ],
    },
    "Strong Matches": {
      "description": "1 of 3 is must ,It signifies a good level of compatibility.",
      "matches": [
        "streeThirga Matching",
        "Vethai Matching",
        "Yoni Matching"


      ],
    },
    "Additional Matches": {
      "description": "These matches enhance the overall compatibility.",
      "matches": [
        "Rachu Matching",
        "Rasi Matching",
        "rasiAthipathi Matching",
        "Vashya Matching",
        "Naadi Matching"

      ],
    },
  };

  // Store API results
  Map<String, bool> matchResults = {
    // "Overall Matching" :false,
    "Vethai Matching": false,
    "Viruksha Matching": false,
    "Kana Matching": false,
    "Thina Matching": false,
    "Rasi Matching": false,
    "Vashya Matching": false,
    "Rachu Matching": false,
    "Yoni Matching": false,
    "streeThirga Matching": false,
    "mahendra Matching": false,
    "rasiAthipathi Matching": false,
    "Naadi Matching": false,

  };

  /// Fetch data from API using fetchUserById
  Future<void> getProfileData() async {
    final soulData = await fetchUserById(widget.soulDocId);
    final clientData = await fetchUserById(widget.clientDocId);

    if (soulData.isNotEmpty && clientData.isNotEmpty) {
      setState(() {

        soulfull_name = soulData['full_name'] ?? "N/A";
        soulprofilePicUrl = soulData['profile_pic_url'] ?? '';
        souldob = soulData['dob'] ?? "N/A";
        souldot = soulData['dot'] ?? "N/A";
        soulcity = soulData['city'] ?? "N/A";
        soulcountry = soulData['country'] ?? "N/A";


        clientfull_name = clientData['full_name'] ?? "N/A";
        clientprofilePicUrl = clientData['profile_pic_url'] ?? '';  // Fetching client pic separately
        clientdob = clientData['dob'] ?? "N/A";
        clientdot = clientData['dot'] ?? "N/A";
        clientcity = clientData['city'] ?? "N/A";
        clientcountry = clientData['country'] ?? "N/A";
      });
    }
  }

  Future<void> fetchMatchingResults() async {
    try {
      final data = await showMatchingResults(widget.clientDocId, widget.soulDocId);

      setState(() {
        matchResults = {
          // "Overall Matching": data["Overall Matching"] ?? false,
          "Kana Matching": data["Kana Matching"] ?? false,

          "Vethai Matching": data["Vethai Matching"] ?? false,
          "Viruksha Matching": data["Viruksha Match"] ?? false,
          "Thina Matching": data["Thina Matching"] ?? false,
          "Rasi Matching": data["Rasi Matching"] ?? false,
          "Vashya Matching": data["Vashya Matching"] ?? false,
          "Rachu Matching": data["Rachu Matching"] ?? false,
          "Yoni Matching": data["Yoni Matching"] ?? false,

          "streeThirga Matching": data["Thina Matching"] ?? false,
          "mahendra Matching": data["Thina Matching"] ?? false,
          "rasiAthipathi Matching": data["Thina Matching"] ?? false,
          "Naadi Matching": data["Thina Matching"] ?? false,

        };
      });
    } catch (e) {
      print("Error fetching matching results: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
    fetchMatchingResults();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor:Colors.white,
        body: SafeArea(
        child: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SizedBox(height: screenHeight * 0.02),
    Row(
    children: [
    GestureDetector(
    onTap: () => Navigator.pop(context),
    child: SvgPicture.asset('assets/images/chevron-left.svg',  height: screenHeight * 0.02),
    ),
    ],
    ),
    SizedBox(height: screenHeight * 0.02),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          GestureDetector(
            child: clientprofilePicUrl != null
                ? profilePicture(clientprofilePicUrl!)
                : SvgPicture.asset('assets/images/circle.svg', width: screenWidth * 0.26),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(clientfull_name!,style: TextStyle(color: MyMateThemes.textColor,fontSize: screenWidth*0.035),),

        ],
      ),
      SizedBox(width: screenWidth * 0.15),
      SvgPicture.asset('assets/images/heart .svg', height: screenWidth * 0.06),
      SizedBox(width: screenWidth * 0.15),

      Column(
        children: [
          GestureDetector(
            child: soulprofilePicUrl != null
                ? profilePicture(soulprofilePicUrl!)
                : SvgPicture.asset('assets/images/circle.svg', width: screenWidth * 0.26),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(soulfull_name,style: TextStyle(color: MyMateThemes.textColor,fontSize: screenWidth*0.035)),

        ],
      ),


    ],
    ),

    //SizedBox(height: screenHeight * 0.01),
    Center(child: matchPercentageWidget()),
    Center(
    child: ElevatedButton(
    onPressed: () {},
    style: CommonButtonStyle.commonButtonStyle(),
    child: Text('Send Request', style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal, letterSpacing: 0.5,fontSize: screenWidth*0.036)),
    ),
    ),
    SizedBox(height: screenHeight * 0.07),
              Column(
                children: categorizedMatchResults.entries.map((entry) {
                  String categoryTitle = entry.key;
                  String categoryDescription = entry.value["description"];
                  List<String> matches = entry.value["matches"];

                  return
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Title and Description
                  Center(
                  child: Container(
                  decoration: BoxDecoration(
                  border: Border.all(
                  color: MyMateThemes.textColor.withOpacity(0.2),
                  width: screenWidth*0.003,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: screenWidth*0.9,
                  height: screenHeight*0.075,
                  child: Padding(
                  padding:  EdgeInsets.only(left:screenWidth*0.03),
                  child: Column(
                  children: [
                  SizedBox(height: screenHeight*0.01),
                  Row(
                          children: [
                            Text(
                              categoryTitle,
                              style: TextStyle(
                                fontSize: screenWidth*0.039,
                                fontWeight: FontWeight.w500,
                                color: MyMateThemes.textColor,
                              ),
                            ),
                            ],
                  ),
                            SizedBox(height: screenHeight*0.003),
                            Row(
                  children: [
                  Text(
                  categoryDescription,
                  style: TextStyle(
                  fontSize: screenWidth*0.03,
                    fontWeight: FontWeight.normal,
                  color: MyMateThemes.textColor.withOpacity(0.7),
                  ),
                  ),
                  ],
                  ),
                  ],
                        ),
                      ),

                  ),

                  ),
                      SizedBox(height: screenHeight*0.02),


                      // List of Matches in this Category
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(), // Prevent inner scroll
                        shrinkWrap: true,  // Let ListView take only the required space
                        itemCount: matches.length,
                        itemBuilder: (context, index) {
                          String matchName = matches[index];
                          bool matchStatus = matchResults[matchName] ?? false;

                          return PoruthamColumn({
                            'svg': matchStatus
                                ? 'assets/images/whitetick.svg'
                                : 'assets/images/blackcross.svg',
                            'name': matchName,
                            'status': matchStatus.toString(),
                          });
                        },
                      ),
                      SizedBox(height: screenHeight*0.05),
                    ],
                  );
                }).toList(),
              ),
      SizedBox(height: screenHeight*0.03),
              Row(
                children: [
                  SizedBox(width: screenWidth*0.005),

                  Icon( Icons.info_outline_rounded,color: MyMateThemes.primaryColor,size: screenHeight*0.02,),
                  SizedBox(width: screenWidth*0.015),

                  Text(
                    'Details',
                    style: TextStyle(
                      color: MyMateThemes.primaryColor,
                      fontSize: screenWidth*0.03,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
      SizedBox(height: screenHeight*0.01),
              Row(
                children: [
                  SvgPicture.asset('assets/images/Line 11.svg',width: screenWidth*0.9,),
                ],
              ),
            SizedBox(height: screenHeight*0.025),

              Padding(
        padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0), // Padding
        child: Container(

          decoration: BoxDecoration(
            border: Border.all(
              color: MyMateThemes.textColor.withOpacity(0.2),
              width: screenWidth*0.003,
            ),
            borderRadius: BorderRadius.circular(screenWidth*0.03),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

            child: ExpansionTile(

              title: Text(
                clientfull_name!,
                style:TextStyle(color: MyMateThemes.textColor,fontSize: screenWidth*0.04),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0), // Padding
                  child: _buildExpansionTileClient(),  // This widget will be inside the inner container

                ),
              ],
            ),
          ),
        ),
      ),
              SizedBox(height: screenHeight*0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0), // Padding
                child: Container(

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyMateThemes.textColor.withOpacity(0.2),
                      width: screenWidth*0.003,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth*0.03),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

                    child: ExpansionTile(
                      title: Text(
                        soulfull_name,
                        style:TextStyle(color: MyMateThemes.textColor,fontSize: screenWidth*0.04),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0), // Padding
                            child: _buildExpansionTileSoul(),  // This widget will be inside the inner container

                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Center(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight*0.05),
                    RasiChartDesign(context),
                    SizedBox(height: screenHeight*0.05),
                    NavamsaChartDesign(context),
                  ],
                ),
              ),
      SizedBox(height: screenHeight*0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: screenWidth*0.42,
                    height: screenHeight*0.073,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: CommonButtonStyle.commonButtonStyle(),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/upload.svg',width: screenWidth*0.04,),
                          SizedBox(width:screenWidth*0.02),
                          Text(
                            'Export',
                            style: TextStyle(color: Colors.white, letterSpacing: 1,fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),

                    ),
                  ),
                  SizedBox(width: screenWidth*0.01),

                ],
              ),

      SizedBox(height: screenHeight*0.05),

            ],
          ),
        ),
      ),
        ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        docId: widget.clientDocId,
      ),
    );
  }

  Widget profilePicture(String imageUrl) {
    double screenWidth = MediaQuery.of(context).size.width;
    double profileSize = screenWidth * 0.25; // Adjust size dynamically
    double borderWidth = screenWidth * 0.005;

    return Container(
      width: profileSize,
      height: profileSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(
          color: MyMateThemes.premiumAccent,
          width: borderWidth,
        ),
      ),
      child: CircleAvatar(
        radius: profileSize / 2,
        backgroundImage: NetworkImage(imageUrl),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget matchPercentageWidget() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double frameWidth = screenWidth * 0.7;
    double frameHeight = frameWidth * 0.9;
    double textFontSize = screenWidth * 0.11;
    double subTextFontSize = screenWidth * 0.05;

    return Stack(
      children: [
        SvgPicture.asset('assets/images/Frame.svg', width: frameWidth, height: frameHeight),
        Positioned(
          top: frameHeight * 0.35,
          right: frameWidth * 0.4,
          child: Text(
            '80%',
            style: TextStyle(color: Colors.white, letterSpacing:0.8,fontSize: textFontSize, fontWeight: FontWeight.w500),
          ),
        ),
        Positioned(
          top: frameHeight * 0.55,
          right: frameWidth * 0.44,
          child: Text(
            'Match',
            style: TextStyle(color: Colors.white, fontSize: subTextFontSize, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }


  Widget _buildExpansionTileClient() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0,vertical: 6
      ),
      child:
      Column(
        children: [
          Container(

            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.065,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              border: Border.all(
                color: MyMateThemes.textColor.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(clientdob!),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.065,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            decoration: BoxDecoration(
              border: Border.all(
                color: MyMateThemes.textColor.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text('$clientcity, $clientcountry'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.065,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            decoration: BoxDecoration(
              border: Border.all(
                color: MyMateThemes.textColor.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(clientdot!),
          ),
        ],
      ),
    );
  }
  Widget _buildExpansionTileSoul() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0,vertical: 6
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.065,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            decoration: BoxDecoration(
              border: Border.all(
                color: MyMateThemes.textColor.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(souldob),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.065,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            decoration: BoxDecoration(
              border: Border.all(
                color: MyMateThemes.textColor.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text('$soulcity, $soulcountry'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.065,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            decoration: BoxDecoration(
              border: Border.all(
                color: MyMateThemes.textColor.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(souldot),
          ),
        ],
      ),
    );
  }

  Widget PoruthamColumn(Map<String, String> item) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        double containerWidth = screenWidth * 0.95;
        double containerHeight = screenHeight * 0.038;
        double fontSize = screenWidth * 0.028;
        double statusFontSize = screenWidth * 0.026;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0,vertical: screenHeight*0.01), // Padding
          child: Column(
            children: [
              Container(
                width: containerWidth,
                height: containerHeight,
              //  margin: EdgeInsets.all(screenWidth * 0.02),
                padding: EdgeInsets.symmetric(horizontal: screenWidth*0.02,vertical: screenHeight*0.007), // Padding
                decoration: BoxDecoration(
                  color: item['status'] == "true"
                      ? MyMateThemes.primaryColor
                      : MyMateThemes.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: Text(
                        item['name']!,
                        style: TextStyle(
                            color: item['status'] == "true"
                            ? Colors.white
                            : MyMateThemes.textColor, fontSize: fontSize),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: screenWidth * 0.07,
                      child: Text(
                        item['status']!,
                        style: TextStyle(  color: item['status'] == "true"
                            ? Colors.white
                            : MyMateThemes.textColor, fontSize: statusFontSize),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: screenWidth * 0.02,
                      child: SvgPicture.asset(
                        item['svg']!,
                        width: screenWidth * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
