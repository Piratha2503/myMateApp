import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../MyMateThemes.dart';

class CompleteProfileWidgets {
  // AppBar widget
  static AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/images/chevron-left.svg'),
            ),
            SizedBox(width: 100),
            Text(
              'Complete Profile',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TextField widget row
  static Widget buildTextFieldRow({
    required String label,
    required String hintText,
    required TextEditingController controller, // Keep this as it is
  }) {
    return Container(
      decoration: BoxDecoration(
        color: MyMateThemes.secondaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 346,
      height: 44,
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(label, style: TextStyle(color: Colors.black)),
            ),
          ),
          Positioned(
            left: 180,
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: controller, // Attach the controller here
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: MyMateThemes.textColor.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: MyMateThemes.textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Dropdown widget row
  static Widget buildDropdownRow({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: MyMateThemes.secondaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 346,
      height: 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15),
          Text(label, style: TextStyle(color: Colors.black)),
          Spacer(),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: item == '-- Select Option --'
                        ? TextStyle(
                        color: MyMateThemes.textColor.withOpacity(0.5))
                        : TextStyle(color: MyMateThemes.textColor),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Code verification row for PageTwo
  static Widget buildCodeVerificationRow(
      BuildContext context, bool isChecked, Function(bool?) onCheck) {
    return SizedBox(
      width: 360,
      height: 65,
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Enter the code from the SMS we sent to +94 7x xxx xxx",
                style: TextStyle(color: MyMateThemes.textColor),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Checkbox(
                value: isChecked,
                onChanged: (newValue) => onCheck(newValue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

