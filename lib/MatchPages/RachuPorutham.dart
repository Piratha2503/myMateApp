import 'package:flutter/material.dart';
import 'package:mymateapp/Matching/RasiAndNadchathiram.dart';
// Ensure this import is correct

class RachuMatcher extends StatefulWidget {
  const RachuMatcher({super.key});

  @override
  _RachuMatcherState createState() => _RachuMatcherState();
}

class _RachuMatcherState extends State<RachuMatcher> {
  bool isMatched = false;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl star names manually
    String boyStarName = 'Rohini';
    String girlStarName = 'Rohini';
    isMatched = _checkRachuMatch(boyStarName, girlStarName);
  }

  bool _checkRachuMatch(String boyStarName, String girlStarName) {
    if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
      if ((RasiNadchathiram.Group1.contains(boyStarName) &&
              RasiNadchathiram.Group1.contains(girlStarName)) ||
          (RasiNadchathiram.Group2.contains(boyStarName) &&
              RasiNadchathiram.Group2.contains(girlStarName)) ||
          (RasiNadchathiram.Group3.contains(boyStarName) &&
              RasiNadchathiram.Group3.contains(girlStarName)) ||
          (RasiNadchathiram.Group4.contains(boyStarName) &&
              RasiNadchathiram.Group4.contains(girlStarName)) ||
          (RasiNadchathiram.Group5.contains(boyStarName) &&
              RasiNadchathiram.Group5.contains(girlStarName))) {
        return false;
      }
      return true;
    }
    return false;
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
              isMatched ? 'Matched: true' : 'Matched: false',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
