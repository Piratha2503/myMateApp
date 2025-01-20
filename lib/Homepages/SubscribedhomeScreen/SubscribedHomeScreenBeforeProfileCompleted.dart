
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../ManagePages/SummaryPage.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../MyMateThemes.dart';
import '../BadgeWidget.dart';
import '../CompleteProfileScreen/CompleteProfileMain.dart';

class SubscribedHomeScreenBeforeProfileCompletedPage extends StatefulWidget {
  final String docId;
  const SubscribedHomeScreenBeforeProfileCompletedPage({super.key,required this.docId});

  @override
  State<SubscribedHomeScreenBeforeProfileCompletedPage> createState() =>
      _SubscribedHomeScreenBeforeProfileCompletedPageState();
}

class _SubscribedHomeScreenBeforeProfileCompletedPageState extends State<SubscribedHomeScreenBeforeProfileCompletedPage> {
  int _selectedIndex = 0;


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

  Widget _buildFooterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 22),
        SizedBox(
          height: 50, //height of button
          width: 165, //width of button
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompleteProfilePage(docId: widget.docId)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyMateThemes.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              // padding: EdgeInsets.all(10)
            ),
            child: Text(
              'Complete Profile ',
              style: TextStyle(color:Colors.white),
            ),
          ),
        ),
        SizedBox(width: 20),
        SizedBox(
          height: 50, //height of button
          width: 164, //width of button
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompleteProfilePage(docId: widget.docId,)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyMateThemes.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            child: Text('New Match', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    print(widget.docId);

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
                                      .premiumAccent,
                                  width: 5.0,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(profile.imageUrl),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom:
                                        4.0),
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
                                        4.0),
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
                                        4.0),
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
                                        4.0),
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
          _buildFooterRow(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
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
