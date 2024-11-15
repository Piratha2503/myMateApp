import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymateapp/Homepages/MoreAboutMe.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/photoGalleryPage.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/profileInfo.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../dbConnection/Firebase.dart';
import '../EditPage.dart';
import '../custom_outline_button.dart';
import 'MyProfileWidgets.dart';
import 'aboutMePage.dart';
import 'astrologyPage.dart';


class ProfilePage extends StatefulWidget {
  final String docId;

  const ProfilePage({required this.docId, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  String full_name = "";
  String gender = "";
  String education = "";
  String district = "";
  String occupation = "";
  String mobile = "";
  String religion = "";
  String age = "";
  String dob = "";

  final Firebase firebase = Firebase();
 late List<double> _positions; // List to store the start positions of sub-pages
  int _selectedButtonIndex = 0;

  bool isButtonSelected(int index) => _selectedButtonIndex == index;

  Future<void> getClient() async {
    DocumentSnapshot client = await firebase.clients.doc(widget.docId).get();

    setState(() {
      full_name = client['full_name'] ?? "N/A";
      gender = client['gender'] ?? "N/A";
      education = client['education'] ?? "N/A";
      district = client['district'] ?? "N/A";
      occupation = client['occupation'] ?? "N/A";
      mobile = client['mobile'].toString() ?? "N/A";
      religion = client['religion'] ?? "N/A";
      age = client['age'].toString() ?? "N/A";
      dob = client['dob'] ?? "N/A";
    });
  }

  bool _isSmall = false;
  int _selectedIndex = 0;

  final ScrollController _scrollController = ScrollController();
  int selectedAlcoholIndex = 0;
  int selectedCookingIndex = 0;

  @override
  void initState() {
    super.initState();
    getClient().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calculatePositions();
      });
    });
  }



  void _calculatePositions() {
    _positions = [
      0.0, // Starting position for the first section
      MediaQuery.of(context).size.height, // Second section start
      MediaQuery.of(context).size.height * 2, // Third section start
    ];
  }



  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleSize() {
    setState(() {
      _isSmall = !_isSmall;
    });
  }

  void _scrollListener() {
    double containerHeight = 1000.0;
    int newIndex = (_scrollController.offset / containerHeight).floor();
    if (newIndex != _selectedButtonIndex) {
      setState(() {
        _selectedButtonIndex = newIndex;
      });
    }
  }

  void _scrollToContainer(int index) {
    double containerHeight =MediaQuery.of(context).size.height;
    double targetPosition = index * containerHeight - containerHeight/3.75;
    _scrollController.animateTo(
      targetPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  ProfileInfo(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconWithText(
                          'assets/images/Group 2145.svg', '$age years', dob),
                      IconWithText('assets/images/Group 2146.svg',
                          occupation, '$district - '),
                      IconWithText('assets/images/Group 2147.svg',
                          district, 'Sri Lanka'),
                    ],
                  ),
                  SizedBox(height: 30),
                  ActionButtons(),
                  SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: SvgPicture.asset(
                                'assets/images/Group 2196.svg'),
                            onTap: () {
                              setState(() {
                                _selectedButtonIndex = 0;
                              });
                             _scrollToContainer(1);
                            },
                          ),
                          SizedBox(width: 30),
                          Column(
                            children: [
                              GestureDetector(
                                child: SvgPicture.asset(
                                    'assets/images/Group 2192.svg'),
                                onTap: () {
                                  setState(() {
                                    _selectedButtonIndex = 1;
                                  });
                                  _scrollToContainer(2);
                                },
                              ),
                              SizedBox(height: 16),
                              GestureDetector(
                                child: SvgPicture.asset(
                                    'assets/images/Group 2197.svg'),
                                onTap: () {
                                  setState(() {
                                    _selectedButtonIndex = 2;
                                  });
                                  _scrollToContainer(3);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  AstrologySection(),
                  Containers(
                    children:[
                      AboutMe(),
                      SizedBox(height: 48),
                      PhotoGallery(),
                      AdditionalInfo(),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomOutlineButton(
                  assetPath: 'assets/images/Group 2148.svg',
                  label: 'Astrology',
                  index: 0,
                  isSelected: isButtonSelected(0),
                  onPressed: () {

                    setState(() {
                      _selectedButtonIndex = 0;
                    });
                    _scrollToContainer(1);
                  },
                ),
                SizedBox(width: 10),
                CustomOutlineButton(
                  assetPath: 'assets/images/Group 2150.svg',
                  label: 'About me',
                  index: 1,
                  isSelected: isButtonSelected(1),
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 1;
                    });
                    _scrollToContainer(2);
                  },
                ),
                SizedBox(width: 10),
                CustomOutlineButton(
                  assetPath: 'assets/images/Group 2149.svg',
                  label: 'Photo Gallery',
                  index: 2,
                  isSelected: isButtonSelected(2),
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 2;
                    });
                    _scrollToContainer(3);
                  },
                ),
                // Add other buttons similarly
              ],
            ),
          ),

        ],
      ),
      bottomNavigationBar: NavigationBar(),
    );
  }




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

  Widget ActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: MyMateThemes.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('Boost '),
        ),
        SizedBox(width: 60),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyMateThemes.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('Edit Profile'),
        ),
      ],
    );
  }

  Widget AdditionalInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          SectionTitle('More about me'),
          SizedBox(height: 5),
          Row(
            children: [
              SizedBox(width: 40),
              SvgPicture.asset('assets/images/Line 11.svg'),
            ],
          ),
          SizedBox(height: 13),
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
          AlcoholSelection(),
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
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MoreAboutMePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyMateThemes.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Edit',
                  style: TextStyle(color: Colors.white, letterSpacing: 1.5),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
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

  Widget NavigationBar() {
    return CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: (index) {
        setState(() {
          _selectedIndex = index;
        });
        // Handle navigation here based on the index
      },
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