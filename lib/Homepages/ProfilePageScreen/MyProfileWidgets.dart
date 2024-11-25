import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../MyMateThemes.dart';
import '../BadgeWidget.dart';

Widget Tag(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: MyMateThemes.primaryColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
      ),
    ),
  );
}

Widget InfoRow(String title, String value) {
  return Container(
    height: 38,
    width: 297,
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: MyMateThemes.containerColor,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: MyMateThemes.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: MyMateThemes.textColor,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget IconWithText(String iconPath, String text1, String text2) {
  return Container(
    width: 120,
    height: 73,
    foregroundDecoration: BoxDecoration(
      border: Border(
        right: BorderSide(
          color: MyMateThemes.secondaryColor,
          width: 2,
        ),
      ),
    ),
    child: Column(
      children: [
        SvgPicture.asset(iconPath),
        SizedBox(height: 5),
        Text(
          text1,
          style: TextStyle(
            color: MyMateThemes.textColor,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            color: MyMateThemes.primaryColor,
            fontSize: 10,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}









