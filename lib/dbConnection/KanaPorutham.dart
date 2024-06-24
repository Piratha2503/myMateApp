import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart'; // Ensure this import is correct

class TextMatcher extends StatefulWidget {
  @override
  _TextMatcherState createState() => _TextMatcherState();
}

class _TextMatcherState extends State<TextMatcher> {
  final List<String> Theva = [
    'Aswini',
    'Mrigashrisha',
    'Punarvasu',
    'Pushyami',
    'Hastha',
    'Swaathi',
    'Anuraadha',
    'Shraavan',
    'Revathi'
  ];
  final List<String> Manusa = [
    'Bharani',
    'Rohini',
    'Arudra',
    'Poorva Phalguni',
    'Uthra Phalguni',
    'Poorva ashaada',
    'Uthra ashaada',
    'Poorva bhadrapada',
    'Uthra bhadrapada'
  ];
  final List<String> Ratchasa = [
    'Krithika',
    'Ashlesha',
    'Magha',
    'Chitra',
    'Vishaakha',
    'Jyeshta',
    'Moola',
    'Dhanista',
    'Shathabhisha'
  ];

  final List<String> allNames = [];
  TextEditingController boyController = TextEditingController();
  TextEditingController girlController = TextEditingController();
  String? message;

  @override
  void initState() {
    super.initState();
    allNames.addAll(Theva);
    allNames.addAll(Manusa);
    allNames.addAll(Ratchasa);
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
        title: Text('Text Matcher'),
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
                    if ((Theva.contains(boyStarName) &&
                            Theva.contains(girlStarName)) ||
                        (Manusa.contains(boyStarName) &&
                            Manusa.contains(girlStarName)) ||
                        (Manusa.contains(boyStarName) &&
                            Theva.contains(girlStarName))) {
                      message = 'Matched';
                    } else if ((Ratchasa.contains(boyStarName) &&
                            Ratchasa.contains(girlStarName)) ||
                        (Ratchasa.contains(boyStarName) &&
                            Theva.contains(girlStarName)) ||
                        (Ratchasa.contains(girlStarName)) ||
                        (Theva.contains(boyStarName) &&
                            Manusa.contains(girlStarName))) {
                      message = 'Not Matched';
                    } else if (Ratchasa.contains(boyStarName) &&
                        Manusa.contains(girlStarName)) {
                      message = 'Match according to other matches';
                    } else {
                      message = 'Error in entered name';
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

void main() {
  runApp(MaterialApp(
    home: TextMatcher(),
  ));
}
