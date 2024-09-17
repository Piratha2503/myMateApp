import 'package:flutter/material.dart';
import 'package:mymateapp/Matching/RasiAndNadchathiram.dart';
// Ensure this import is correct

class KanaMatcher extends StatefulWidget {
  const KanaMatcher({super.key});

  @override
  _KanaMatcherState createState() => _KanaMatcherState();
}

class _KanaMatcherState extends State<KanaMatcher> {
  String? message;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl star names manually
    String boyStarName = 'Kiruthigai';
    String girlStarName = 'Kiruthigai';
    _checkKanaMatch(boyStarName, girlStarName);
  }

  void _checkKanaMatch(String boyStarName, String girlStarName) {
    setState(() {
      if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
        if ((RasiNadchathiram.Theva.contains(boyStarName) &&
                RasiNadchathiram.Theva.contains(girlStarName)) ||
            (RasiNadchathiram.Manusa.contains(boyStarName) &&
                RasiNadchathiram.Manusa.contains(girlStarName)) ||
            (RasiNadchathiram.Manusa.contains(boyStarName) &&
                RasiNadchathiram.Theva.contains(girlStarName))) {
          message = 'Matched';
        } else if ((RasiNadchathiram.Ratchasa.contains(boyStarName) &&
                RasiNadchathiram.Ratchasa.contains(girlStarName)) ||
            (RasiNadchathiram.Ratchasa.contains(boyStarName) &&
                RasiNadchathiram.Theva.contains(girlStarName)) ||
            (RasiNadchathiram.Ratchasa.contains(girlStarName)) ||
            (RasiNadchathiram.Theva.contains(boyStarName) &&
                RasiNadchathiram.Manusa.contains(girlStarName)) ||
            (RasiNadchathiram.Ratchasa.contains(boyStarName) &&
                RasiNadchathiram.Manusa.contains(girlStarName))) {
          message = 'Not Matched';
        } else {
          message = 'Error in entered name';
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
        title: Text('Kana Matcher'),
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
