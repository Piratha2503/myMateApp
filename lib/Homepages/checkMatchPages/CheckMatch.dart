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
        "Thina Matching"
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
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(  // Wrap the entire content in SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset('assets/images/chevron-left.svg'),
                  ),
                  SizedBox(width: 100),
                  // Add your title text if needed here
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: soulprofilePicUrl != null
                        ? profilePicture(soulprofilePicUrl!)
                        : SvgPicture.asset('assets/images/circle.svg'),
                  ),
                  SizedBox(width: 25),
                  SvgPicture.asset(
                      'assets/images/heart .svg',
                      height: 30, width: 30),
                  SizedBox(width: 25),
                  GestureDetector(
                    child: clientprofilePicUrl != null
                        ? profilePicture(clientprofilePicUrl!)
                        : SvgPicture.asset('assets/images/circle.svg'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child:  matchPercentageWidget(),

              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: CommonButtonStyle.commonButtonStyle(),
                  child: Text(
                    'Send Request',
                    style: TextStyle(color: Colors.white, letterSpacing: 1.5),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Column(
                children: categorizedMatchResults.entries.map((entry) {
                  String categoryTitle = entry.key;
                  String categoryDescription = entry.value["description"];
                  List<String> matches = entry.value["matches"];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Title and Description
                  Center(
                  child: Container(
                  decoration: BoxDecoration(
                  border: Border.all(
                  color: MyMateThemes.textColor.withOpacity(0.2),
                  width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: 330,
                  height: 58,
                  child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                  children: [
                  SizedBox(height: 8),
                  Row(
                          children: [
                            Text(
                              categoryTitle,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: MyMateThemes.textColor,
                              ),
                            ),
                            ],
                  ),
                            SizedBox(height: 4),
                            Row(
                  children: [
                  Text(
                  categoryDescription,
                  style: TextStyle(
                  fontSize: 12,
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
                      SizedBox(height: 10),


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
                      SizedBox(height: 30),

                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 45),
                  Text(
                    'Details',
                    style: TextStyle(
                      color: MyMateThemes.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 30),
                  SvgPicture.asset('assets/images/Line 11.svg'),
                ],
              ),
              SizedBox(height: 30),
            Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20.0),
              child:
                  Container(

                    // decoration: BoxDecoration(
                    //   color: MyMateThemes.containerColor,
                    //
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyMateThemes.textColor.withOpacity(0.2),
                        width: 1,
                      ),            borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ExpansionTile(

                    title: Text(clientfull_name!),
                    children: <Widget>[
                      _buildExpansionTileClient(
                      ),
                    ],
                  ),
                  ),
            ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyMateThemes.textColor.withOpacity(0.2),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      soulfull_name,
                      style: TextStyle(
                        fontSize: 16.0,  // Set a fixed font size to maintain consistency
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),  // Add padding inside the expanded section
                        child: Container(
                          decoration: BoxDecoration(
                            //color: Colors.grey.withOpacity(0.1),  // Add a light background for distinction
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: _buildExpansionTileSoul(),  // This widget will be inside the inner container
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    RasiChartDesign(),
                    SizedBox(height: 40),
                    NavamsaChartDesign(),
                  ],
                ),
              ),
             SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: CommonButtonStyle.commonButtonStyle(),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/upload.svg'),
                        SizedBox(width:5),
                        Text(
                          'Export',
                          style: TextStyle(color: Colors.white, letterSpacing: 1.5),
                        ),
                      ],
                    ),

                  ),
                  SizedBox(width: 25),

                ],
              ),

              SizedBox(height: 40),

            ],
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
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: MyMateThemes.textColor.withOpacity(0.4),
            spreadRadius: 4,
            blurRadius: 4,
          )
        ],
        border: Border.all(
          color: MyMateThemes.secondaryColor,
          width: 4.0,
        ),
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(imageUrl),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget matchPercentageWidget() {
    return Stack(
      children: [
        SvgPicture.asset('assets/images/Frame.svg', width: 240, height: 160),
        Positioned(
          top: 45,
          right: 56,
          child: Text(
            '60%',
            style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w500),
          ),
        ),
        Positioned(
          top: 90,
          right: 68,
          child: Text(
            'Match',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }


  Widget _buildExpansionTileClient() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20.0),

      child:
      Column(
        children: [
          Container(

            width: 320,
            height: 50,
            padding: EdgeInsets.all(15),

            decoration: BoxDecoration(
              border: Border.all(
                color: MyMateThemes.textColor.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              clientdob!,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 320,
            height: 50,
            padding: EdgeInsets.all(15),

            decoration: BoxDecoration(
              border: Border.all(
                color: MyMateThemes.textColor.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              '$clientcity' " , "'$clientcountry',
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 320,
            height: 50,
            padding: EdgeInsets.all(15),

            decoration: BoxDecoration(
              border: Border.all(
                color: MyMateThemes.textColor.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              clientdot!,
            ),
          ),

        ],
      ),


    );
  }
  Widget _buildExpansionTileSoul() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20.0),
        child:
      Column(
          children: [
            Container(
              width: 320,
              height: 50,
              padding: EdgeInsets.all(15),

              decoration: BoxDecoration(
                border: Border.all(
                  color: MyMateThemes.textColor.withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                   souldob,
                ),
              ),
            SizedBox(height: 10),
            Container(
              width: 320,
              height: 50,
              padding: EdgeInsets.all(15),

              decoration: BoxDecoration(
                border: Border.all(
                  color: MyMateThemes.textColor.withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '$soulcity' " , "'$soulcountry',
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 320,
              height: 50,
              padding: EdgeInsets.all(15),

              decoration: BoxDecoration(
                border: Border.all(
                  color: MyMateThemes.textColor.withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                souldot,
              ),
            ),

          ],
        ),


    );

  }


  Widget PoruthamColumn(Map<String, String> item) {
    return Column(
      children: [
        Container(
          width: 330,
          height:40,
          margin: EdgeInsets.all(6),
          padding: EdgeInsets.all(10),
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
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Positioned(
                top: 2,
                right: 20,
                child: Text(
                  item['status']!,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Positioned(
                top: 2,
                right: 1,
                child: SvgPicture.asset(
                  item['svg']!,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
