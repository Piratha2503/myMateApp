import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart'; // Ensure this import is correct

class KanaMatcher extends StatefulWidget {
  @override
  _KanaMatcherState createState() => _KanaMatcherState();
}

class _KanaMatcherState extends State<KanaMatcher> {
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

    // Add listeners to the text controllers
    boyController.addListener(_checkKanaMatch);
    girlController.addListener(_checkKanaMatch);
  }

  @override
  void dispose() {
    boyController.removeListener(_checkKanaMatch);
    girlController.removeListener(_checkKanaMatch);
    boyController.dispose();
    girlController.dispose();
    super.dispose();
  }

  void _checkKanaMatch() {
    setState(() {
      String boyStarName = boyController.text.trim();
      String girlStarName = girlController.text.trim();

      if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
        if ((Theva.contains(boyStarName) && Theva.contains(girlStarName)) ||
            (Manusa.contains(boyStarName) && Manusa.contains(girlStarName)) ||
            (Manusa.contains(boyStarName) && Theva.contains(girlStarName))) {
          message = 'Matched';
        } else if ((Ratchasa.contains(boyStarName) &&
                Ratchasa.contains(girlStarName)) ||
            (Ratchasa.contains(boyStarName) && Theva.contains(girlStarName)) ||
            (Ratchasa.contains(girlStarName)) ||
            (Theva.contains(boyStarName) && Manusa.contains(girlStarName)) ||
            (Ratchasa.contains(boyStarName) && Manusa.contains(girlStarName))) {
          message = 'Not Matched';
        } else {
          message = 'Error in entered name';
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
        title: Text('Kana Matcher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Example: setting the star names
                setBoyAndGirlStars("Aswini", "Chitra");
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
