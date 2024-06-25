import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/FirstWelcomeScreen.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../WelcomeScreen.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: MyMateThemes.backgroundColor,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'My Mate',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: MyMateThemes.primaryColor),
          ),
        ],
      ),
      nextScreen: WelcomePage(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
      splashIconSize: 150, // Adjust the size of the splash icon if needed
    );
  }
}
