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

  final List<String> allNames = [];
  TextEditingController boyController = TextEditingController();
  TextEditingController girlController = TextEditingController();
  String? message;

  @override
  void initState() {
    super.initState();
    allNames.addAll(Group1);
    allNames.addAll(Group2);

    // Add listeners to the text controllers
    boyController.addListener(_checkVirutshaMatch);
    girlController.addListener(_checkVirutshaMatch);
  }

  @override
  void dispose() {
    boyController.removeListener(_checkVirutshaMatch);
    girlController.removeListener(_checkVirutshaMatch);
    boyController.dispose();
    girlController.dispose();
    super.dispose();
  }

  void _checkVirutshaMatch() {
    setState(() {
      String boyStarName = boyController.text.trim();
      String girlStarName = girlController.text.trim();

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

  void setBoyAndGirlStars(String boyStar, String girlStar) {
    boyController.text = boyStar;
    girlController.text = girlStar;
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
            ElevatedButton(
              onPressed: () {
                setBoyAndGirlStars("Bharani", "Rohini");
              },
              child: Text('Check'),
            ),
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
