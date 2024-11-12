import 'package:flutter/material.dart';
import 'package:mymateapp/Matching/RasiAndNadchathiram.dart';
// Ensure this import is correct

class KanaMatcher extends StatefulWidget {
  const KanaMatcher({super.key});

  @override
  _KanaMatcherState createState() => _KanaMatcherState();
}

class _KanaMatcherState extends State<KanaMatcher> {
  bool isMatched = false;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl star names manually
    String boyStarName = 'Kiruthigai';
    String girlStarName = 'Kiruthigai';
    isMatched = _checkKanaMatch(boyStarName, girlStarName);
  }

  bool _checkKanaMatch(String boyStarName, String girlStarName) {
    if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
      if ((RasiNadchathiram.Theva.contains(boyStarName) &&
              RasiNadchathiram.Theva.contains(girlStarName)) ||
          (RasiNadchathiram.Manusa.contains(boyStarName) &&
              RasiNadchathiram.Manusa.contains(girlStarName)) ||
          (RasiNadchathiram.Manusa.contains(boyStarName) &&
              RasiNadchathiram.Theva.contains(girlStarName))) {
        return true;
      }
      return false;
    }
    // Return false if either boyStarName or girlStarName is empty
    return false;
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
              isMatched ? 'Matched: true' : 'Matched: false',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
