import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/Profiles/boost_profile.dart';
import 'package:mymateapp/MyMateCommonBodies/RouterFunction.dart';

import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateThemes.dart';
import '../Profiles/EditPage.dart';
import '../Profiles/MoreAboutMe.dart';

Widget IconWithText(BuildContext context, String iconPath, String text1, String text2) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.28,
    height: MediaQuery.of(context).size.height * 0.1,
    // foregroundDecoration: BoxDecoration(
    //   border: Border(
    //     right: BorderSide(
    //       color: MyMateThemes.textColor.withOpacity(0.2),
    //       width: MediaQuery.of(context).size.width * 0.003,
    //     ),
    //   ),
    // ),
    child: Column(
      children: [
        SvgPicture.asset(
          iconPath,
          width: MediaQuery.of(context).size.width * 0.08,
          height: MediaQuery.of(context).size.width * 0.08,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.007),
        Text(
          text1,
          style: TextStyle(
            color: MyMateThemes.textColor,
            fontSize: MediaQuery.of(context).size.width * 0.028,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            color: MyMateThemes.primaryColor,
            fontSize: MediaQuery.of(context).size.width * 0.028,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget ActionButtons(BuildContext context, String docId) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height:MediaQuery.of(context).size.height * 0.06 ,
        width: MediaQuery.of(context).size.width * 0.43,
        child:
        ElevatedButton(
          onPressed: () {
            NavigatorFunction(
                context,
                boostprofile(
                  docId: docId,
                ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyMateThemes.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.015,
            ),
          ),
          child: Text(
            'Boost ',
            style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.04),
          ),
        ),

      ),
      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
      SizedBox(
        height:MediaQuery.of(context).size.height * 0.06 ,
        width: MediaQuery.of(context).size.width * 0.43,
        child: ElevatedButton(
          onPressed: () {
            NavigatorFunction(
                context,
                EditPage(
                  docId: docId,
                  onSave: () {},
                ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyMateThemes.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.015,
            ),
          ),
          child: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.04),
          ),
        ),
      ),
    ],
  );
}

Widget Containers({required List<Widget> children}) {
  return Column(
    children: children,
  );
}

final List<String> _alcoholOptions = [
  'Never Had',
  'Rarely Drinker',
  'Occasionally Drinker',
  'Regularly Drinker',
  'Swimming in it (24/7)',
];
final List<String> _smokingOptions = [
  'Never Had',
  'Rarely Smoker',
  'Occasionally Smoker',
  'Regularly Smoker',
  'Chain Smoker',
];

final List<String> _cookingOptions = [
  'Zero',
  'Novice',
  'Basic',
  'Intermediate',
  'Advanced',
];

class AdditionalInfo extends StatefulWidget {
  final String docId;
  const AdditionalInfo({Key? key,required this.docId}) : super(key: key);

  @override
  _AdditionalInfoState createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  int selectedAlcoholIndex = -1;
  int selectedSmokingIndex = -1;
  int selectedCookingIndex = -1;

  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController favoritesController = TextEditingController();
  final TextEditingController sportsController = TextEditingController();

  List<String> hobbyTags = [];
  List<String> favoritesTags = [];
  List<String> sportsTags = [];

  String _selectedValue = '';

  int _getIndexFromString(String value, List<String> options) {
    return options.indexOf(value);
  }

  Future<void> _fetchClientDetails() async {
    try {
      final data = await fetchUserById(widget.docId);

      if (data.isNotEmpty) {
        setState(() {
          _selectedValue = data['eating_habit'] ?? '';
          selectedAlcoholIndex =
              _getIndexFromString(data['alcoholIntake'], _alcoholOptions);
          selectedSmokingIndex =
              _getIndexFromString(data['smoking'], _smokingOptions);
          selectedCookingIndex =
              _getIndexFromString(data['cooking'], _cookingOptions);
          hobbyTags = List<String>.from(data['favorites'] ?? []);
        });
      }
      print(selectedSmokingIndex);
      print(selectedAlcoholIndex);
      print(selectedCookingIndex);

    } catch (e) {
      print('Error occurred while fetching client details: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchClientDetails();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: screenWidth*0.02),
              Text(
                'Personal Interest',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: screenWidth*0.042,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.013),
          Row(
            children: [
              SizedBox(width: screenWidth*0.03),
              SvgPicture.asset('assets/images/Line 11.svg',width: screenWidth*0.87,),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          // _buildTextField(context,hobbyController, 'Personal Interest'),
          // SizedBox(height: screenHeight * 0.03),
          Row(
            children: [
              SizedBox(width: screenWidth*0.08,),
              Wrap(
                children: hobbyTags.map((tag) => _buildTag(context, tag)).toList(),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          Row(
            children: [
              SizedBox(width: screenWidth*0.02),
              Text(
                'Skills & Habits',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: screenWidth*0.042,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.013),
          Row(
            children: [
              Row(
                children: [
                  SizedBox(width: screenWidth*0.03),
                  SvgPicture.asset('assets/images/Line 11.svg',width: screenWidth*0.87,),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            children: [
              SizedBox(width: screenWidth*0.02),
              Text(
                'Eating Habits',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: screenWidth*0.04,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight*0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width:screenWidth*0.06 ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedValue = 'Vegetarian'; // Update selected state
                      });
                    },
                    child: Container(
                      width: screenWidth * 0.063, // Circle size
                      height: screenHeight * 0.063,
                      decoration: BoxDecoration(
                        color: _selectedValue == 'Vegetarian'
                            ? MyMateThemes.primaryColor // Selected color (filled)
                            : Colors.transparent, // Unselected (transparent inside)
                        border: Border.all(
                          color: _selectedValue == 'Vegetarian'
                              ? Colors.transparent // Selected color (filled)
                              : MyMateThemes.secondaryColor, // Outline color
                          width: 3, // Thickness of the outline
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: _selectedValue == 'Vegetarian'
                          ? Center(
                        child: Container(
                          width: screenWidth * 0.015, // Inner dot size
                          height: screenHeight * 0.015,
                          decoration: BoxDecoration(
                            color: Colors.white, // White inner dot for selected state
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                          : null, // No inner dot when unselected
                    ),
                  ),

                  SizedBox(width: screenWidth * 0.025),

                  Text(
                    'Vegetarian',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.normal,
                      fontSize: screenWidth * 0.027,
                    ),
                  ),
                ],
              ),
              SizedBox(width: screenWidth * 0.15),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedValue = 'Non-Vegetarian'; // Update selected state
                      });
                    },
                    child:
                    Container(
                      width: screenWidth * 0.063, // Circle size
                      height: screenHeight * 0.063,
                      decoration: BoxDecoration(
                        color: _selectedValue == 'Non-Vegetarian'
                            ? MyMateThemes.primaryColor // Selected color (filled)
                            : Colors.transparent, // Unselected (transparent inside)
                        border: Border.all(
                          color: _selectedValue == 'Non-Vegetarian'
                              ? Colors.transparent // Selected color (filled)
                              : MyMateThemes.secondaryColor, // Outline color
                          width: 3, // Thickness of the outline
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: _selectedValue == 'Non-Vegetarian'
                          ? Center(
                        child: Container(
                          width: screenWidth * 0.015, // Inner dot size
                          height: screenHeight * 0.015,
                          decoration: BoxDecoration(
                            color: Colors.white, // White inner dot for selected state
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                          : null, // No inner dot when unselected
                    ),
                  ),

                  SizedBox(width: screenWidth * 0.025),

                  Text(
                    'Non-Vegetarian',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.normal,
                      fontSize: screenWidth * 0.027,
                    ),
                  ),
                ],
              )
            ],
          ),
        //  Row(
          //  mainAxisAlignment: MainAxisAlignment.center,
            //children: <Widget>[
              // Row(
              //   children: [
              //     Radio<String>(
              //       value: 'Vegetarian',
              //       groupValue: _selectedValue,
              //       onChanged: null,
              //       activeColor: MyMateThemes.primaryColor,
              //     ),
              //     Text('Vegetarian'),
              //   ],
              // ),
              // SizedBox(width: screenWidth * 0.12),
              // Row(
              //   children: [
              //     Radio<String>(
              //       value: 'Non-Vegetarian',
              //       groupValue: _selectedValue,
              //       onChanged: null,
              //       activeColor: MyMateThemes.primaryColor,
              //     ),
              //     Text('Non-Vegetarian'),
              //   ],
              // ),
          //  ],
          //),
          SizedBox(height: screenHeight * 0.04),
          Row(
            children: [
              SizedBox(width: screenWidth*0.02),
              Text(
                'Alcohol',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: screenWidth*0.04,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.04),
          _buildAlcoholSelection(selectedAlcoholIndex, context),
          SizedBox(height: screenHeight * 0.06),
          Row(
            children: [
              SizedBox(width: screenWidth*0.02),
              Text(
                'Smoking',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: screenWidth*0.04,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.04),
          _buildSmokingSelection(selectedSmokingIndex, context),
          SizedBox(height: screenHeight * 0.06),
          Row(
            children: [
              SizedBox(width: screenWidth*0.02),
              Text(
                'Cooking',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: screenWidth*0.04,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          _buildCookingSelection(selectedCookingIndex, context),
        ],
      ),
    );
  }}

Widget Tag(BuildContext context, String text) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.03, // 3% of screen width
      vertical: MediaQuery.of(context).size.height * 0.01, // 1% of screen height
    ),
    decoration: BoxDecoration(
      color: MyMateThemes.primaryColor,
      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02), // Responsive border radius
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: MediaQuery.of(context).size.width * 0.035, // Responsive font size
      ),
    ),
  );
}

Widget SectionTitle(BuildContext context, String title, String svg) {
  return Row(
    children: [
      SizedBox(width: MediaQuery.of(context).size.width * 0.05), // 10% of screen width
      SvgPicture.asset(
        svg,
        width: MediaQuery.of(context).size.width * 0.05, // Responsive icon size
      ),
      SizedBox(width: MediaQuery.of(context).size.width * 0.013), // Small spacing
      Text(
        title,
        style: TextStyle(
          color: MyMateThemes.primaryColor,
          fontSize: MediaQuery.of(context).size.width * 0.043, // Responsive font size
          fontWeight: FontWeight.normal,
        ),
      ),
    ],
  );
}

Widget _buildTextField(BuildContext context, TextEditingController controller, String hintText) {
  return Container(
    decoration: BoxDecoration(
      color: MyMateThemes.containerColor,
      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02), // Responsive border radius
    ),
    width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
    height: MediaQuery.of(context).size.height * 0.05, // 5% of screen height
    child: Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025), // Responsive left padding
      child: TextField(
        controller: controller,
        enabled: false, // Disable editing
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MyMateThemes.textColor.withOpacity(0.5),
            fontSize: MediaQuery.of(context).size.width * 0.04, // Responsive font size
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012), // Responsive content padding
          hintText: hintText,
        ),
      ),
    ),
  );
}

Widget _buildTag(BuildContext context, String text) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.012, // 1.2% of screen width
      vertical: MediaQuery.of(context).size.height * 0.007, // 0.7% of screen height
    ),
    padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.03, // 3% of screen width
      vertical: MediaQuery.of(context).size.height * 0.01, // 1% of screen height
    ),
    decoration: BoxDecoration(
      color: MyMateThemes.primaryColor,
      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02), // Responsive border radius
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: MediaQuery.of(context).size.width * 0.035, // Responsive font size
      ),
    ),
  );
}

Widget _buildAlcoholSelection(
    final int selectedAlcoholIndex,
    BuildContext context,
    ) {
  double circleSize = MediaQuery.of(context).size.width * 0.06;
  double textSize = MediaQuery.of(context).size.width * 0.027;
  double spacing = MediaQuery.of(context).size.height * 0.015;

  return Stack(
    children: [
      CustomPaint(
        size: Size(MediaQuery.of(context).size.width, circleSize),
        painter: _LinePainter(selectedAlcoholIndex: selectedAlcoholIndex),
      ),
      Row(
        children: [
          for (int i = 0; i < 5; i++)
            Expanded(
              child: Column(
                children: [
                  CustomPaint(
                    painter:
                    _CirclePainter(isActive: selectedAlcoholIndex >= i),
                    child: SizedBox(
                      width: circleSize,
                      height: circleSize,
                    ),
                  ),
                  SizedBox(height: spacing),
                  Text(
                    _alcoholOptions[i].split(' ')[0],
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: textSize,
                        fontWeight: FontWeight.w300

                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

Widget _buildSmokingSelection(
    final int selectedSmokingIndex,
    BuildContext context,
    ) {
  double circleSize = MediaQuery.of(context).size.width * 0.06;
  double textSize = MediaQuery.of(context).size.width * 0.027;
  double spacing = MediaQuery.of(context).size.height * 0.015;

  return Stack(
    children: [
      CustomPaint(
        size: Size(MediaQuery.of(context).size.width, circleSize),
        painter: _SmokingLinePainter(selectedSmokingIndex: selectedSmokingIndex),
      ),
      Row(
        children: [
          for (int i = 0; i < 5; i++)
            Expanded(
              child: Column(
                children: [
                  CustomPaint(
                    painter:
                    _CirclePainter(isActive: selectedSmokingIndex >= i),
                    child: SizedBox(
                      width: circleSize,
                      height: circleSize,
                    ),
                  ),
                  SizedBox(height: spacing),
                  Text(
                    _smokingOptions[i].split(' ')[0],
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: textSize,
                        fontWeight: FontWeight.w300

                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

Widget _buildCookingSelection(
    final int selectedCookingIndex,
    BuildContext context,
    ) {
  double circleSize = MediaQuery.of(context).size.width * 0.06;
  double textSize = MediaQuery.of(context).size.width * 0.027;
  double spacing = MediaQuery.of(context).size.height * 0.015;

  return Stack(
    children: [
      CustomPaint(
        size: Size(MediaQuery.of(context).size.width, circleSize),
        painter: _LinearPainter(selectedCookingIndex: selectedCookingIndex),
      ),
      Row(
        children: [
          for (int i = 0; i < 5; i++)
            Expanded(
              child: Column(
                children: [
                  CustomPaint(
                    painter:
                    _CirclePainter(isActive: selectedCookingIndex >= i),
                    child: SizedBox(
                      width: circleSize,
                      height: circleSize,
                    ),
                  ),
                  SizedBox(height: spacing),
                  Text(
                    _cookingOptions[i],
                    style: TextStyle(
                      color:MyMateThemes.textColor,
                      fontSize: textSize,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

class _CirclePainter extends CustomPainter {
  final bool isActive;

  _CirclePainter({required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = isActive ? MyMateThemes.primaryColor : Colors.white // Fill only if active
      ..style = isActive ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 3.0; // Border thickness

    final Paint borderPaint = Paint()
      ..color = isActive ? MyMateThemes.primaryColor : MyMateThemes.secondaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Draw circle with border
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2.2,
      borderPaint,
    );

    // Draw filled circle only when active
    if (isActive) {
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.width / 2.2,
        paint,
      );
    }
  }



  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class _LinePainter extends CustomPainter {
  final int selectedAlcoholIndex;


  _LinePainter({required this.selectedAlcoholIndex,});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyMateThemes.primaryColor
      ..strokeWidth = 3;

    final double segmentWidth = size.width / 5;

    // Draw lines between circles
    for (int i = 0; i < 4; i++) {
      if (i < selectedAlcoholIndex) {
        paint.color = MyMateThemes.primaryColor;
      } else {
        paint.color = Colors.grey.withOpacity(0.1);
      }
      canvas.drawLine(
        Offset((i + 0.7) * segmentWidth, size.height / 2),
        Offset((i + 1.4) * segmentWidth, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _SmokingLinePainter extends CustomPainter {
  final int selectedSmokingIndex;


  _SmokingLinePainter({required this.selectedSmokingIndex,});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyMateThemes.primaryColor
      ..strokeWidth = 3;

    final double segmentWidth = size.width / 5;

    // Draw lines between circles
    for (int i = 0; i < 4; i++) {
      if (i < selectedSmokingIndex) {
        paint.color = MyMateThemes.primaryColor;
      } else {
        paint.color = Colors.grey.withOpacity(0.1);
      }
      canvas.drawLine(
        Offset((i + 0.7) * segmentWidth, size.height / 2),
        Offset((i + 1.4) * segmentWidth, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



class _LinearPainter extends CustomPainter {
  final int selectedCookingIndex;

  _LinearPainter({required this.selectedCookingIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyMateThemes.primaryColor
      ..strokeWidth = 3;

    final double segmentWidth = size.width / 5;

    // Draw lines between circles
    for (int i = 0; i < 4; i++) {
      if (i < selectedCookingIndex) {
        paint.color = MyMateThemes.primaryColor;
      } else {
        paint.color = Colors.grey.withOpacity(0.1);
      }
      canvas.drawLine(
        Offset((i + 0.7) * segmentWidth, size.height / 2),
        Offset((i + 1.4) * segmentWidth, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}