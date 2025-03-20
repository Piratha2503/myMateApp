import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../MyMateThemes.dart';
import '../BadgeWidget.dart';

Widget Tag(BuildContext context, String text) {
  double paddingHorizontal = MediaQuery.of(context).size.width * 0.03;
  double paddingVertical = MediaQuery.of(context).size.height * 0.01;
  double borderRadius = MediaQuery.of(context).size.width * 0.02;
  double fontSize = MediaQuery.of(context).size.width * 0.035;

  return Container(
    padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
    decoration: BoxDecoration(
      color: MyMateThemes.primaryColor,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
      ),
    ),
  );
}

Widget InfoRow(BuildContext context, String title, String value) {
  double containerWidth = MediaQuery.of(context).size.width * 0.8;
  double containerHeight = MediaQuery.of(context).size.height * 0.05;
  double fontSize = MediaQuery.of(context).size.width * 0.04;

  return
    Container(
    height: containerHeight,
    width: containerWidth,
    margin: EdgeInsets.symmetric(vertical: containerHeight * 0.13),
    padding: EdgeInsets.all(containerHeight * 0.2),
    decoration: BoxDecoration(
      border: Border.all(
        color: MyMateThemes.textColor.withOpacity(0.2),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(containerWidth * 0.01), // Dynamic border radius
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: MyMateThemes.textColor,
            fontWeight: FontWeight.normal,
            fontSize: fontSize,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: MyMateThemes.textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget IconWithText(BuildContext context, String iconPath, String text1, String text2) {
  double containerWidth = MediaQuery.of(context).size.width * 0.3;
  double containerHeight = MediaQuery.of(context).size.height * 0.09;
  double fontSize1 = MediaQuery.of(context).size.width * 0.032;
  double fontSize2 = MediaQuery.of(context).size.width * 0.027;

  return Container(
    width: containerWidth,
    height: containerHeight,
    foregroundDecoration: BoxDecoration(
      border: Border(
        right: BorderSide(
          color: MyMateThemes.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.005,
        ),
      ),
    ),
    child: Column(
      children: [
        SvgPicture.asset(
          iconPath,
          width: containerWidth * 0.5,
          height: containerHeight * 0.5,
        ),
        SizedBox(height: containerHeight * 0.07),
        Text(
          text1,
          style: TextStyle(
            color: MyMateThemes.textColor,
            fontSize: fontSize1,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            color: MyMateThemes.primaryColor,
            fontSize: fontSize2,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}
