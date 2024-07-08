import 'package:flutter/material.dart';
import 'package:mymateapp/Matching/RasiAndNadchathiram.dart';

class VethaiMatcher extends StatefulWidget {
  @override
  _VethaiMatcherState createState() => _VethaiMatcherState();
}

class _VethaiMatcherState extends State<VethaiMatcher> {
  String? message;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl star names manually
    String boyStarName = 'Ashwini';
    String girlStarName = 'Bharani';
    _checkVethaiMatch(boyStarName, girlStarName);
  }

  void _checkVethaiMatch(String boyStarName, String girlStarName) {
    setState(() {
      if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
        if (RasiNadchathiram.vethaiMismatchList.any((pair) =>
            pair.contains(boyStarName) && pair.contains(girlStarName))) {
          message = 'Not matched';
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
        title: Text('Vethai Matcher'),
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
