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
      setState(() {
        imagePaths = List<String>.from(data['gallery_image_urls'] ?? []);
        isLoading = false;
        print(imagePaths);
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load images: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

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
            height: screenHeight * 0.48,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: CarouselSlider.builder(
              itemCount: imagePaths.length,
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
                      ? Image.network(
                    imagePaths[index],
                    fit: BoxFit.fill,
                  )
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