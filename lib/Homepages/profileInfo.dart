import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../MyMateThemes.dart';


bool _isSmall = false;



// void _toggleSize() {
//   setState(() {
//     _isSmall = !_isSmall;
//   });
// }


Widget ProfileInfo() {
  return Column(
    children: [
      GestureDetector(
       // onTap: _toggleSize,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          height: _isSmall ? 50 : 230,
          alignment: _isSmall ? Alignment(-1.2, 1.0) : Alignment.center,
          child: SvgPicture.asset('assets/images/Group 2073 (1).svg'),
        ),
      ),
      GestureDetector(
        //onTap: _toggleSize,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: _isSmall ? Alignment(0.1, 0.0) : Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'full_name',
                style: TextStyle(
                  color: MyMateThemes.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Special Mention (Optional)',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}