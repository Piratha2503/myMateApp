import 'package:flutter/material.dart';

class VethaiMatcher extends StatefulWidget {
  @override
  _VethaiMatcherState createState() => _VethaiMatcherState();
}

class _VethaiMatcherState extends State<VethaiMatcher> {
  final List<List<String>> vethaiMismatchList = [
    ["Ashwini", "Keddai"],
    ["Bharani", "Anusham"],
    ["Kiruthigai", "Vishakham"],
    ["Rohini", "Swathi"],
    ["Thiruvathirai", "Thiruvonam"],
    ["Punarpusham", "Uththaradam"],
    ["Pusham", "pooradam"],
    ["Aayilyam", "Moolam"],
    ["Magham", "Revathi"],
    ["pooram", "Uththaraddathi"],
    ["Uththaram", "pooraddaathi"],
    ["Ashththam", "Sathayam"],
    ["Mirugasheeridam", "Chitrai", "Aviddam"]
  ];

  String? message;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl star names manually
    String boyStarName = 'Ashwini';
    String girlStarName = 'Keddai';
    _checkVethaiMatch(boyStarName, girlStarName);
  }

  void _checkVethaiMatch(String boyStarName, String girlStarName) {
    setState(() {
      if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
        if (vethaiMismatchList.any((pair) =>
            pair.contains(boyStarName) && pair.contains(girlStarName))) {
          message = 'Not matched';
        } else {
          message = 'Matched';
        }
      } else {
        message = 'Please enter both Star names';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vethai Matcher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              message ?? '',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
