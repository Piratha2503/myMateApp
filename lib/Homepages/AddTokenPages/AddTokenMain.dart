import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../../ManagePages/ManagePage.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import 'AddTokenWidgets.dart';


class AddTokenMainPage extends StatefulWidget {
  final String docId;
  const AddTokenMainPage({Key? key, required this.docId}) : super(key: key);

  @override
  State<AddTokenMainPage> createState() => _AddTokenMainPageState();
}

class _AddTokenMainPageState extends State<AddTokenMainPage> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {

        // Read width and height from constraints to use for responsive sizing.
        return LayoutBuilder(

            builder: (context, constraints) {
              final mediaQuery = MediaQuery.of(context);
              final width = mediaQuery.size.width;
              final height = mediaQuery.size.height;
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        // Header with back button and title
                        Padding(
                          padding: EdgeInsets.all(width * 0.04),
                          child: Row(
                            children: [
                              SizedBox(width: width * 0.02),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ManagePage(docId: widget.docId),
                                    ),
                                  );
                                },
                                child: SvgPicture.asset(
                                  'assets/images/chevron-left.svg',
                                  width: width * 0.025,
                                  height: height*0.015,

                                ),
                              ),
                              SizedBox(width: width * 0.25),
                              Text(
                                "Package Plan",
                                style: TextStyle(
                                  color: MyMateThemes.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: width * 0.045,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(width: width*0.2),
                              // Fire Icon and number
                              SvgPicture.asset('assets/images/fire.svg', width: width*0.04),
                              SizedBox(width: width*0.01),
                              Text(
                                '78',
                                style: TextStyle(color: MyMateThemes.textColor, fontSize: width*0.045),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.03),

                        // Package slider carousel
                        CarouselSlider(
                          items: packageSliders,
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            aspectRatio: 14 / 11,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: false,
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            viewportFraction: 0.84,
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        // Video play container with text overlay
                        GestureDetector(
                          onTap: () {
                            print('play video');
                          },
                          child: Container(
                            width: width * 0.84,
                            height: height * 0.11,
                            decoration: BoxDecoration(
                              color: MyMateThemes.premiumAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                // Positioned play icon
                                Positioned(
                                  top: height * 0.04,
                                  //top: constraints.maxHeight * 0.2,
                                  left:width* 0.08,
                                  child: SvgPicture.asset(
                                    'assets/images/play.svg',
                                    width: width * 0.08,
                                  ),
                                ),
                                // Positioned text overlay
                                Positioned(
                                  top: height* 0.031,
                                  right: width * 0.15,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Watch 5 videos to get 2',
                                        style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.w500),
                                      ),
                                       Text(
                                        'tokens',
                                        style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: width * 0.1),

                            Text(
                              "Special offers",
                              style: TextStyle(
                                color: MyMateThemes.textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.045,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),

                        // Offer slider carousel
                        buildCurrentOffers(),
                        SizedBox(height: height * 0.05),


                      ],
                    ),
                  ),
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
                docId: '',
              ),

            );
          }
        );

  }
}

