import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../ManagePages/SummaryPage.dart';
import 'bottom_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SubscribedhomescreenPage extends StatefulWidget {
  const SubscribedhomescreenPage({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SafeArea(
                child: Center(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      _buildBadge('assets/images/Group 2157.svg', badgeValue1),
                      SizedBox(width: 20),
                      _buildBadge('assets/images/Group 2153.svg', badgeValue2),
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
                    MaterialPageRoute(builder: (context) => Summarypage()));
              },
              child: SvgPicture.asset(
                'assets/images/Group 2073.svg',
                height: 230,
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
                                          '${profile.status}',
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
                        '78',
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
                                builder: (context) => Summarypage()));
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
                      MaterialPageRoute(builder: (context) => Summarypage()));
                },
                child: SvgPicture.asset('assets/images/mymates.svg'),
              )
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: 340,
            height: 70,
            decoration: BoxDecoration(
              color: MyMateThemes.premiumAccent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text('Advertisements'),
            ),
          ),
        ],
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

Widget _buildBadge(String assetPath, int badgeValue) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      SvgPicture.asset(assetPath),
      if (badgeValue > 0)
        Positioned(
          top: -15, // Adjust the top position as needed
          right: -10, // Adjust the right position as needed
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: MyMateThemes.secondaryColor,
              borderRadius: BorderRadius.circular(4), // More rounded corners
            ),
            child: Text(
              badgeValue.toString(),
              style: TextStyle(
                color: MyMateThemes.primaryColor,
                fontSize: badgeValue > 9 ? 12 : 16,
              ),
            ),
          ),
        ),
    ],
  );
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
