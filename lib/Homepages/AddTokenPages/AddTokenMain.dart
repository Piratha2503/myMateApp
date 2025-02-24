import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../../ManagePages/ManagePage.dart';
import 'AddTokenWidgets.dart';


class AddTokenMainPage extends StatefulWidget {
  final String docId;
  const AddTokenMainPage({Key? key, required this.docId}) : super(key: key);

  @override
  State<AddTokenMainPage> createState() => _AddTokenMainPageState();
}

class _AddTokenMainPageState extends State<AddTokenMainPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Read width and height from constraints to use for responsive sizing.
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
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
                              width: width * 0.035,
                            ),
                          ),
                          SizedBox(width: width * 0.1),
                          Text(
                            "Package Plan",
                            style: TextStyle(
                              color: MyMateThemes.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.05,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Package slider carousel
                    CarouselSlider(
                      items: packageSliders,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        aspectRatio: 14 / 11,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: false,
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        viewportFraction: 0.76,
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    // Video play container with text overlay
                    GestureDetector(
                      onTap: () {
                        print('play video');
                      },
                      child: Container(
                        width: width * 0.8,
                        height: height * 0.11,
                        decoration: BoxDecoration(
                          color: MyMateThemes.premiumAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            // Positioned play icon
                            Positioned(
                              top: constraints.maxHeight * 0.04,
                              //top: constraints.maxHeight * 0.2,
                              left:constraints.maxWidth * 0.08,
                              child: SvgPicture.asset(
                                'assets/images/play.svg',
                                width: width * 0.08,
                              ),
                            ),
                            // Positioned text overlay
                            Positioned(
                              top: constraints.maxHeight * 0.031,
                              right: constraints.maxWidth * 0.15,
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
                    SizedBox(height: height * 0.03),
                    // Offer slider carousel
                    CarouselSlider(
                      items: offerSliders,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        aspectRatio: 14 / 8,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: false,
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        viewportFraction: 0.76,
                      ),
                    ),
                    SizedBox(height: height * 0.03),


                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

