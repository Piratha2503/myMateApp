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

  final List<String> allNames = [];
  TextEditingController boyController = TextEditingController();
  TextEditingController girlController = TextEditingController();
  String? message;

  @override
  void initState() {
    super.initState();
    allNames.addAll(Rasi);
  }

  @override
  void dispose() {
    boyController.dispose();
    girlController.dispose();
    super.dispose();
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
            TextField(
              controller: boyController,
              decoration: InputDecoration(
                labelText: 'Boy:',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: girlController,
              decoration: InputDecoration(
                labelText: 'Girl:',
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String boyRasiName = boyController.text.trim();
                  String girlRasiName = girlController.text.trim();

                  if (boyRasiName.isNotEmpty && girlRasiName.isNotEmpty) {
                    if (girlRasiName == 'Aries' &&
                            (boyRasiName == 'Leo' ||
                                boyRasiName == 'Scorpio') ||
                        girlRasiName == 'Taurus' &&
                            (boyRasiName == 'Cancer' ||
                                boyRasiName == 'Libra') ||
                        girlRasiName == 'Gemini' && (boyRasiName == 'Virgo') ||
                        girlRasiName == 'Cancer' &&
                            (boyRasiName == 'Scorpio' ||
                                boyRasiName == 'Sagittarius') ||
                        girlRasiName == 'Leo' && (boyRasiName == 'Capricorn') ||
                        girlRasiName == 'Virgo' &&
                            (boyRasiName == 'Taurus' ||
                                boyRasiName == 'Pisces') ||
                        girlRasiName == 'Libra' &&
                            (boyRasiName == 'Capricorn') ||
                        girlRasiName == 'Scorpio' &&
                            (boyRasiName == 'Cancer' ||
                                boyRasiName == 'Virgo') ||
                        girlRasiName == 'Sagittarius' &&
                            (boyRasiName == 'Pisces') ||
                        girlRasiName == 'Capricorn' &&
                            (boyRasiName == 'Aquarius') ||
                        girlRasiName == 'Aquarius' &&
                            (boyRasiName == 'Pisces') ||
                        girlRasiName == 'Pisces' &&
                            (boyRasiName == 'Capricorn')) {
                      message = 'Matched';
                    } else {
                      message = 'Not Matched';
                    }
                  } else {
                    message = 'Please enter both Rasi names';
                  }
                });
              },
              child: Text('Check Match'),
            ),
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
