import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/Profiles/boost_profile.dart';
import 'package:mymateapp/MyMateCommonBodies/RouterFunction.dart';

import '../../MyMateThemes.dart';
import '../Profiles/EditPage.dart';
import '../Profiles/MoreAboutMe.dart';


Widget IconWithText(String iconPath, String text1, String text2) {
  return Container(
    width: 120,
    height: 72,
    foregroundDecoration: BoxDecoration(
      border: Border(
        right: BorderSide(
          color: MyMateThemes.secondaryColor,
          width: 2,
        ),
      ),
    ),
    child: Column(
      children: [
        SvgPicture.asset(iconPath),
        SizedBox(height: 5),
        Text(
          text1,
          style: TextStyle(
            color: MyMateThemes.textColor,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          text2,
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

Widget ActionButtons(BuildContext context, String docId) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {NavigatorFunction(context, boostprofile(docId: docId,));},
        style: ElevatedButton.styleFrom(
          backgroundColor: MyMateThemes.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text('Boost ',style: TextStyle(color: Colors.white),),
      ),
      SizedBox(width: 60),
      ElevatedButton(
        onPressed: () {
          NavigatorFunction(context, EditPage(docId: docId, onSave: () {  },));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyMateThemes.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text('Edit Profile',style: TextStyle(color: Colors.white),),
      ),
    ],
  );
}

Widget Containers({required List<Widget> children}) {
  return Column(
    children: children,
  );
}

Widget AdditionalInfo(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            SizedBox(width: 40),
            Text(
              'Hobby',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            SizedBox(width: 28),
            Tag('Reading Story Book'),
            SizedBox(width: 3),
            Tag('Gardening'),
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [
            SizedBox(width: 40),
            Text(
              'Favorites',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            SizedBox(width: 28),
            Tag('Ice cream'),
            SizedBox(width: 3),
            Tag('Traveling'),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            SizedBox(width: 40),
            Text(
              'Alcohol',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 25),
        AlcoholSelection(context),
        SizedBox(height: 25),
        Row(
          children: [
            SizedBox(width: 40),
            Text(
              'Sports',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            SizedBox(width: 28),
            Tag('Badminton'),
            SizedBox(width: 3),
            Tag('Chess'),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 40),
            Text(
              'Cooking',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        CookingSelection(),
        SizedBox(height: 30),

      ],
    ),
  );
}

Widget Tag(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: MyMateThemes.primaryColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
      ),
    ),
  );
}

Widget SectionTitle(String title) {
  return Row(
    children: [
      SizedBox(width: 40),
      SvgPicture.asset('assets/images/Group 2148.svg'),
      SizedBox(width: 4),
      Text(
        title,
        style: TextStyle(
          color: MyMateThemes.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

class AlcoholSelection extends StatefulWidget {
  AlcoholSelection(BuildContext context);

  @override
  State<AlcoholSelection> createState() => _AlcoholSelectionState();
}

class _AlcoholSelectionState extends State<AlcoholSelection>{
  int selectedAlcoholIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 24),
          painter: _LinePainter(selectedAlcoholIndex: selectedAlcoholIndex),
        ),

        Row(
          children: [
            SizedBox(width: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAlcoholIndex = 0;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedAlcoholIndex >= 0),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Never',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 0
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Had',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 0
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAlcoholIndex = 1;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedAlcoholIndex >= 1),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Rarely ',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 1
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 1
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAlcoholIndex = 2;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedAlcoholIndex >= 2),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Occasionally',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 2
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 2
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAlcoholIndex = 3;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedAlcoholIndex >= 3),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Regularly',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 3
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 3
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAlcoholIndex = 4;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedAlcoholIndex >= 4),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Swimming',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 4
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      ' in it (24/7)',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 4
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CookingSelection extends StatefulWidget {
  const CookingSelection({super.key});

  @override
  State<CookingSelection> createState() => _CookingSelectionState();
}

class _CookingSelectionState extends State<CookingSelection> {
  int selectedCookingIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 24),
          painter: _LinearPainter(selectedCookingIndex: selectedCookingIndex),
        ),
        Row(
          children: [
            SizedBox(width: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCookingIndex = 0;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedCookingIndex >= 0),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Zero',
                      style: TextStyle(
                        color: selectedCookingIndex >= 0
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCookingIndex = 1;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedCookingIndex >= 1),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Novice',
                      style: TextStyle(
                        color: selectedCookingIndex >= 1
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCookingIndex = 2;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedCookingIndex >= 2),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Basic',
                      style: TextStyle(
                        color: selectedCookingIndex >= 2
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCookingIndex = 3;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedCookingIndex >= 3),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Intermediate',
                      style: TextStyle(
                        color: selectedCookingIndex >= 3
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCookingIndex = 4;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedCookingIndex >= 4),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Advanced',
                      style: TextStyle(
                        color: selectedCookingIndex >= 4
                            ? MyMateThemes.textColor
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CirclePainter extends CustomPainter {
  final bool isActive;

  _CirclePainter({required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isActive ? MyMateThemes.primaryColor : Colors.grey[300]!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 12, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _LinePainter extends CustomPainter {
  final int selectedAlcoholIndex;

  _LinePainter({required this.selectedAlcoholIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyMateThemes.primaryColor
      ..strokeWidth = 4;

    final double segmentWidth = size.width / 5;

    // Draw lines between circles
    for (int i = 0; i < 4; i++) {
      if (i < selectedAlcoholIndex) {
        paint.color = MyMateThemes.primaryColor;
      } else {
        paint.color = Colors.grey.withOpacity(0.1);
      }
      canvas.drawLine(
        Offset((i + 0.5) * segmentWidth, size.height / 2),
        Offset((i + 1.5) * segmentWidth, size.height / 2),
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
      ..strokeWidth = 4;

    final double segmentWidth = size.width / 5;

    // Draw lines between circles
    for (int i = 0; i < 4; i++) {
      if (i < selectedCookingIndex) {
        paint.color = MyMateThemes.primaryColor;
      } else {
        paint.color = Colors.grey.withOpacity(0.1);
      }
      canvas.drawLine(
        Offset((i + 0.5) * segmentWidth, size.height / 2),
        Offset((i + 1.5) * segmentWidth, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}