import 'package:flutter/material.dart';
import 'package:mymateapp/Matching/RasiAndNadchathiram.dart';
import 'package:mymateapp/MyMateThemes.dart'; // Ensure this import is correct

class RachuMatcher extends StatefulWidget {
  @override
  _RachuMatcherState createState() => _RachuMatcherState();
}

class _RachuMatcherState extends State<RachuMatcher> {
  String? message;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl star names manually
    String boyStarName = 'Rohini';
    String girlStarName = 'Rohini';
    _checkRachuMatch(boyStarName, girlStarName);
  }

  void _checkRachuMatch(String boyStarName, String girlStarName) {
    setState(() {
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
          message = 'Not Matched';
        } else {
          message = 'Matched';
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
        title: Text('Rachu Matcher'),
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
