import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../MyMateThemes.dart';
import 'MyProfileBodyWidgets.dart';
import 'MyProfileWidgets.dart';

class PhotoGallery extends StatefulWidget {
  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  int _currentIndex = 0; // Tracks the current center item index

  final List<String> imagePaths = [
    'assets/images/explore2.jpg',
    'assets/images/explore1.jpg',
    'assets/images/explore3.jpg',
  ];

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
          SizedBox(height: 25),

          // Photo Gallery Content
          Container(
            height: screenHeight * 0.48, // Adjust container height relative to screen height
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),),
            child: CarouselSlider.builder(
              itemCount: imagePaths.length,
              itemBuilder: (context, index, realIndex) {
                bool isCentered = index == _currentIndex; // Check if the item is currently centered

                return AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: 297,
                  height: 379,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: isCentered ? Colors.transparent : MyMateThemes.secondaryColor,
                    // boxShadow: isCentered
                    //     ? [
                    // //   BoxShadow(
                    // //     color: Colors.transparent,
                    // //     blurRadius: 8,
                    // //     offset: Offset(0, 4),
                    // //   )
                    // // ]
                    // //     :  [
                    // //   BoxShadow(
                    // //     color: MyMateThemes.primaryColor.withOpacity(0.5),
                    // //     blurRadius: 2,
                    // //     offset: Offset(0, 4),
                    // //   )
                    // ],
                  ),
                  child: isCentered
                      ? Image.asset(
                    imagePaths[index],

                    fit: BoxFit.fill,

                  )
                      : SizedBox.expand(), // Empty container with white background for non-centered
                );
              },
              options: CarouselOptions(
                height: 379.0,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlay: false,
                enableInfiniteScroll: false,
                scrollPhysics: BouncingScrollPhysics(),
                viewportFraction: 0.75,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index; // Update the current index on scroll
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}