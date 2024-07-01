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
        title: Text('Virutsha Matcher'),
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

                  if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
                    if ((Group1.contains(boyStarName) &&
                            Group1.contains(girlStarName)) ||
                        (Group1.contains(boyStarName) &&
                            Group2.contains(girlStarName)) ||
                        (Group2.contains(boyStarName) &&
                            Group1.contains(girlStarName))) {
                      message = ' Matched';
                    } else {
                      message = 'Not Matched';
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
