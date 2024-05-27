import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'bottom_navigation_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  bool _isSmall = false;

  void _toggleSize() {
    setState(() {
      _isSmall = !_isSmall;
    });
  }

  int _selectedIndex = 0;
  int _selectedButtonIndex = 0; // Track selected outline button index
  ScrollController _scrollController = ScrollController();
  bool isSecondContainerVisible = true;
  bool isThirdContainerVisible = true;
  bool isFourthContainerVisible = true;

  bool isButtonSelected(int index) {
    return _selectedButtonIndex == index;
  }

  // Badge values for the SVG images
  int badgeValue1 = 1;
  int badgeValue2 = 10;

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return text.substring(0, maxLength) + '...';
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // When scrolling the outline button section
  void _scrollListener() {
    double containerHeight = 500.0; // Height of each container
    int newIndex = (_scrollController.offset / containerHeight).floor();
    if (newIndex != _selectedButtonIndex) {
      setState(() {
        _selectedButtonIndex = newIndex;
      });
    }
  }

  void _scrollAnimator() {
    double offset = _scrollController.offset;
    double scrollThreshold = 500.0; // Adjust this threshold as needed
    bool isScrollUp = offset > scrollThreshold;
    // Perform your animation logic here
    if (isScrollUp) {
      // Perform animation to decrease size and move left
      // For example, using AnimatedContainer and SlideTransition
      setState(() {
        isSecondContainerVisible = false;
        isThirdContainerVisible = false;
        isFourthContainerVisible = false;
      });
    } else {
      // Reset animation to original state
      setState(() {
        isSecondContainerVisible = true;
        isThirdContainerVisible = true;
        isFourthContainerVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundWhite,
      appBar: AppBar(
        backgroundColor: MyMateThemes.backgroundWhite,
        title: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    '@user240676',
                    style: TextStyle(
                      color: MyMateThemes.textGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Group 2157.svg',
                        // width: 30,
                        // height: 30,
                      ),
                      if (badgeValue1 > 0) ...[
                        Positioned(
                          top: -2,
                          right: -1,
                          child: Container(
                            //padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: MyMateThemes.secondaryGreen,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              badgeValue1.toString(),
                              style: TextStyle(
                                color: MyMateThemes.primaryGreen,
                                fontSize: badgeValue1 > 9 ? 12 : 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(width: 10),
                  Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Group 2153.svg',
                        // width: 30,
                        // height: 30,
                      ),
                      if (badgeValue2 > 0) ...[
                        Positioned(
                          top: -2,
                          right: -1,
                          child: Container(
                            //padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: MyMateThemes.secondaryGreen,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              badgeValue2.toString(),
                              style: TextStyle(
                                color: MyMateThemes.primaryGreen,
                                fontSize: badgeValue2 > 9 ? 12 : 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Column(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: _toggleSize,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            // width: _isSmall ? 100 : 200,
                            height: _isSmall ? 50 : 230,
                            alignment: _isSmall
                                ? Alignment(-1.2, 1.0)
                                : Alignment.center,
                            child: SvgPicture.asset(
                              'assets/images/Group 2073 (1).svg',
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: _toggleSize,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            // width: _isSmall ? 100 : 200,
                            //height: _isSmall ? 50 : 230,
                            alignment: _isSmall
                                ? Alignment(0.1, 0.0)
                                : Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Full Name',
                                  style: TextStyle(
                                    color: MyMateThemes.primaryGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Special Mention (Optional)',
                                  style: TextStyle(
                                    color: MyMateThemes.textGreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    //  ],
                  ),

                  // SizedBox(height: 5),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 72,
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: SvgPicture.asset(
                                'assets/images/Group 2145.svg',
                              ),
                            ),
                            SizedBox(height: 5),
                            const Text(
                              '27 Years',
                              style: TextStyle(
                                color: MyMateThemes
                                    .textGreen, // Use your desired text color
                                fontSize: 12, // Adjust font size as needed
                                fontWeight: FontWeight
                                    .normal, // Adjust font weight as needed
                              ),
                            ),
                            const Text(
                              '12 Dec 1997',
                              style: TextStyle(
                                color: MyMateThemes.primaryGreen,
                                // Use your desired text color
                                fontSize: 10,
                                // Adjust font size as needed
                                fontWeight: FontWeight
                                    .normal, // Adjust font weight as needed
                              ),
                            ),
                          ],
                        ),
                        foregroundDecoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: MyMateThemes.secondaryGreen,
                                    width: 2))),
                      ),
                      Container(
                        width: 120,
                        height: 72,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: SvgPicture.asset(
                                'assets/images/Group 2146.svg',
                                //color: MyMateThemes
                                //  .primaryGreen, // Use the desired color for the icon
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Teacher',
                              style: TextStyle(
                                color: MyMateThemes
                                    .textGreen, // Use your desired text color
                                fontSize: 12, // Adjust font size as needed
                                fontWeight: FontWeight
                                    .normal, // Adjust font weight as needed
                              ),
                            ),
                            Text(
                              'Mannar - SL',
                              style: TextStyle(
                                color: MyMateThemes.primaryGreen,
                                // Use your desired text color
                                fontSize: 10,
                                // Adjust font size as needed
                                fontWeight: FontWeight
                                    .normal, // Adjust font weight as needed
                              ),
                            ),
                          ],
                        ),
                        foregroundDecoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: MyMateThemes.secondaryGreen,
                                    width: 2))),
                      ),
                      // const VerticalDivider(
                      //   width: 60,
                      //   thickness: 2,
                      //   indent: 10,
                      //   endIndent: 100,
                      //   color: Color(0x00D9D9D9),
                      // ),
                      Container(
                        width: 120,
                        height: 72,
                        child: Column(
                          children: [
                            Container(
                              child: SvgPicture.asset(
                                'assets/images/Group 2147.svg',
                                //color: MyMateThemes
                                //  .primaryGreen, // Use the desired color for the icon
                              ),
                            ),
                            SizedBox(height: 5),
                            const Text(
                              'Jaffna',
                              style: TextStyle(
                                color: MyMateThemes
                                    .textGreen, // Use your desired text color
                                fontSize: 12, // Adjust font size as needed
                                fontWeight: FontWeight
                                    .normal, // Adjust font weight as needed
                              ),
                            ),
                            const Text(
                              'Sri Lanka',
                              style: TextStyle(
                                color: MyMateThemes.primaryGreen,
                                // Use your desired text color
                                fontSize: 10,
                                // Adjust font size as needed
                                fontWeight: FontWeight
                                    .normal, // Adjust font weight as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("hello");
                        },
                        child: SvgPicture.asset(
                          'assets/images/EditButton.svg',
                        ),
                      ),
                    ],
                  ),
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
                              'assets/images/Group 2196.svg',
                            ),
                            onTap: () {
                              setState(() {
                                _selectedButtonIndex = 1;
                                isSecondContainerVisible = true;
                                isThirdContainerVisible = true;
                                isFourthContainerVisible = true;
                              });
                              _scrollToContainer(2);
                            },
                          ),
                          SizedBox(width: 30),
                          Column(
                            children: [
                              GestureDetector(
                                child: SvgPicture.asset(
                                  'assets/images/Group 2192.svg',
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedButtonIndex = 1;
                                    isSecondContainerVisible = true;
                                    isThirdContainerVisible = true;
                                    isFourthContainerVisible = true;
                                  });
                                  _scrollToContainer(2);
                                },
                              ),
                              SizedBox(height: 16),
                              GestureDetector(
                                child: SvgPicture.asset(
                                  'assets/images/Group 2197.svg',
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedButtonIndex = 1;
                                    isSecondContainerVisible = true;
                                    isThirdContainerVisible = true;
                                    isFourthContainerVisible = true;
                                  });
                                  _scrollToContainer(4);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 40),
                      SvgPicture.asset(
                        'assets/images/Group 2148.svg',
                      ),
                      SizedBox(width: 4),
                      Text("Astrology"),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(width: 40),
                      SvgPicture.asset(
                        'assets/images/Line 11.svg',
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: isSecondContainerVisible,
                        child: SizedBox(height: 15),
                      ),
                      Visibility(
                        visible: isSecondContainerVisible,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 340,
                              height: 500,
                              color: MyMateThemes.secondaryGreen,
                              child: Center(
                                child: Text(
                                  'Container 2',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: MyMateThemes.textGreen,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: isThirdContainerVisible,
                        child: SizedBox(height: 15),
                      ),
                      Visibility(
                        visible: isThirdContainerVisible,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 340,
                              height: 500,
                              color: MyMateThemes.secondaryGreen,
                              child: Center(
                                child: Text(
                                  'Container 3',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: MyMateThemes.textGreen,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: isFourthContainerVisible,
                        child: SizedBox(height: 15),
                      ),
                      Visibility(
                        visible: isFourthContainerVisible,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 340,
                              height: 500,
                              color: MyMateThemes.secondaryGreen,
                              child: Center(
                                child: Text(
                                  'Container 4',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: MyMateThemes.textGreen,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 0;
                      isSecondContainerVisible = true;
                      isThirdContainerVisible = true;
                      isFourthContainerVisible = true;
                    });
                    _scrollToContainer(
                        1); // Scroll to the starting position of Container 2
                  },
                  style: ButtonStyle(
                    // Use the isButtonSelected function to determine button color
                    foregroundColor: MaterialStateProperty.all(
                      isButtonSelected(0)
                          ? MyMateThemes.secondaryGreen
                          : MyMateThemes.containerViolet,
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      isButtonSelected(0)
                          ? MyMateThemes.secondaryGreen
                          : MyMateThemes.containerViolet,
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                    side: MaterialStateProperty.all(BorderSide.none),
                    minimumSize: MaterialStateProperty.all(Size(103.31, 40)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Group 2148.svg',
                        width: 18.29, // Adjust the width as needed
                        height: 18.29, // Adjust the height as needed
                        // color: MyMateThemes
                        //     .primaryGreen, // Use the desired color for the icon
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Astrology',
                        style: TextStyle(
                          color: MyMateThemes.primaryGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 1;
                      isSecondContainerVisible = true;
                      isThirdContainerVisible = true;
                      isFourthContainerVisible = true;
                    });
                    _scrollToContainer(2);
                  },
                  style: ButtonStyle(
                    // Use the isButtonSelected function to determine button color
                    foregroundColor: MaterialStateProperty.all(
                      isButtonSelected(1)
                          ? MyMateThemes.secondaryGreen
                          : MyMateThemes.containerViolet,
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      isButtonSelected(1)
                          ? MyMateThemes.secondaryGreen
                          : MyMateThemes.containerViolet,
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                    side: MaterialStateProperty.all(BorderSide.none),
                    minimumSize: MaterialStateProperty.all(Size(103.31, 40)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Group 2149.svg',
                        // Replace this with your SVG icon path
                        width: 18.29, // Adjust the width as needed
                        height: 18.29, // Adjust the height as needed
                        // color: MyMateThemes
                        //     .primaryGreen, // Use the desired color for the icon
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Family',
                        style: TextStyle(
                          color: MyMateThemes.primaryGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 2;
                      isSecondContainerVisible = true;
                      isThirdContainerVisible = true;
                      isFourthContainerVisible = true;
                    });
                    _scrollToContainer(3);
                  },
                  style: ButtonStyle(
                    // Use the isButtonSelected function to determine button color
                    foregroundColor: MaterialStateProperty.all(
                      isButtonSelected(2)
                          ? MyMateThemes.secondaryGreen
                          : MyMateThemes.containerViolet,
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      isButtonSelected(2)
                          ? MyMateThemes.secondaryGreen
                          : MyMateThemes.containerViolet,
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                    side: MaterialStateProperty.all(BorderSide.none),
                    minimumSize: MaterialStateProperty.all(Size(103.31, 40)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Group 2150.svg',
                        // Replace this with your SVG icon path
                        width: 18.29, // Adjust the width as needed
                        height: 18.29, // Adjust the height as needed
                        // color: MyMateThemes
                        //     .primaryGreen, // Use the desired color for the icon
                      ),
                      SizedBox(width: 4),
                      Text(
                        'About Me',
                        style: TextStyle(
                          color: MyMateThemes.primaryGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        // ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Handle navigation here based on the index
        },
      ),
    );
  }

  void _scrollToContainer(int index) {
    double containerHeight =
        500.0; // Assuming all containers have the same height
    double targetPosition = index * containerHeight - containerHeight / 2;
    _scrollController.animateTo(
      targetPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
