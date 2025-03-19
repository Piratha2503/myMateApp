
import 'package:flutter/material.dart';

class MyMateThemes {
  static const primaryColor = Color(0xFF7D67EE);
  static const secondaryColor = Color(0xFFE2E6FE);
  static const premiumColor = Color(0xFF0F0641);
  static const textColor = Color(0xFF666666);
  static const backgroundColor = Color(0xFFFEFEFA);
  static const containerColor = Color(0xFFF5F5F7);
  static const premiumAccent = Color(0xFFFFB743);
  static const textGray = Color.fromRGBO(27, 31, 27, 100);
  static const double buttonFontSize = 18;
  static const double nomalFontSize = 18;
  static const double subHeadFontSize = 20;
}

class CommonButtonStyle {
  static ButtonStyle commonButtonStyle() {
    return
      ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(MyMateThemes.primaryColor),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          )),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0), // Adjust values as needed
        ),
    );
  }
}



/*

* */