import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart'; // Ensure this import is correct

class VasiyaMatcher extends StatefulWidget {
  @override
  _VasiyaMatcherState createState() => _VasiyaMatcherState();
}

class _VasiyaMatcherState extends State<VasiyaMatcher> {
  String? message;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl Rasi names manually
    String boyRasiName = 'Simmam';
    String girlRasiName = 'Mesham';
   // _checkMatch(boyRasiName, girlRasiName);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vasiya Matcher'),
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
