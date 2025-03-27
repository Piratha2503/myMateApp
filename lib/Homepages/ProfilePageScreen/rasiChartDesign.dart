import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import '../../MyMateThemes.dart';

Widget RasiChartDesign(BuildContext context) {
  double containerSize = MediaQuery.of(context).size.width * 0.75;
  double boxSize = containerSize / 3.4;
  double innerBoxSize = containerSize / 2.25;
  double fontSize = containerSize * 0.045;
  final double screenHeight = MediaQuery.of(context).size.height;
  final double screenWidth = MediaQuery.of(context).size.width;

  return Container(
    height: containerSize,
    width: containerSize,
    color: Colors.white,
    child: Stack(
      children: [
        Positioned(top: boxSize * 0.13, left: boxSize * 0.14, child: IndividualBox(context,"01")),
        Positioned(top: boxSize * 0.13, left: boxSize * 1, child: IndividualBox(context,"02")),
        Positioned(top: boxSize * 0.13, left: boxSize * 1.80, child: IndividualBox(context,"03")),
        Positioned(top: boxSize * 0.13, left: boxSize * 2.62, child: IndividualBox(context,"04")),
        Positioned(top: boxSize * 0.93, left: boxSize * 0.18, child: IndividualBox(context,"12")),
        Positioned(top: boxSize * 1.77, left: boxSize * 0.18, child: IndividualBox(context,"11")),
        Positioned(top: boxSize * 2.59, left: boxSize * 0.18, child: IndividualBox(context,"10")),
        Positioned(top: boxSize * 0.93, left: boxSize * 2.62, child: IndividualBox(context,"05")),
        Positioned(top: boxSize * 1.77, left: boxSize * 2.62, child: IndividualBox(context,"06")),
        Positioned(top: boxSize * 2.59, left: boxSize * 2.62, child: IndividualBox(context,"07")),
        Positioned(top: boxSize * 2.59, left: boxSize * 1.80, child: IndividualBox(context,"08")),
        Positioned(top: boxSize * 2.59, left: boxSize * 1, child: IndividualBox(context,"09")),

        Positioned(
          top: boxSize * 0.95,
          left: boxSize * 1.0,
          child:
          Container(
            height: innerBoxSize,
            width: innerBoxSize,
            decoration: BoxDecoration(
              color: MyMateThemes.primaryColor,
              borderRadius: BorderRadius.circular(containerSize * 0.015),
            ),
            child:
            Stack(
              children: [
                Positioned(
                  top: screenHeight * 0.013,
                  left: screenWidth * 0.06,
                  child: SvgPicture.asset('assets/images/Group 2217.svg', width: screenWidth * 0.12,height: screenHeight*0.11,),
                ),
                Positioned(
                  bottom: screenHeight * 0.02,
                  left: screenWidth * 0.01,
                  child: Column(
                    children: [
                      Text(
                        'Hastam',
                        style: TextStyle(
                          fontSize: screenWidth * 0.025,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.005,
                  left: screenWidth * 0.01,
                  child: Column(
                    children: [

                      Text(
                        'Virgo (kanni)',
                        style: TextStyle(
                          fontSize: screenWidth * 0.025,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
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
  Text("sun",style: TextStyle(fontWeight: FontWeight.normal,color:Colors.white,fontSize: 10),),

];

Widget IndividualBox(BuildContext context, String number) {
  double boxSize = MediaQuery.of(context).size.width * 0.155;
  double borderRadius = boxSize * 0.08;
  double fontSize = boxSize * 0.2;

  return Container(
    height: boxSize,
    width: boxSize,
    decoration: BoxDecoration(
      color: MyMateThemes.primaryColor,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                SizedBox(width: 3),
                Text(
                  number,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: fontSize,
                  ),
                ),

              ],
            ),
            SizedBox(height: boxSize*0.3,),
            Row(
              children: [
                SizedBox(width: 3),
                Column(
                  children:
                  widgetList,

                )

              ],
            ),

          ],
        ),

  );
}