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

  final List<String> allNames = [];
  TextEditingController boyController = TextEditingController();
  TextEditingController girlController = TextEditingController();
  String? message;

  @override
  void initState() {
    super.initState();
    allNames.addAll(vethaiMismatchList.expand((x) => x).toList());

    // Add listeners to the text controllers
    boyController.addListener(_checkMatch);
    girlController.addListener(_checkMatch);
  }

  @override
  void dispose() {
    boyController.removeListener(_checkMatch);
    girlController.removeListener(_checkMatch);
    boyController.dispose();
    girlController.dispose();
    super.dispose();
  }

  void _checkMatch() {
    setState(() {
      String boyStarName = boyController.text.trim();
      String girlStarName = girlController.text.trim();

      // Implement your matching logic here and set the message
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

  void setBoyAndGirlStars(String boyStar, String girlStar) {
    boyController.text = boyStar;
    girlController.text = girlStar;
    _checkMatch();
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
            ElevatedButton(
              onPressed: () {
                // Example: setting the star names
                setBoyAndGirlStars("Ashwini", "Keddai");
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
