import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../ProfilePageScreen/MyProfileMain.dart';

class MoreAboutMePage extends StatefulWidget {
  const MoreAboutMePage({super.key});

  @override
  State<MoreAboutMePage> createState() => _MoreAboutMePageState();
}

class _MoreAboutMePageState extends State<MoreAboutMePage> {
  int selectedAlcoholIndex = -1;
  int selectedSmokingIndex = -1;
  int selectedCookingIndex = -1;

  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController favoritesController = TextEditingController();
  final TextEditingController sportsController = TextEditingController();

  List<String> hobbyTags = [];
  List<String> favoritesTags = [];
  List<String> sportsTags = [];

  String _selectedValue = 'Option 1';


  void _addHobbyTag() {
    setState(() {
      hobbyTags.add(hobbyController.text);
      hobbyController.clear();
    });
  }

  void _addFavoritesTag() {
    setState(() {
      favoritesTags.add(favoritesController.text);
      favoritesController.clear();
    });
  }

  void _addSportsTag() {
    setState(() {
      sportsTags.add(sportsController.text);
      sportsController.clear();
    });
  }

  void _storeSelectedValues() {
    // Example logic to store the selected values
    // Replace this with your actual storage logic
    final selectedValues = {
      'hobbies': hobbyTags,
      'favorites': favoritesTags,
      'sports': sportsTags,
      'selectedAlcoholIndex': selectedAlcoholIndex,
      'selectedSmokingIndex': selectedSmokingIndex,
      'selectedCookingIndex': selectedCookingIndex,
    };

    print('Selected Values: $selectedValues');

    // Example: If you are using Firebase Firestore to store the data
    // FirebaseFirestore.instance.collection('userPreferences').add(selectedValues).then((_) {
    //   print('Values stored successfully');
    // }).catchError((error) {
    //   print('Failed to store values: $error');
    // });

    // Optionally, navigate to another page or show a success message
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfilePage(
              docId: '', selectedBottomBarIconIndex: 0,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: SafeArea(
      //     child:
      //     Row(
      //       children: [
      //         SizedBox(width: 50),
      //         Text(
      //           'More About Me',
      //           style: TextStyle(
      //             color: MyMateThemes.textColor,
      //             fontSize: 20,
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:65),
            Row(
              children: [
                SizedBox(width: 110),
                Text(
                  'More About Me',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            SizedBox(height:30),
            Row(
              children: [
                SizedBox(width: 45),
                Text(
                  'Personal Interest',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 35),
                SvgPicture.asset('assets/images/Line 11.svg'),
              ],
            ),
            SizedBox(height: 15),
            _buildTextField(hobbyController, 'Personal Interest', _addHobbyTag),
            SizedBox(height: 20),
            Wrap(
              children: hobbyTags.map((tag) => _buildTag(tag)).toList(),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 45),
                Text(
                  'Habits',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 35),
                SvgPicture.asset('assets/images/Line 11.svg'),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 45),
                Text(
                  'Eating Habits',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Radio<String>(
                      value: 'Vegetarian',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
                      activeColor: MyMateThemes.primaryColor,
                      // Change color if needed
                    ),
                    Text('Vegetarian'),
                  ],
                ),
                SizedBox(width: 50),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Non- Vegetarian',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
                      activeColor: MyMateThemes.primaryColor, // Change color if needed
                    ),
                    Text('Non- Vegetarian'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                SizedBox(width: 45),
                Text(
                  'Alcohol',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),
            _buildAlcoholSelection(),
            SizedBox(height: 45),
            Row(
              children: [
                SizedBox(width: 45),
                Text(
                  'Smoking',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            _buildSmokingSelection(),
            SizedBox(height: 45),
            Row(
              children: [
                SizedBox(width: 45),
                Text(
                  'Cooking',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 35),
                SvgPicture.asset('assets/images/Line 11.svg'),
              ],
            ),
            SizedBox(height: 30),
            _buildCookingSelection(),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      hobbyTags.clear();
                      favoritesTags.clear();
                      sportsTags.clear();
                      hobbyController.clear();
                      favoritesController.clear();
                      sportsController.clear();
                      selectedAlcoholIndex = -1;
                      selectedCookingIndex = -1;
                      selectedSmokingIndex = -1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyMateThemes.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Clear All',
                    style: TextStyle(color: Colors.black, letterSpacing: 1.5),
                  ),
                ),
                SizedBox(width: 26),
                ElevatedButton(
                  onPressed: () {
                    // Store the selected values
                    _storeSelectedValues();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyMateThemes.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Complete',
                    style: TextStyle(color: Colors.white, letterSpacing: 1.5),
                  ),
                ),
              ],
            ),
            SizedBox(height: 68),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      VoidCallback onSubmitted) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: MyMateThemes.containerColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: 330,
          height: 37, // Increased height to accommodate TextField
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintStyle:TextStyle(color: MyMateThemes.textColor.withOpacity(0.5)),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(9.0),
                // Adjust padding as needed
                hintText: hintText,

              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  onSubmitted();
                }
              },
              onChanged: (value) {
                setState(() {}); // Rebuild to show suggestion tag
              },
            ),
          ),
        ),
        if (controller.text.isNotEmpty)
          GestureDetector(
            onTap: onSubmitted,
            child: Container(
              // width: 350,
              // height: 50,

              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: MyMateThemes.secondaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text('+ Add "${controller.text}"'),
              // child: Row(
              //   children: [
              //     Text(
              //       '+ Add',
              //       style: TextStyle(color: MyMateThemes.primaryColor),
              //     ),
              //     Text(
              //       '"${controller.text}"',
              //       style: TextStyle(color: MyMateThemes.textColor),
              //     ),
              //   ],
              // ),
            ),
          ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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

  Widget _buildAlcoholSelection() {
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
                    SizedBox(height: 13),
                    Text(
                      'Never',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 0
                            ? Colors.black
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Had',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 0
                            ? Colors.black
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
                    SizedBox(height: 13),
                    Text(
                      'Rarely',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 1
                            ? Colors.black
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 1
                            ? Colors.black
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
                    SizedBox(height: 13),
                    Text(
                      'Occasionally',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 2
                            ? Colors.black
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 2
                            ? Colors.black
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
                    SizedBox(height: 13),
                    Text(
                      'Regularly',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 3
                            ? Colors.black
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 3
                            ? Colors.black
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
                    SizedBox(height: 13),
                    Text(
                      'Swimming',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 4
                            ? Colors.black
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'in it (24/7)',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 4
                            ? Colors.black
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

  Widget _buildSmokingSelection() {
    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 24),
          painter: _SmokingLinePainter(selectedSmokingIndex: selectedSmokingIndex),
        ),
        Row(
          children: [
            SizedBox(width: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSmokingIndex = 0;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedSmokingIndex >= 0),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      'Never',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 0
                            ? Colors.black
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Had',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 0
                            ? Colors.black
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
                    selectedSmokingIndex = 1;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedSmokingIndex >= 1),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      'Rarely',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 1
                            ? Colors.black
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 1
                            ? Colors.black
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
                    selectedSmokingIndex = 2;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedSmokingIndex >= 2),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      'Occasionally',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 2
                            ? Colors.black
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 2
                            ? Colors.black
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
                    selectedSmokingIndex = 3;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedSmokingIndex >= 3),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      'Regularly',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 3
                            ? Colors.black
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 3
                            ? Colors.black
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
                    selectedSmokingIndex = 4;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedSmokingIndex >= 4),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      'Chain',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 4
                            ? Colors.black
                            : Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 4
                            ? Colors.black
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

  Widget _buildCookingSelection() {
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
                    SizedBox(height: 13),
                    Text(
                      'Zero',
                      style: TextStyle(
                        color: selectedCookingIndex == 0
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
                    SizedBox(height: 13),
                    Text(
                      'Novice',
                      style: TextStyle(
                        color: selectedCookingIndex == 1
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
                    SizedBox(height: 13),
                    Text(
                      'Basic',
                      style: TextStyle(
                        color: selectedCookingIndex == 2
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
                    SizedBox(height: 13),
                    Text(
                      'Intermediate',
                      style: TextStyle(
                        color: selectedCookingIndex == 3
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
                    SizedBox(height: 13),
                    Text(
                      'Advanced',
                      style: TextStyle(
                        color: selectedCookingIndex == 4
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
      ..color =
          isActive ? MyMateThemes.primaryColor : Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
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

class _SmokingLinePainter extends CustomPainter {
  final int selectedSmokingIndex;


  _SmokingLinePainter({required this.selectedSmokingIndex,});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyMateThemes.primaryColor
      ..strokeWidth = 4;

    final double segmentWidth = size.width / 5;

    // Draw lines between circles
    for (int i = 0; i < 4; i++) {
      if (i < selectedSmokingIndex) {
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
