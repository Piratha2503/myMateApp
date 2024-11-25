import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/dbConnection/Clients.dart';
import '../../ManagePages/SummaryPage.dart';
import '../../MyMateThemes.dart';
import '../BadgeWidget.dart';

PreferredSizeWidget SubscribedhomescreenStructuredPageAppBar() {
  int badgeValue1 = 2;
  int badgeValue2 = 10;

  return AppBar(
    title:  CommonTextStyleForPage('Your Name', MyMateThemes.textColor, FontWeight.w700, 20,),
    actions: <Widget>[
      SizedBox(width: 60),
      BadgeWidget(
          assetPath: 'assets/images/Group 2157.svg',
          badgeValue: badgeValue1),
      SizedBox(width: 25),
      BadgeWidget(
          assetPath: 'assets/images/Group 2153.svg',
          badgeValue: badgeValue2),
      SizedBox( width: 25, )
    ],
  );
}

Widget SubscribedhomescreenStructuredPageTotalMatchColumn(BuildContext context){
  return Center(
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Summarypage()));
      },
      child: Stack(
        children: [
          SvgPicture.asset('assets/images/Frame.svg',
              width: 300, height: 220),
          Positioned(
            top: 69,
            right: 98,
            child: CommonTextStyleForPage('137',Colors.white,FontWeight.w500,40,),
          ),
          Positioned(
            top: 118,
            right: 69,
            child: CommonTextStyleForPage('Matches Found',Colors.white,FontWeight.w500,20,),
          )
        ],
      ),
    ),
  );
}

Widget SubscribedhomescreenStructuredPageCarouselSlider() {
  return FutureBuilder<QuerySnapshot>(
    future: FirebaseFirestore.instance.collection('clients').get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(
          child: Text(
            'No clients found.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      final profiles = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ClientProfile(
          name: data['full_name'] ?? 'Unknown',
          age: data['age'] ?? 0,
          status: data['status'] ?? 'Unknown',
          occupation: data['occupation'] ?? 'Unknown',
          district: data['district'] ?? 'Unknown',
          imageUrl:  'https://via.placeholder.com/150',
          matchPercentage: data['matchPercentage'] ?? '75%-100%',
        );
      }).toList();

      return Center(
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
                return SubscribedhomescreenStructuredPageCarouselSliderContainer(profile);
              },
            );
          }).toList(),
        ),
      );
    },
  );
}

Widget SubscribedhomescreenStructuredPageCarouselSliderContainer(ClientProfile profile){
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
        Row(
            children: [
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 4.0
                    ),
                    child: CommonTextStyleForPage( profile.name, MyMateThemes.textColor, FontWeight.w700, 16,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 4.0
                    ), // Add bottom padding for spacing
                    child: Row(
                      children: [
                        CommonTextStyleForPage(' ${profile.age}, ', MyMateThemes.textColor, FontWeight.w400,12, ),
                        CommonTextStyleForPage( profile.status, MyMateThemes.textColor, FontWeight.w500, 12, ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom:
                        4.0), // Add bottom padding for spacing
                    child: CommonTextStyleForPage(' ${profile.occupation}',MyMateThemes.textColor,FontWeight.w500,12,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom:
                        4.0), // Add bottom padding for spacing
                    child: CommonTextStyleForPage(' ${profile.district}',MyMateThemes.textColor,FontWeight.w500,12,),
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
                        CommonTextStyleForPage(' ${profile.matchPercentage}',MyMateThemes.primaryColor,FontWeight.w500,12),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
      ],
    ),
  );
}

Widget SubscribedhomescreenStructuredPageTokenContainers(BuildContext context){

  return Row(
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
            child: CommonTextStyleForPage('10',MyMateThemes.textColor,FontWeight.w500,18, ),
          ),
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
              child: CommonTextStyleForPage('+Add Tokens',MyMateThemes.primaryColor,FontWeight.w500,11,),
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
  );
}

Widget SubscribedhomescreenStructuredPagePopupDialogWidget(BuildContext context){
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
                PopupDialogTextStyle( "Congratulations! You have received ", MyMateThemes.textColor, ),
                Row(
                  children: [
                    PopupDialogTextStyle( '10 free ', MyMateThemes.primaryColor, ),
                    PopupDialogTextStyle('Tokens. You can spend free',  MyMateThemes.textColor, ),
                  ],
                ),
                PopupDialogTextStyle("tokens to access Following",  MyMateThemes.textColor, ),
                PopupDialogTextStyle("features only",  MyMateThemes.textColor, ),
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
}

Widget CommonTextStyleForPage(String text,Color color, FontWeight fontWeight, double fontSize, ){
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget PopupDialogTextStyle(String text, Color color){
  return Text(
    text,
    style: TextStyle(
      color: color,
      letterSpacing:
      1.2, // Adjust letter spacing as needed
      wordSpacing: 1.1, // Adjust word spacing as needed
    ),
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