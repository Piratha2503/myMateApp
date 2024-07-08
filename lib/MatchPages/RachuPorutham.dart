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
