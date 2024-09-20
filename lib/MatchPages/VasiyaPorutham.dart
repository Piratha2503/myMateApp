import 'package:flutter/material.dart';
// Ensure this import is correct

class VasiyaMatcher extends StatefulWidget {
  const VasiyaMatcher({super.key});

  @override
  _VasiyaMatcherState createState() => _VasiyaMatcherState();
}

class _VasiyaMatcherState extends State<VasiyaMatcher> {
  bool isMatched = false;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl Rasi names manually
    String boyRasiName = 'Simmam';
    String girlRasiName = 'Mesham';
    isMatched = _checkVasyaMatch(boyRasiName, girlRasiName);
  }

  bool _checkVasyaMatch(String boyRasiName, String girlRasiName) {
    if (boyRasiName.isNotEmpty && girlRasiName.isNotEmpty) {
      if (girlRasiName == 'Mesham' &&
              (boyRasiName == 'Simmam' || boyRasiName == 'Viruchigam') ||
          girlRasiName == 'Rishabam' &&
              (boyRasiName == 'Kadagam' || boyRasiName == 'Thulam') ||
          girlRasiName == 'Mithunam' && (boyRasiName == 'Kanni') ||
          girlRasiName == 'Kadagam' &&
              (boyRasiName == 'Viruchigam' || boyRasiName == 'Thanusu') ||
          girlRasiName == 'Simmam' && (boyRasiName == 'Magaram') ||
          girlRasiName == 'Kanni' &&
              (boyRasiName == 'Rishabam' || boyRasiName == 'Meenam') ||
          girlRasiName == 'Thulam' && (boyRasiName == 'Magaram') ||
          girlRasiName == 'Viruchigam' &&
              (boyRasiName == 'Kadagam' || boyRasiName == 'Kanni') ||
          girlRasiName == 'Thanusu' && (boyRasiName == 'Meenam') ||
          girlRasiName == 'Magaram' && (boyRasiName == 'Kumbam') ||
          girlRasiName == 'Kumbam' && (boyRasiName == 'Meenam') ||
          girlRasiName == 'Meenam' && (boyRasiName == 'Magaram')) {
        return true;
      }
      return false;
    }
    return false;
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
              isMatched ? 'Matched: true' : 'Matched: false',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
