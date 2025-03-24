import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

class CustomOutlineButton extends StatelessWidget {
  final String assetPath;
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomOutlineButton({
    super.key,
    required this.assetPath,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        double buttonWidth = screenWidth * 0.01; // Adjust width based on screen size
        double buttonHeight = screenHeight * 0.05; // Keep height fixed or adjust as needed
        double iconSize = screenWidth * 0.02; // Scales icon size dynamically
        double fontSize = screenWidth * 0.025; // Scales font size dynamically

        return OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              isSelected ? MyMateThemes.primaryColor : MyMateThemes.textColor,
            ),
            backgroundColor: MaterialStateProperty.all(
              isSelected ? MyMateThemes.secondaryColor : MyMateThemes.containerColor,
            ),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth*0.01)
                )),
            side: MaterialStateProperty.all(BorderSide.none),
            minimumSize: MaterialStateProperty.all(Size(buttonWidth, buttonHeight)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                assetPath,
                color: isSelected ? MyMateThemes.primaryColor : MyMateThemes.textColor,

                width: buttonWidth*0.28,
                height: buttonHeight*0.28,
              ),
              SizedBox(width: screenWidth * 0.01), // Adjust spacing dynamically
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? MyMateThemes.primaryColor : MyMateThemes.textColor,

                  fontSize: fontSize,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        );

  }
}
