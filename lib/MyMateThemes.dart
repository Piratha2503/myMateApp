import 'dart:ui';

import 'package:flutter/material.dart';

class MyMateThemes {
  static const primaryGreen = Color(0xFF7D67EE);
  static const secondaryGreen = Color(0xFFE2E6FE);
  static const backgroundWhite = Color(0xFFFEFEFA);
  static const containerViolet = Color(0xFFF5F5F7);
  static const textGreen = Color(0xFF666666);
  static const textGray = Color.fromRGBO(27, 31, 27, 100);

  static const double buttonFontSize = 18;
  static const double nomalFontSize = 18;
  static const double subHeadFontSize = 20;
}

class CommonButtonStyle {
  static ButtonStyle commonButtonStyle() {
    return ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(MyMateThemes.primaryGreen),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
    );
  }
}

/*
static const backgroundWhite = Color(0xFFedfaed);
 */
