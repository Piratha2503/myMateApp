import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../ManagePages/SummaryPage.dart';
import '../MyMateCommonBodies/MyMateBottomBar.dart';
import 'BadgeWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SubscribedhomescreenPage extends StatefulWidget {
  final String docId;
  const SubscribedhomescreenPage({super.key,required this.docId});

  @override
  State<SubscribedhomescreenPage> createState() =>
      _SubscribedhomescreenPageState();
}

class _SubscribedhomescreenPageState extends State<SubscribedhomescreenPage> {
  int _selectedIndex = 0;

  // Badge values for the SVG images
  int badgeValue1 = 2;
  int badgeValue2 = 10;

  final List<Profile> profiles = [
    Profile(
      name: 'Kumar',
      age: 26,
      status: 'Single',
      occupation: 'Engineer',
      district: 'Jaffna',
      imageUrl: 'https://via.placeholder.com/150',
      matchPercentage: '75 - 100%',
    ),
    Profile(
      name: 'Ravi',
      age: 28,
      status: 'Married',
      occupation: 'Doctor',
      district: 'Kokuvil',
      imageUrl: 'https://via.placeholder.com/150',
      matchPercentage: '75 - 100%',
    ),
    // Add more profiles as needed
  ];

  @override
  void initState() {
    super.initState();
    // Show the popup dialog when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPopupDialog();
    });
  }

  void _showPopupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.53, // Adjust the top position as needed
              left: MediaQuery.of(context).size.width *
                  0.005, // Adjust the left position as needed
              right: MediaQuery.of(context).size.width *
                  0.005, // Adjust the right position as needed
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  width: 350, // Set your desired width
                  height: 270, // Set your desired height
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "Congratulations! You have received ",
                            style: TextStyle(
                              color: MyMateThemes.textColor,
                              letterSpacing:
                                  1.2, // Adjust letter spacing as needed
                              wordSpacing: 1.1, // Adjust word spacing as needed
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '10 free ',
                            style: TextStyle(
                              color: MyMateThemes.primaryColor,
                              letterSpacing:
                                  1.2, // Adjust letter spacing as needed
                              wordSpacing: 1.1, // Adjust word spacing as needed
                            ),
                          ),
                          Text(
                            'Tokens. You can spend free',
                            style: TextStyle(
                              color: MyMateThemes.textColor,
                              letterSpacing:
                                  1.2, // Adjust letter spacing as needed
                              wordSpacing: 1.1, // Adjust word spacing as needed
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "tokens to access  Following",
                        style: TextStyle(
                          color: MyMateThemes.textColor,
                          letterSpacing: 1.2, // Adjust letter spacing as needed
                          wordSpacing: 1.1, // Adjust word spacing as needed
                        ),
                      ),
                      Text(
                        "features only",
                        style: TextStyle(
                          color: MyMateThemes.textColor,
                          letterSpacing: 1.2, // Adjust letter spacing as needed
                          wordSpacing: 1.1, // Adjust word spacing as needed
                        ),
                      ),
                      SizedBox(height: 20),
                      SvgPicture.asset('assets/images/Group 2216.svg'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        style: CommonButtonStyle.commonButtonStyle(),
                        child: Text('Continue'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SafeArea(
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        'Your Name',
                        style: TextStyle(
                          color: MyMateThemes.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 60),
                      BadgeWidget(
                          assetPath: 'assets/images/Group 2157.svg',
                          badgeValue: badgeValue1),
                      SizedBox(width: 25),
                      BadgeWidget(
                          assetPath: 'assets/images/Group 2153.svg',
                          badgeValue: badgeValue2),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Summarypage(docId: widget.docId,)));
              },
              child: Stack(
                children: [
                  SvgPicture.asset('assets/images/Frame.svg',
                      width: 300, height: 220),
                  Positioned(
                      top: 69,
                      right: 98,
                      child: Text(
                        '137',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w500),
                      )),
                  Positioned(
                      top: 118,
                      right: 69,
                      child: Text(
                        'Matches Found',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
          ),
          Center(
            child: Text(
              'View Matches',
              style: TextStyle(
                color: MyMateThemes.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 140.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: profiles.map((profile) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(children: [
                            SizedBox(width: 20),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: MyMateThemes
                                      .premiumAccent, // Set the border color
                                  width: 5.0, // Set the border width
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(profile.imageUrl),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              // alignment: Alignment.bottomRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom:
                                            4.0), // Add bottom padding for spacing
                                    child: Text(
                                      profile.name,
                                      style: TextStyle(
                                        color: MyMateThemes.textColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom:
                                            4.0), // Add bottom padding for spacing
                                    child: Row(
                                      children: [
                                        Text(
                                          ' ${profile.age}, ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: MyMateThemes.textColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          profile.status,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: MyMateThemes.textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom:
                                            4.0), // Add bottom padding for spacing
                                    child: Text(
                                      ' ${profile.occupation}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: MyMateThemes.textColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom:
                                            4.0), // Add bottom padding for spacing
                                    child: Text(
                                      ' ${profile.district}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: MyMateThemes.textColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 90,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: MyMateThemes.secondaryColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/heart .svg'),
                                        Text(
                                          ' ${profile.matchPercentage}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: MyMateThemes.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Container(
                    width: 202,
                    height: 127,
                    decoration: BoxDecoration(
                      color: MyMateThemes.secondaryColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  Positioned(
                      top: 75,
                      right: 140,
                      child: SvgPicture.asset('assets/images/tokens.svg')),
                  Positioned(
                      top: 10,
                      right: 16,
                      child: Text(
                        '10',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: MyMateThemes.textColor),
                      )),
                  Positioned(
                    top: 18,
                    right: 5,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Summarypage(docId: widget.docId,)));
                      },
                      child: Text(
                        '+Add Tokens',
                        style: TextStyle(
                          color: MyMateThemes.primaryColor,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Summarypage(docId: widget.docId,)));
                },
                child: SvgPicture.asset('assets/images/mymates.svg'),
              )
            ],
          ),
          SizedBox(height: 20),

        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Handle navigation here based on the index
        }, docId: widget.docId,
      ),
    );
  }
}

class Profile {
  final String name;
  final int age;
  final String status;
  final String occupation;
  final String district;
  final String imageUrl;
  final String matchPercentage;

  Profile({
    required this.name,
    required this.age,
    required this.status,
    required this.occupation,
    required this.district,
    required this.imageUrl,
    required this.matchPercentage,
  });
}
