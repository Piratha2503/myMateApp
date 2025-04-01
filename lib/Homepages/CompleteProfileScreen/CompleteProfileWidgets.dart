import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../MyMateThemes.dart';

class CompleteProfileWidgets {
  // AppBar widget
  static AppBar buildAppBar(BuildContext context, BoxConstraints constraints) {
    double width = constraints.maxWidth;

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
            SizedBox(width: width * 0.1),
            Text(
              'Complete Profile',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: width * 0.04,
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
    required TextEditingController controller,
    String? errorText,
    required BuildContext context,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: MyMateThemes.textColor.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: width * 1,
      height: height*0.065,
      child: Stack(
        children: [
          Positioned(
            left: width*0.03,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(label, style: TextStyle(fontWeight:FontWeight.normal,color: MyMateThemes.textColor,fontSize: width*.04)),
            ),
          ),
          Positioned(
            left: width*0.53,
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: errorText == null ? hintText : null,
                  errorText: errorText,
                  hintStyle: TextStyle(
                    color: MyMateThemes.textColor.withOpacity(0.3),
                    fontWeight: FontWeight.normal,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: MyMateThemes.textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: MediaQuery.of(context).size.width * 0.04,),
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
    required BuildContext context,

  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: MyMateThemes.textColor.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: width * 1,
      height: height*0.065,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: width*0.03),
          Text(label, style: TextStyle(color: MyMateThemes.textColor, fontSize :width*.04,fontWeight:FontWeight.normal)),
          Spacer(),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon:  Icon(Icons.keyboard_arrow_down_outlined, color:MyMateThemes.primaryColor),

              value: value,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: item == '-- Select Option --'
                        ? TextStyle(
                        color: MyMateThemes.textColor.withOpacity(0.3),
                      fontWeight: FontWeight.normal,
                      fontSize: MediaQuery.of(context).size.width * 0.04,

                    )
                        : TextStyle(color: MyMateThemes.textColor,
                      fontWeight: FontWeight.normal,
                      fontSize: MediaQuery.of(context).size.width * 0.04,

                    ),
                  ),
                );
              }).toList(),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width  * 0.02),

            ),


          ),
        ],
      ),
    );
  }
}
