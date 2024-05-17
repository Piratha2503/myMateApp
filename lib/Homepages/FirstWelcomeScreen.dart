import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bottom_navigation_bar.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool showHello = true;
  int _selectedIndex = 0;

  // Badge values for the SVG images
  int badgeValue1 = 0;
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
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showHello = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0), // here the desired height
        child: AppBar(
          backgroundColor: MyMateThemes.backgroundWhite,
          title: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // SizedBox(
                    //   width: 70,
                    // ),
                    AnimatedOpacity(
                      opacity: showHello ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 5000),
                      child: Text(
                        'Hello',
                        style: TextStyle(
                          color: MyMateThemes.primaryGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Add spacing between "Hello" and "Your Name"
                    SizedBox(
                        width:
                            10), // Add spacing between "Hello" and "Your Name"

                    SizedBox(width: 70),
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
                    SizedBox(width: 25),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Congratulations',
                style: TextStyle(
                  color: MyMateThemes.primaryGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Center(
              child: Text(
                "You're successfully registered",
                style: TextStyle(
                  color: MyMateThemes.textGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Center(
              child: SvgPicture.asset(
                'assets/images/Group 2073.svg',
                // Replace this with your SVG icon path
                width: 230, // Adjust the width as needed
                height: 195, // Adjust the height as needed
                //color: MyMateThemes
                //  .primaryGreen, // Use the desired color for the icon
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'View Matches',
                style: TextStyle(
                  color: MyMateThemes.primaryGreen,
                  fontSize: MyMateThemes.subHeadFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // SizedBox(
                //   width: 20,
                // ),
                Text(
                  'Free',
                  style: TextStyle(
                    color: MyMateThemes.textGreen,
                    fontSize: MyMateThemes.nomalFontSize,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                // SizedBox(
                //   width: 10,
                // ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Layer 1.svg',
                        // Replace this with your SVG icon path
                        width: 18.29, // Adjust the width as needed
                        height: 18.29, // Adjust the height as needed
                        // color: MyMateThemes
                        //     .primaryGreen, // Use the desired color for the icon
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Premium',
                        style: TextStyle(
                          color: MyMateThemes.primaryGreen,
                          fontSize: MyMateThemes.nomalFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 164,
                  height: 188,
                  color: MyMateThemes.containerViolet,
                  alignment: Alignment.bottomLeft,
                ),
                Container(
                  width: 164,
                  height: 188,
                  color: MyMateThemes.secondaryGreen,
                  alignment: Alignment.bottomRight,
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    // Handle link tap action
                    print('Link tapped');
                  },
                  child: Text(
                    'Complete Profile',
                    style: TextStyle(
                      color: MyMateThemes.primaryGreen,
                      fontSize: MyMateThemes.nomalFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 164.0,
                  height: 58.0,
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle button press action
                      print('Button pressed');
                    },
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                      backgroundColor:
                          MaterialStatePropertyAll(MyMateThemes.primaryGreen),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                    ),
                    // OutlinedButton.styleFrom(
                    //     backgroundColor: MyMateThemes.primaryGreen,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(
                    //           10), // Adjust the border radius as needed
                    //     ),
                    //     alignment: Alignment.center),
                    child: Text(
                      'Get Started ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MyMateThemes.buttonFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
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
}
