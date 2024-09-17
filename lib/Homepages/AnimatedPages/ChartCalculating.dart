import 'package:flutter/material.dart';
import 'package:mymateapp/ChartPages/ChartViewPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class ChartCalculating extends StatefulWidget {
  const ChartCalculating({super.key});

  @override
  State<ChartCalculating> createState() => _ChartCalculatingState();
}

class _ChartCalculatingState extends State<ChartCalculating> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: MyMateThemes.backgroundColor,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'Generating',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: MyMateThemes.primaryColor),
            ),
          ),
          Container(
            child: Text(
              'Your Chart',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: MyMateThemes.primaryColor),
            ),
          ),
        ],
      ),
      nextScreen: ChartViewPage(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
      splashIconSize: 150, // Adjust the size of the splash icon if needed
    );
  }
}
