import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart'; // Ensure this import is correct

class VirutshaMatcher extends StatefulWidget {
  @override
  _VirutshaMatcherState createState() => _VirutshaMatcherState();
}

class _VirutshaMatcherState extends State<VirutshaMatcher> {
  final List<String> Group1 = [
    'Mirugasheeridam',
    'Chitrai',
    'Aviddam',
    'Thiruvathirai',
    'Swathi',
    'Sathayam',
    'Punarpusham',
    'Vishakham',
    'Bharani',
    'Uththaraddathi',
    'Anusham',
    'Ashwini',
  ];
  final List<String> Group2 = [
    'Rohini',
    'Ashththam',
    'Thiruvonam',
    'Kiruthigai',
    'Uththaram',
    'pooraddaathi',
    'Pusham',
    'pooram',
    'pooradam',
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
    String boyStarName = 'Bharani';
    String girlStarName = 'Rohini';
    _checkVirutshaMatch(boyStarName, girlStarName);
  }

  void _checkVirutshaMatch(String boyStarName, String girlStarName) {
    setState(() {
      if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
        if ((Group1.contains(boyStarName) && Group1.contains(girlStarName)) ||
            (Group1.contains(boyStarName) && Group2.contains(girlStarName)) ||
            (Group2.contains(boyStarName) && Group1.contains(girlStarName))) {
          message = 'Matched';
        } else {
          message = 'Not Matched';
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
        title: Text('Virutsha Matcher'),
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
