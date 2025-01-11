import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../WelcomeScreen.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for blinking effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
    )..repeat(reverse: true); // Repeats back and forth for blinking

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: MyMateThemes.primaryColor,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: _opacityAnimation,
            child: Text(
              'My Mate',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: MyMateThemes.backgroundColor,
              ),
            ),
          ),
        ],
      ),
      nextScreen: const WelcomePage(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 5000,
      splashIconSize: 300, // Adjust the size of the splash icon if needed
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
