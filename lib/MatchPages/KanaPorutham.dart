import 'package:flutter/material.dart';
import 'package:mymateapp/Matching/RasiAndNadchathiram.dart';
import 'package:mymateapp/MyMateThemes.dart'; // Ensure this import is correct

class KanaMatcher extends StatefulWidget {
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
