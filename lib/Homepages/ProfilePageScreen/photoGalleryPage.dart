import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateThemes.dart';
import 'MyProfileBodyWidgets.dart';
import 'MyProfileWidgets.dart';

class PhotoGallery extends StatefulWidget {
  final String docId;

  PhotoGallery({required this.docId});

  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  int _currentIndex = 0;
  List<String> imagePaths = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    try {
      final data = await fetchUserById(widget.docId);
      final galleryData = data['gallery_image_urls'];

      setState(() {
        if (galleryData is List) {
          imagePaths = List<String>.from(galleryData);
        } else if (galleryData is String && galleryData.isNotEmpty) {
          imagePaths = [galleryData];
        } else {
          imagePaths = [];
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load the images: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool hasImages = imagePaths.isNotEmpty;

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : errorMessage.isNotEmpty
        ? Center(child: Text(errorMessage))
        : SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle('Photo Gallery'),
          SizedBox(height: 10),

          Row(
            children: [
              SizedBox(width: 40),
              SvgPicture.asset('assets/images/Line 11.svg'),
            ],
          ),
          SizedBox(height: 25),

          Container(
            height: screenHeight * 0.30,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: CarouselSlider.builder(
              itemCount: hasImages ? imagePaths.length : 3,
              itemBuilder: (context, index, realIndex) {
                bool isCentered = index == _currentIndex;

                return AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: 297,
                  height: 379,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: isCentered
                        ? Colors.transparent
                        : MyMateThemes.secondaryColor,
                  ),
                  child: isCentered
                      ? hasImages
                      ? Image.network(
                    imagePaths[index],
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) =>
                        PlaceholderWidget(),
                  )
                      : PlaceholderWidget()
                      : SizedBox.expand(),
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
                    _currentIndex = index;
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

Widget SectionTitle(String title) {
  return Row(
    children: [
      SizedBox(width: 40),
      SvgPicture.asset('assets/images/Group 2148.svg'),
      SizedBox(width: 4),
      Text(
        title,
        style: TextStyle(
          color: MyMateThemes.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget PlaceholderWidget() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(15),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, size: 50, color: Colors.grey[600]),
          SizedBox(height: 8),
          Text(
            "No Image Available",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    ),
  );
}
