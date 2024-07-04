import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart'; // Ensure this import is correct

class VasiyaMatcher extends StatefulWidget {
  @override
  _VasiyaMatcherState createState() => _VasiyaMatcherState();
}

class _VasiyaMatcherState extends State<VasiyaMatcher> {
  final List<String> Rasi = [
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Virgo',
    'Libra',
    'Scorpio',
    'Sagittarius',
    'Capricorn',
    'Aquarius',
    'Pisces'
  ];

  String? message;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl Rasi names manually
    String boyRasiName = 'Aries';
    String girlRasiName = 'Leo';
    _checkMatch(boyRasiName, girlRasiName);
  }

  void _checkMatch(String boyRasiName, String girlRasiName) {
    setState(() {
      if (boyRasiName.isNotEmpty && girlRasiName.isNotEmpty) {
        if (girlRasiName == 'Aries' &&
                (boyRasiName == 'Leo' || boyRasiName == 'Scorpio') ||
            girlRasiName == 'Taurus' &&
                (boyRasiName == 'Cancer' || boyRasiName == 'Libra') ||
            girlRasiName == 'Gemini' && (boyRasiName == 'Virgo') ||
            girlRasiName == 'Cancer' &&
                (boyRasiName == 'Scorpio' || boyRasiName == 'Sagittarius') ||
            girlRasiName == 'Leo' && (boyRasiName == 'Capricorn') ||
            girlRasiName == 'Virgo' &&
                (boyRasiName == 'Taurus' || boyRasiName == 'Pisces') ||
            girlRasiName == 'Libra' && (boyRasiName == 'Capricorn') ||
            girlRasiName == 'Scorpio' &&
                (boyRasiName == 'Cancer' || boyRasiName == 'Virgo') ||
            girlRasiName == 'Sagittarius' && (boyRasiName == 'Pisces') ||
            girlRasiName == 'Capricorn' && (boyRasiName == 'Aquarius') ||
            girlRasiName == 'Aquarius' && (boyRasiName == 'Pisces') ||
            girlRasiName == 'Pisces' && (boyRasiName == 'Capricorn')) {
          message = 'Matched';
        } else {
          message = 'Not Matched';
        }
      } else {
        message = 'Please enter both Rasi names';
      }
    });
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
