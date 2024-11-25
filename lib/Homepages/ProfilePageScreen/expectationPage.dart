import 'package:flutter/material.dart';
import '../../MyMateThemes.dart';

Widget ExpectationRow(String title) {
  return Container(
    height: 37,
    width: 297,
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: MyMateThemes.containerColor,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: MyMateThemes.textColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    ),
  );
}

Widget Expectations() {
  return Column(
    children: [
      ExpectationRow('Expectation 1'),
      ExpectationRow('Expectation 2'),
      ExpectationRow('Expectation 3'),
      ExpectationRow('Expectation 4'),
      ExpectationRow('Expectation 5'),
      SizedBox(height: 20),
    ],
  );
}
