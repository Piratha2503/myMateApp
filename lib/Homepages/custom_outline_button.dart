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
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          isSelected
              ? MyMateThemes.secondaryColor
              : MyMateThemes.containerColor,
        ),
        backgroundColor: WidgetStateProperty.all(
          isSelected
              ? MyMateThemes.secondaryColor
              : MyMateThemes.containerColor,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        side: WidgetStateProperty.all(BorderSide.none),
        minimumSize: WidgetStateProperty.all(Size(103.31, 40)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            assetPath,
            width: 18.29,
            height: 18.29,
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: MyMateThemes.primaryColor,
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
