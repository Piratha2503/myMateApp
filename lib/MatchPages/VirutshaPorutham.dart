import 'package:flutter/material.dart';

import '../Matching/RasiAndNadchathiram.dart'; // Ensure this import is correct

class VirutshaMatcher extends StatefulWidget {
  const VirutshaMatcher({super.key});

  @override
  _VirutshaMatcherState createState() => _VirutshaMatcherState();
}

class _VirutshaMatcherState extends State<VirutshaMatcher> {
  String? message;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl star names manually
    String boyStarName = 'Bharani';
    String girlStarName = 'Rohini';
    _checkVirutshaMatch(boyStarName, girlStarName);
  }

  void _checkVirutshaMatch(String boyStarName, String girlStarName) {
    setState(() {
      if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
        if ((RasiNadchathiram.Milk.contains(boyStarName) &&
                RasiNadchathiram.Milk.contains(girlStarName)) ||
            (RasiNadchathiram.Milk.contains(boyStarName) &&
                RasiNadchathiram.NonMilk.contains(girlStarName)) ||
            (RasiNadchathiram.NonMilk.contains(boyStarName) &&
                RasiNadchathiram.Milk.contains(girlStarName))) {
          message = 'Matched';
        } else {
          message = 'Not Matched';
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
        title: Text('Virutsha Matcher'),
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
