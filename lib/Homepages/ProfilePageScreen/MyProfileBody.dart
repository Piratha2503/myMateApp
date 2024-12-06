import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/photoGalleryPage.dart';

import '../../dbConnection/Firebase.dart';
import '../custom_outline_button.dart';
import 'MyProfileBodyWidgets.dart';
import 'MyProfileStatelessWidgets.dart';

class MyProfileBody extends StatefulWidget {
  final String docId;
  const MyProfileBody({required this.docId,super.key});

  @override
  State<MyProfileBody> createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {

  final ScrollController _scrollController = ScrollController();
  int _selectedButtonIndex = 0;
  final Firebase firebase = Firebase();
  late List<double> _positions;

  String full_name = "";
  String gender = "";
  String education = "";
  String district = "";
  String occupation = "";
  String mobile = "";
  String religion = "";
  String age = "";
  String dob = "";
  String image_url = "";


  void _scrollToContainer(int index) {
    double containerHeight =MediaQuery.of(context).size.height;
    double targetPosition = index * containerHeight - containerHeight/3.75;
    _scrollController.animateTo(
      targetPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  bool isButtonSelected(int index) => _selectedButtonIndex == index;

  Future<void> getClient() async {
    DocumentSnapshot client = await firebase.clients.doc(widget.docId).get();

    setState(() {
      full_name = client['full_name'] ?? "N/A";
      gender = client['gender'] ?? "N/A";
      education = client['education'] ?? "N/A";
      district = client['district'] ?? "N/A";
      occupation = client['occupation'] ?? "N/A";
      mobile = client['mobile'].toString() ?? "N/A";
      religion = client['religion'] ?? "N/A";
      age = client['age'].toString() ?? "N/A";
      dob = client['dob'] ?? "N/A";
      image_url = client['image_url'] ?? "N/A";
    });
  }

  @override
  void initState() {

    super.initState();
    getClient().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calculatePositions();
      });
    });
  }

  void _calculatePositions() {
    _positions = [
      0.0, // Starting position for the first section
      MediaQuery.of(context).size.height, // Second section start
      MediaQuery.of(context).size.height * 2, // Third section start
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ProfileInfo(full_name,image_url),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWithText('assets/images/Group 2145.svg', '$age years', dob),
                    IconWithText('assets/images/Group 2146.svg', occupation, '$district - '),
                    IconWithText('assets/images/Group 2147.svg', district, district),
                  ],
                ),
                SizedBox(height: 30),
                ActionButtons(context),
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: SvgPicture.asset( 'assets/images/Group 2196.svg'),
                          onTap: () {
                            setState(() {
                              _selectedButtonIndex = 0;
                            });
                            _scrollToContainer(1);
                          },
                        ),
                        SizedBox(width: 30),
                        Column(
                          children: [
                            GestureDetector(
                              child: SvgPicture.asset('assets/images/Group 2192.svg'),
                              onTap: () {
                                setState(() {
                                  _selectedButtonIndex = 1;
                                });
                                _scrollToContainer(2);
                              },
                            ),
                            SizedBox(height: 16),
                            GestureDetector(
                              child: SvgPicture.asset('assets/images/Group 2197.svg'),
                              onTap: () {
                                setState(() {
                                  _selectedButtonIndex = 2;
                                });
                                _scrollToContainer(3);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                AstrologySection(),
                Containers(
                  children:[
                    AboutMe(),
                    SizedBox(height: 48),
                    PhotoGallery(),
                    AdditionalInfo(context),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomOutlineButton(
                assetPath: 'assets/images/Group 2148.svg',
                label: 'Astrology',
                index: 0,
                isSelected: isButtonSelected(0),
                onPressed: () {

                  setState(() {
                    _selectedButtonIndex = 0;
                  });
                  _scrollToContainer(1);
                },
              ),
              SizedBox(width: 10),
              CustomOutlineButton(
                assetPath: 'assets/images/Group 2150.svg',
                label: 'About me',
                index: 1,
                isSelected: isButtonSelected(1),
                onPressed: () {
                  setState(() {
                    _selectedButtonIndex = 1;
                  });
                  _scrollToContainer(2);
                },
              ),
              SizedBox(width: 10),
              CustomOutlineButton(
                assetPath: 'assets/images/Group 2149.svg',
                label: 'Photo Gallery',
                index: 2,
                isSelected: isButtonSelected(2),
                onPressed: () {
                  setState(() {
                    _selectedButtonIndex = 2;
                  });
                  _scrollToContainer(3);
                },
              ),
              // Add other buttons similarly
            ],
          ),
        ),

      ],
    );
  }
}

