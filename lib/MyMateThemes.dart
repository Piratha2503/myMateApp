
import 'dart:ui';

import 'package:flutter/material.dart';

class MyMateThemes{
  static const primaryGreen = Color(0xFF19434E);
  static const secondaryGreen = Color(0xFFEBFAEF);
  static const backgroundWhite = Color(0xFFe3e8e3);
  static const textGreen = Color(0xFF28c928);
  static const textGray = Color.fromRGBO(27, 31, 27, 100);

  static const double buttonFontSize = 18;
  static const double nomalFontSize = 18;
  static const double subHeadFontSize = 22;
}
class CommonButtonStyle{

  static ButtonStyle commonButtonStyle() {
  return ButtonStyle(
  foregroundColor: MaterialStateProperty.all(Colors.white),
  backgroundColor: MaterialStateProperty.all(MyMateThemes.primaryGreen),
  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
  );
  }

}


/*
static const backgroundWhite = Color(0xFFedfaed);
 */