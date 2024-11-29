import 'package:flutter/material.dart';
import '../../MyMateThemes.dart';

Widget RasiChartDesign() {
  return Container(
    height: 258,
    width: 258,
    color: MyMateThemes.containerColor,
    child: Stack(
      children: [
        Positioned( top: 10,  left: 10,  child: IndividualBox("01")),
        Positioned( top: 10,  left: 72,  child: IndividualBox("02")),
        Positioned( top: 10,  left: 134, child: IndividualBox("03")),
        Positioned( top: 10,  left: 196, child: IndividualBox("04")),
        Positioned( top: 72,  left: 10,  child: IndividualBox("12")),
        Positioned( top: 134, left: 10,  child: IndividualBox("11")),
        Positioned( top: 196, left: 10,  child: IndividualBox("10")),
        Positioned( top: 72,  left: 196, child: IndividualBox("05")),
        Positioned( top: 134, left: 196, child: IndividualBox("06")),
        Positioned( top: 196, left: 196, child: IndividualBox("07")),
        Positioned( top: 196, left: 134, child: IndividualBox("08")),
        Positioned( top: 196, left: 72,  child: IndividualBox("09")),
        Positioned(
          top: 72,
          left: 72,
          child: Container(
            height: 114,
            width: 114,
            decoration: BoxDecoration(
              color: MyMateThemes.primaryColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 5,
                  left: 3,
                  child: Column(
                    children: [
                      Text(
                        'Hastam',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'Virgo (kanni)',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

List<Widget> widgetList = [
  Text("sun"),

];

Widget IndividualBox(String number){
  return Container(
    height: 52,
    width: 52,
    decoration: BoxDecoration(
      color: MyMateThemes.primaryColor,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Stack(
      children: [
        Column(
          children: <Widget>[
            Text(
              number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 10),
            ),
            Column(
              children: widgetList,
            )
          ],
        ),
      ],
    ),
  );
}
