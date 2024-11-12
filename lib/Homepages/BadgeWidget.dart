import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

class BadgeWidget extends StatelessWidget {
  final String assetPath;
  final int badgeValue;

  const BadgeWidget({
    super.key,
    required this.assetPath,
    required this.badgeValue,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(assetPath),
        if (badgeValue > 0)
          Positioned(
            top: -15, // Adjust the top position as needed
            right: -10, // Adjust the right position as needed
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: MyMateThemes.secondaryColor,
                borderRadius: BorderRadius.circular(4), // More rounded corners
              ),
              child: Text(
                badgeValue.toString(),
                style: TextStyle(
                  color: MyMateThemes.primaryColor,
                  fontSize: badgeValue > 9 ? 12 : 16,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
