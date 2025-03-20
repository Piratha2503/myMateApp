import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../ProfilePageScreen/MyProfileMain.dart';

class MoreAboutMePage extends StatefulWidget {
  final String docId;

  const MoreAboutMePage({super.key,required this.docId});

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

  String _selectedValue = '';


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


  void _StoreSelectedValues() async {

    final Map<String, dynamic> requestData = {
      'docId':widget.docId,
      'lifestyle' : {
        'eating_habit': _selectedValue,

        'alcoholIntake': _getAlcoholString(selectedAlcoholIndex),

        'smoking': _getSmokingString(selectedSmokingIndex),

        'cooking': _getCookingString(selectedCookingIndex),

         'personal_interest': hobbyTags,
      }
    };

    try {
      final response = await http.put(
        Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/updateClient'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Data successfully sent: ${response.body}');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfilePage(
            docId: widget.docId,
            selectedBottomBarIconIndex: 0,
          ),
        ));
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  String _getAlcoholString(int index) {
    switch (index) {
      case 0:
        return 'Never Had';
      case 1:
        return 'Rarely Drinker';
      case 2:
        return 'Occasionally Drinker';
      case 3:
        return 'Regularly Drinker';
      case 4:
        return 'Swimming in it (24/7)';
      default:
        return 'Unknown';
    }
  }

  String _getSmokingString(int index) {
    switch (index) {
      case 0:
        return 'Never Had';
      case 1:
        return 'Rarely Smoker';
      case 2:
        return 'Occasionally Smoker';
      case 3:
        return 'Regularly Smoker';
      case 4:
        return 'Chain smoker';
      default:
        return 'Unknown';
    }
  }

  String _getCookingString(int index) {
    switch (index) {
      case 0:
        return 'Zero';
      case 1:
        return 'Novice';
      case 2:
        return 'Basic';
      case 3:
        return 'Intermediate';
      case 4:
        return 'Advanced';
      default:
        return 'Unknown';
    }
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
      body: LayoutBuilder(
          builder: (context, constraints) {
            // Read width and height from constraints to use for responsive sizing.
            final double screenWidth = MediaQuery.of(context).size.width;
            final double screenHeight = MediaQuery.of(context).size.height;

            return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'More About Me',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.1),
                    Text(
                      'Personal Interest',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.06),
                    SvgPicture.asset('assets/images/Line 11.svg',width: screenWidth*0.88,),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                _buildTextField(hobbyController, '-- Type here --', _addHobbyTag),
                SizedBox(height: screenHeight * 0.03),
                Wrap(
                  children: hobbyTags.map((tag) => _buildTag(tag)).toList(),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.1),

                    Text(
                      'Life Style',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.06),
                    SvgPicture.asset('assets/images/Line 11.svg',width: screenWidth*0.88,),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    SizedBox(width: screenWidth*0.08),
                    Text(
                      'Eating Habits',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(width: screenWidth * 0.07),

                        Theme(
                          data: ThemeData(
                            radioTheme: RadioThemeData(
                              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return MyMateThemes.primaryColor; // Change selected color
                                }
                                return MyMateThemes.secondaryColor; // Unselected color
                              }),
                              visualDensity: VisualDensity.compact, // Reduce spacing
                            ),
                          ),
                          child:
                          Transform.scale(
                            scale: screenWidth*0.0033, // Adjust size (increase value to make it bigger)
                            child: Radio<String>(
                              value: 'Vegetarian',
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value!;
                                });
                              },
                              activeColor: MyMateThemes.primaryColor, // Border color when selected
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Prevent extra padding
                            ),
                          ),                        ),

                        Text('Vegetarian',style: TextStyle(color: MyMateThemes.textColor,fontWeight: FontWeight.normal,fontSize: screenWidth*0.03),),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.138),
                    Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            radioTheme: RadioThemeData(
                              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return MyMateThemes.primaryColor; // Change selected color
                                }
                                return MyMateThemes.secondaryColor; // Unselected color
                              }),
                              visualDensity: VisualDensity.compact, // Reduce spacing
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                            ),
                          ),
                          child: Transform.scale(
                            scale: screenWidth*0.0033,
                            child: Radio<String>(
                              value: 'Non- Vegetarian',
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value!;
                                });
                              },
                              activeColor: MyMateThemes.primaryColor, // Change color if needed
                            ),
                          ),
                        ),
                        Text('Non- Vegetarian',style: TextStyle(color: MyMateThemes.textColor,fontWeight: FontWeight.normal,fontSize: screenWidth*0.03),),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight*0.03),
                Row(
                  children: [
                    SizedBox(width: screenWidth*0.1),
                    Text(
                      'Alcohol',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: screenWidth*0.035,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight*0.02),
                _buildAlcoholSelection(),
                SizedBox(height: screenHeight * 0.05),
                Row(
                  children: [
                    SizedBox(width: screenWidth*0.1),
                    Text(
                      'Smoking',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: screenWidth*0.035,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                _buildSmokingSelection(),
                SizedBox(height: screenHeight * 0.05),
                Row(
                  children: [
                    SizedBox(width: screenWidth*0.1),
                    Text(
                      'Cooking',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.06),
                    SvgPicture.asset('assets/images/Line 11.svg',width: screenWidth*0.88,),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                _buildCookingSelection(),
                SizedBox(height: screenHeight * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(
                      height: screenHeight*0.07,
                      width: screenWidth*0.35,
                      child: ElevatedButton(
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
                        style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
                          backgroundColor: MaterialStatePropertyAll(MyMateThemes.secondaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(screenWidth*0.01)
                              )),

                        ),
                        child: Text(
                          'Clear All',
                          style: TextStyle(color:MyMateThemes.textColor, letterSpacing: 1.5,fontSize: screenWidth*0.04),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth*0.05),
                    SizedBox(
                      height: screenHeight*0.07,
                      width: screenWidth*0.35,
                      child: ElevatedButton(
                        onPressed: () {
                          // Store the selected values
                          _StoreSelectedValues();
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(Colors.white),
                          backgroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(screenWidth*0.01)
                              )),

                        ),
                        child: Text(
                          'Complete',
                          style: TextStyle(color: Colors.white, letterSpacing: 1.5,fontSize: screenWidth*0.04),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.08),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      VoidCallback onSubmitted) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight = MediaQuery.of(context).size.height * 0.055;
    double fontSize = MediaQuery.of(context).size.width * 0.04;

    return Column(
      children: [
        Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: MyMateThemes.textColor.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(containerWidth * 0.03), // Dynamic border radius
          ),
        // Increased height to accommodate TextField
          child: Padding(
            padding:  EdgeInsets.only(left: containerWidth*0.02),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintStyle:TextStyle(color: MyMateThemes.textColor,fontSize: containerWidth*0.035,fontWeight: FontWeight.w300),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(containerWidth*0.045),
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
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight = MediaQuery.of(context).size.height * 0.055;
    double fontSize = MediaQuery.of(context).size.width * 0.04;

    return Container(
      margin: EdgeInsets.symmetric(horizontal:containerWidth*0.01, vertical: containerHeight*0.01),
      padding: EdgeInsets.symmetric(horizontal: containerWidth*0.04, vertical: containerHeight*0.25),
      decoration: BoxDecoration(
        color: MyMateThemes.primaryColor,
        borderRadius: BorderRadius.circular(containerWidth*0.02),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: containerWidth*0.045,
        ),
      ),
    );
  }

  Widget _buildAlcoholSelection() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 24),
          painter: _LinePainter(selectedAlcoholIndex: selectedAlcoholIndex),
        ),
        Row(
          children: [
            SizedBox(width: screenWidth*0.02),
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Never',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 0
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                        fontSize: screenWidth*0.026,
                        fontWeight: FontWeight.w300

                      ),
                    ),
                    Text(
                      'Had',
                      style: TextStyle(
                          color: selectedAlcoholIndex >= 0
                              ? MyMateThemes.textColor
                              : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300

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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Rarely',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 1
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 1
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Occasionally',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 2
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 2
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Regularly',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 3
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 3
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Swimming',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 4
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      'in it (24/7)',
                      style: TextStyle(
                        color: selectedAlcoholIndex >= 4
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 24),
          painter: _SmokingLinePainter(selectedSmokingIndex: selectedSmokingIndex),
        ),
        Row(
          children: [
            SizedBox(width: screenWidth*0.02),
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Never',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 0
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      'Had',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 0
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Rarely',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 1
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 1
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Occasionally',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 2
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 2
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Regularly',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 3
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 3
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Chain',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 4
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 4
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 24),
          painter: _LinearPainter(selectedCookingIndex: selectedCookingIndex),
        ),
        Row(
          children: [
            SizedBox(width: screenWidth*0.02),
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Zero',
                      style: TextStyle(
                        color: selectedCookingIndex >= 0
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Novice',
                      style: TextStyle(
                        color: selectedCookingIndex >= 1
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Basic',
                      style: TextStyle(
                        color: selectedCookingIndex >= 2
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Intermediate',
                      style: TextStyle(
                        color: selectedCookingIndex >= 3
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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
                        width: screenWidth*0.06,
                        height: screenHeight*0.03,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.015),
                    Text(
                      'Advanced',
                      style: TextStyle(
                        color: selectedCookingIndex >= 4
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                          fontSize: screenWidth*0.026,
                          fontWeight: FontWeight.w300
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