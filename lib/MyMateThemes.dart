
import 'package:dropdown_button2/dropdown_button2.dart';
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
    return
      ButtonStyle(

      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(MyMateThemes.primaryColor),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          )),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0), // Adjust values as needed
        ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Label
        Row(
          children: [
            SizedBox(width: width * 0.06),
            Text(
              label,
              style: TextStyle(
                color: MyMateThemes.textColor, // Change to your theme color
                fontWeight: FontWeight.w400,
                fontSize: width * 0.042,
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.01), // Space between label and dropdown
        // Dropdown Field
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: MyMateThemes.textColor.withOpacity(0.2), // Border color
            ),
            borderRadius: BorderRadius.circular(width * 0.02),
          ),
          width: width * 0.9,
          height: height * 0.06,
          child:
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              value: value,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: item.startsWith('Select')
                          ? MyMateThemes.textColor.withOpacity(0.5)
                          : MyMateThemes.textColor.withOpacity(0.8),
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }).toList(),

              // **Dropdown Styling**
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: Colors.white, // Change dropdown background
                  borderRadius: BorderRadius.circular(width * 0.02),
                  border: Border.all(
                    color: MyMateThemes.textColor.withOpacity(0.1), // Dropdown border color
                  ),
                ),
              ),

              // **Customize selected item background**
              selectedItemBuilder: (BuildContext context) {
                return items.map<Widget>((String item) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal:width*0.004,vertical: height*0.013),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: MyMateThemes.textColor.withOpacity(0.7), // Selected item text color
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ],
    );
  }
}


/*

* */