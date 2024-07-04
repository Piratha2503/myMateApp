import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart'; // Ensure this import is correct

class RachuMatcher extends StatefulWidget {
  @override
  _RachuMatcherState createState() => _RachuMatcherState();
}

class _RachuMatcherState extends State<RachuMatcher> {
  final List<String> Group1 = [
    'Mirugasheeridam',
    'Chitrai',
    'Aviddam',
  ];
  final List<String> Group2 = [
    'Rohini',
    'Thiruvathirai',
    'Ashththam',
    'Swathi',
    'Thiruvonam',
    'Sathayam',
  ];
  final List<String> Group3 = [
    'Kiruthigai',
    'Punarpusham',
    'Uththaram',
    'Vishakham',
    'pooraddaathi'
  ];

  final List<String> Group4 = [
    'Bharani',
    'Pusham',
    'pooram',
    'Anusham',
    'pooradam',
    'Uththaraddathi'
  ];

  final List<String> Group5 = [
    'Ashwini',
    'Aayilyam',
    'Magham',
    'Keddai',
    'Moolam',
    'Revathi'
  ];

  String? message;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl star names manually
    String boyStarName = 'Ashwini';
    String girlStarName = 'pooram';
    _checkRachuMatch(boyStarName, girlStarName);
  }

  void _checkRachuMatch(String boyStarName, String girlStarName) {
    setState(() {
      if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
        if ((Group1.contains(boyStarName) && Group1.contains(girlStarName)) ||
            (Group2.contains(boyStarName) && Group2.contains(girlStarName)) ||
            (Group3.contains(boyStarName) && Group3.contains(girlStarName)) ||
            (Group4.contains(boyStarName) && Group4.contains(girlStarName)) ||
            (Group5.contains(boyStarName) && Group5.contains(girlStarName))) {
          message = 'Not Matched';
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
        title: Text('Rachu Matcher'),
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
