import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/photoGalleryPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../dbConnection/Firebase.dart';
import '../Profiles/MoreAboutMe.dart';
import '../custom_outline_button.dart';
import 'MyProfileBodyWidgets.dart';
import 'MyProfileStatelessWidgets.dart';
import 'package:http/http.dart' as http;

class MyProfileBody extends StatefulWidget {
  final String docId;
  const MyProfileBody({required this.docId,super.key});

  @override
  State<MyProfileBody> createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {

  final ScrollController _scrollController = ScrollController();

  final Firebase firebase = Firebase();
  late List<double> _positions;

  bool isFormFilled = true;

  String full_name = "";
  String gender = "";
  String education = "";
  String city = "";
  String occupation = "";
  String mobile = "";
  String religion = "";
  String mother_name = "";
  String num_of_siblings = "";
  String age = "";
  String dob = "";
  String dot = "";
  String address = "";
  String profilePictureUrl = "";
  String country = "";
  String rasi = "";
  String natchathiram = "";
  List<String> expectations = [];
  bool _isSmall = false;
  int _selectedIndex = 0;
  int _selectedButtonIndex = 0;
  List<TextEditingController> controllers = [];
  bool isLoading = true;
  PersonalDetails personalDetails = PersonalDetails();



  final GlobalKey _anchorKey1 = GlobalKey();
  final GlobalKey _anchorKey2 = GlobalKey();
  final GlobalKey _anchorKey3 = GlobalKey();



  void _scrollListener() {
    List<GlobalKey> anchorKeys = [_anchorKey1, _anchorKey2, _anchorKey3];

    for (int i = 0; i < anchorKeys.length; i++) {
      BuildContext? context = anchorKeys[i].currentContext;
      if (context != null) {
        RenderObject? renderObject = context.findRenderObject();
        if (renderObject != null) {
          RenderBox box = renderObject as RenderBox;
          Offset position = box.localToGlobal(Offset.zero);

          // Check if this anchor is within the viewport
          if (position.dy >= 0 && position.dy < MediaQuery.of(context).size.height / 2) {
            if (_selectedButtonIndex != i) {
              setState(() {
                _selectedButtonIndex = i;
              });
            }
            break; // Stop checking further once the first visible anchor is found
          }
        }
      }
    }
  }


  void _scrollToContainer(GlobalKey anchorKey) {
    BuildContext? context = anchorKey.currentContext;
    if (context != null) {
      RenderObject? renderObject = context.findRenderObject();
      if (renderObject != null) {
        RenderBox box = renderObject as RenderBox;
        Offset position = box.localToGlobal(Offset.zero);
        double targetOffset = position.dy + _scrollController.offset;

        _scrollController.animateTo(
          targetOffset - 50, // Adjust for padding if needed
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  bool isButtonSelected(int index) => _selectedButtonIndex == index;

  Future<void> getClient() async {
    //DocumentSnapshot client = await firebase.clients.doc(widget.docId).get();
    final data = await fetchUserById(widget.docId);

    if(data.isNotEmpty){
      setState(() {
        personalDetails.full_name = data['full_name'] ?? "N/A";
        personalDetails.gender = data['gender'] ?? "N/A";
        education = data['education'] ?? "N/A";
        city = data['city'] ?? "N/A";
        occupation = data['occupation'] ?? "N/A";
        mobile = data['mobile'].toString() ?? "N/A";
        personalDetails.religion = data['religion'] ?? "N/A";
        age = data['age'].toString() ?? "N/A";
        dob = data['dob'] ?? "N/A";
        dot = data['dot'] ?? "N/A";
        country = data['country'] ?? "N/A";
        personalDetails.language = data['language'] ?? 'N/A';
        rasi = data['rasi'] ?? "N/A";
        natchathiram = data['natchathiram'] ?? "N/A";
        profilePictureUrl =data['profile_pic_url'] ?? "https://piratha.com/images/profile.png";
        address = data['address'] ?? "N/A";
        isLoading = false;
        var expectations = data['expectations'] ?? [];
        personalDetails.first_name = data['first_name']?? "N/A";
        personalDetails.mother_name = data['mother_name'] ?? "N/A";
        personalDetails.caste = data['caste'] ?? "N/A";
        personalDetails.religion = data['religion'] ?? "N/A";
        personalDetails.num_of_siblings = data['num_of_siblings'] ?? "N/A";
        personalDetails.height = data['height'] ?? "N/A";

      });
    }

  }


  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {

    super.initState();
    _scrollController.addListener(_scrollListener);

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
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ProfileInfo(personalDetails.full_name.toString(), profilePictureUrl),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWithText(context,'assets/images/Group 2145.svg', '$age years', dob),
                    IconWithText(context,'assets/images/Group 2146.svg', occupation, '$city - '),
                    IconWithText(context,'assets/images/Group 2147.svg', city, city),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                ActionButtons(context, widget.docId),
                SizedBox(height: screenHeight * 0.03),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: SvgPicture.asset('assets/images/Group 2196.svg', width: screenWidth * 0.13,height:screenHeight * 0.25 ,),
                          onTap: () {


                            // setState(() {
                            //   _selectedButtonIndex = 0;
                            // });
                            _scrollToContainer(_anchorKey1);
                            ;
                          },
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Column(
                          children: [
                            GestureDetector(
                              child: SvgPicture.asset('assets/images/Group 2192.svg', width: screenWidth * 0.13,height:screenHeight * 0.12 ),
                              onTap: () {
                                // setState(() {
                                //   _selectedButtonIndex = 1;
                                // });
                                _scrollToContainer(_anchorKey2);
                                ;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            GestureDetector(
                              child: SvgPicture.asset('assets/images/Group 2197.svg', width: screenWidth * 0.13,height:screenHeight * 0.12),
                              onTap: () {
                                // setState(() {
                                //   _selectedButtonIndex = 2;
                                // });
                                _scrollToContainer(_anchorKey3);
                                ;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(key: _anchorKey1),
                SizedBox(height: screenHeight * 0.06),
                AstrologySection(),
                Containers(
                  children: [
                    SizedBox(key: _anchorKey2),
                    SizedBox(height: screenHeight * 0.06),
                    AboutMe(education: education, personalDetails: personalDetails, docId: widget.docId),
                    SizedBox(height: screenHeight * 0.06),
                    SizedBox(key: _anchorKey3),
                    SizedBox(height: screenHeight * 0.06),

                    PhotoGallery(docId: widget.docId),
                    SizedBox(height: screenHeight * 0.04),
                    SectionTitle(context,'More about me',),
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      children: [
                        SizedBox(width: screenWidth * 0.1),
                        SvgPicture.asset('assets/images/Line 11.svg'),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    if (!isFormFilled) ...[
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.1),
                          Text(
                            'No more about me found',
                            style: TextStyle(
                              color: MyMateThemes.textColor.withOpacity(0.8),
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.1),
                          ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MoreAboutMePage(docId: widget.docId),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  isFormFilled = true;
                                });
                              }
                            },
                            child: Text(
                              '+ Add more about me ',
                              style: TextStyle(fontSize: screenWidth * 0.035, letterSpacing: 0.8),
                            ),
                            style: CommonButtonStyle.commonButtonStyle(),
                          ),
                        ],
                      ),
                    ],
                    if (isFormFilled) ...[
                      AdditionalInfo(docId: widget.docId),
                    ],
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
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
                  _scrollToContainer(_anchorKey1);
                },
              ),
              SizedBox(width: screenWidth * 0.013),
              CustomOutlineButton(
                assetPath: 'assets/images/Group 2150.svg',
                label: 'About me',
                index: 1,
                isSelected: isButtonSelected(1),
                onPressed: () {
                  _scrollToContainer(_anchorKey2);
                },
              ),
              SizedBox(width: screenWidth * 0.013),
              CustomOutlineButton(
                assetPath: 'assets/images/Group 2149.svg',
                label: 'Photo Gallery',
                index: 2,
                isSelected: isButtonSelected(2),
                onPressed: () {
                  _scrollToContainer(_anchorKey3);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget ProfileInfo(String full_name,String image_url) {

    bool _isSmall = false;

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.5,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.25),
              //   color: MyMateThemes.secondaryColor,
              // ),
              child: Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  height: _isSmall ? 50 : 230,

                  alignment: _isSmall ? Alignment(-0.8, 1.0) : Alignment.center,
                  child: profilePictureUrl.isNotEmpty
                      ? ClipOval(
                    child: Image.network(
                      profilePictureUrl,
                      fit: BoxFit.cover,
                      height: _isSmall ? 50 : 230,

                      width: _isSmall
                          ? MediaQuery.of(context).size.width * 0.15
                          : MediaQuery.of(context).size.width * 0.6,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.error,
                          size: _isSmall
                              ? MediaQuery.of(context).size.width * 0.15
                              : MediaQuery.of(context).size.width * 0.45,
                        );
                      },
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  )
                      : Icon(
                    Icons.account_circle,
                    size: _isSmall
                        ? MediaQuery.of(context).size.width * 0.2
                        : MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            alignment: _isSmall ? Alignment(0.1, 0.0) : Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  full_name,
                  style: TextStyle(
                    color: MyMateThemes.primaryColor,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Special Mention (Optional)',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


}
Widget SectionTitle(BuildContext context, String title) {
  return Row(
    children: [
      SizedBox(width: MediaQuery.of(context).size.width * 0.1),
      SvgPicture.asset(
        'assets/images/Group 2148.svg',
        width: MediaQuery.of(context).size.width * 0.05,
        height: MediaQuery.of(context).size.width * 0.05,
      ),
      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
      Text(
        title,
        style: TextStyle(
          color: MyMateThemes.primaryColor,
          fontSize: MediaQuery.of(context).size.width * 0.045,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

