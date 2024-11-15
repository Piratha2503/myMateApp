import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../MyMateThemes.dart';


class MyProfileMoreAboutMePage extends StatefulWidget {
  const MyProfileMoreAboutMePage({Key? key}) : super(key: key);

  @override
  State<MyProfileMoreAboutMePage> createState() => _MyProfileMoreAboutMePageState();
}

class _MyProfileMoreAboutMePageState extends State<MyProfileMoreAboutMePage> {
  int selectedAlcoholIndex = 0;
  int selectedCookingIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      // appBar: AppBar(
      //   title: Text("More About Me"),
      //   backgroundColor: MyMateThemes.primaryColor,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 40),
                SvgPicture.asset('assets/images/Line 11.svg'),
              ],
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
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
            SizedBox(height: 10),
            AlcoholSelection(),
            SizedBox(height: 10),
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
            SizedBox(height: 15),
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
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyMateThemes.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Back',
                  style: TextStyle(color: Colors.white, letterSpacing: 1.5),
                ),
              ),
            ),
          ],
        ),
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

  Widget AlcoholSelection() {
    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 24),
          painter: _LinePainter(selectedAlcoholIndex: selectedAlcoholIndex),
        ),
        Row(
          children: [
            SizedBox(width: 15),
            for (int i = 0; i < 5; i++)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAlcoholIndex = i;
                    });
                  },
                  child: Column(
                    children: [
                      CustomPaint(
                        painter: _CirclePainter(isActive: selectedAlcoholIndex == i),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        ['Never', 'Rarely', 'Occasionally', 'Regularly', 'Swimming'][i],
                        style: TextStyle(
                          color: selectedAlcoholIndex == i
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

  Widget CookingSelection() {
    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 24),
          painter: _LinearPainter(selectedCookingIndex: selectedCookingIndex),
        ),
        Row(
          children: [
            SizedBox(width: 15),
            for (int i = 0; i < 5; i++)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCookingIndex = i;
                    });
                  },
                  child: Column(
                    children: [
                      CustomPaint(
                        painter: _CirclePainter(isActive: selectedCookingIndex == i),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        ['Zero', 'Novice', 'Basic', 'Intermediate', 'Advanced'][i],
                        style: TextStyle(
                          color: selectedCookingIndex == i
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
