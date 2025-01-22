
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
    return ButtonStyle(
      // Regular button color
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(MyMateThemes.primaryColor),

      // Pressed effect
      overlayColor: MaterialStateProperty.all(Colors.black12), // Subtle overlay effect

      // Shape of the button with rounded corners
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),

      // Elevation change when button is pressed
      elevation: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return 4.0; // Raised effect when pressed
        }
        return 2.0; // Default elevation
      }),

      // Add a scale effect on press
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0)),
    );
  }
}
