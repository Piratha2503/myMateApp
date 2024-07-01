import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';

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
  }

  @override
  void dispose() {
    boyController.dispose();
    girlController.dispose();
    super.dispose();
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
            TextField(
              controller: boyController,
              decoration: InputDecoration(
                labelText: 'Boy:',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: girlController,
              decoration: InputDecoration(
                labelText: 'Girl:',
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String boyStarName = boyController.text.trim();
                  String girlStarName = girlController.text.trim();

                  // Implement your matching logic here and set the message
                  if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
                    if (vethaiMismatchList.any((pair) =>
                        pair.contains(boyStarName) &&
                        pair.contains(girlStarName))) {
                      message = 'Not matched';
                    } else {
                      message = 'Matched';
                    }
                  } else {
                    message = 'Please enter both Star names';
                  }
                });
              },
              child: Text('Check Match'),
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
