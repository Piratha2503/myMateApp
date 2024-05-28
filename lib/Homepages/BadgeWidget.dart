import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

class BadgeWidget extends StatelessWidget {
  final String assetPath;
  final int badgeValue;

  const BadgeWidget({
    Key? key,
    required this.assetPath,
    required this.badgeValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(assetPath),
        if (badgeValue > 0)
          Positioned(
            top: -2,
            right: -1,
            child: Container(
              decoration: BoxDecoration(
                color: MyMateThemes.secondaryColor,
                borderRadius: BorderRadius.circular(4),
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
