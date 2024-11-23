import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../MyMateThemes.dart';
import 'MyProfileBodyWidgets.dart';
import 'MyProfileWidgets.dart';

class PhotoGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height; // Screen height from MediaQuery

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          SectionTitle('Photo Gallery'),
          SizedBox(height: 10),

          // Decorative Line
          Row(
            children: [
              SizedBox(width: 40),
              SvgPicture.asset('assets/images/Line 11.svg'),
            ],
          ),
          SizedBox(height: 18),

          // Photo Gallery Content
          Container(
            height: screenHeight * 0.22, // Adjust container height relative to screen height
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Left Column
                Column(
                  children: [
                    Container(
                      width: 139.5,
                      height: 169,
                      decoration: BoxDecoration(
                        color: MyMateThemes.secondaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: NetworkImage('https://via.placeholder.com/100'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),

                // Right Column
                Column(
                  children: [
                    Container(
                      width: 139.5,
                      height: 78,
                      decoration: BoxDecoration(
                        color: MyMateThemes.secondaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: NetworkImage('https://via.placeholder.com/100'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 139.5,
                      height: 78,
                      decoration: BoxDecoration(
                        color: MyMateThemes.secondaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: NetworkImage('https://via.placeholder.com/100'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
