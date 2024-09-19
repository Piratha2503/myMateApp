import 'package:flutter/material.dart';
import 'package:mymateapp/Matching/RasiAndNadchathiram.dart';

class VethaiMatcher extends StatefulWidget {
  const VethaiMatcher({super.key});

  @override
  _VethaiMatcherState createState() => _VethaiMatcherState();
}

class _VethaiMatcherState extends State<VethaiMatcher> {
  bool isMatched = false;

  @override
  void initState() {
    super.initState();
    // Set the boy and girl star names manually
    String boyStarName = 'Ashwini';
    String girlStarName = 'Bharani';
    isMatched = _checkVethaiMatch(boyStarName, girlStarName);
  }

  bool _checkVethaiMatch(String boyStarName, String girlStarName) {
    if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
      if (RasiNadchathiram.vethaiMismatchList.any((pair) =>
          pair.contains(boyStarName) && pair.contains(girlStarName))) {
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
        title: Text('Vethai Matcher'),
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
