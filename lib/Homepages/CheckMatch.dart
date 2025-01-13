import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../MyMateCommonBodies/MyMateApis.dart';
import '../dbConnection/Firebase.dart';
import '../MyMateCommonBodies/MyMateBottomBar.dart';
import 'package:mymateapp/MyMateThemes.dart';

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
  String full_name = "";


  int _selectedIndex = 0;

  // Store API results
  Map<String, bool> matchResults = {
    // "Overall Matching" :false,
    "Vethai Matching": false,
    "Viruksha Match": false,
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
  Future<void> getSoulName() async {

    final data = await fetchUserById(widget.soulDocId);

    if (data.isNotEmpty) {
      setState(() {
        full_name = data['full_name'] ?? "N/A";
      });
    }
  }

  Future<void> fetchMatchingResults() async {
    try {
      final data = await showMatchingResults(widget.clientDocId, widget.soulDocId);

      setState(() {
        matchResults = {
          // "Overall Matching": data["Overall Matching"] ?? false,

          "Vethai Matching": data["Vethai Matching"] ?? false,
          "Viruksha Match": data["Viruksha Match"] ?? false,
          "Kana Matching": data["Kana Matching"] ?? false,
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
    getSoulName();
    fetchMatchingResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset('assets/images/chevron-left.svg'),
                ),
                SizedBox(width: 100),
                Text(
                  full_name,
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                SvgPicture.asset('assets/images/Frame.svg',
                    width: 240, height: 160),
                Positioned(
                    top: 45,
                    right: 56,
                    child: Text(
                      '60%',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500),
                    )),
                Positioned(
                    top: 90,
                    right: 68,
                    child: Text(
                      'Match',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: (matchResults.keys.length + 1) ~/
                    2, // Calculate the number of rows needed
                itemBuilder: (context, index) {
                  int firstIndex = index * 2;
                  int secondIndex = firstIndex + 1;
                  List<String> keys = matchResults.keys.toList();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PoruthamColumn(
                        {
                          'svg': matchResults[keys[firstIndex]]!
                              ? 'assets/images/whitetick.svg'
                              : 'assets/images/blackcross.svg',
                          'name': keys[firstIndex],
                          'status': matchResults[keys[firstIndex]]!.toString(),
                        },
                      ),
                      SizedBox(width: 10),
                      if (secondIndex < matchResults.keys.length)
                        PoruthamColumn(
                          {
                            'svg': matchResults[keys[secondIndex]]!
                                ? 'assets/images/whitetick.svg'
                                : 'assets/images/blackcross.svg',
                            'name': keys[secondIndex],
                            'status': matchResults[keys[secondIndex]]!.toString(),
                          },
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget PoruthamColumn(Map<String, String> item) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 60,
          margin: EdgeInsets.all(8),
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
                top: 15,
                child: Text(
                  item['name']!,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Positioned(
                top: 0,
                left: 20,
                child: Text(
                  item['status']!,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Positioned(
                top: 0,
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
