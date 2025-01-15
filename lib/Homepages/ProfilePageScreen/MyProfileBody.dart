import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/photoGalleryPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../dbConnection/Firebase.dart';
import '../Profiles/MoreAboutMe.dart';
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


  void _scrollToContainer(int index) {
    double containerHeight =MediaQuery.of(context).size.height;
    double targetPosition = index * containerHeight - containerHeight/6;
    _scrollController.animateTo(
      targetPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  bool isButtonSelected(int index) => _selectedButtonIndex == index;

  Future<void> getClient() async {
    //DocumentSnapshot client = await firebase.clients.doc(widget.docId).get();
    final data = await fetchUserById(widget.docId);
    if(data.isNotEmpty){
      setState(() {
        full_name = data['full_name'] ?? "N/A";
        gender = data['gender'] ?? "N/A";
        education = data['education'] ?? "N/A";
        city = data['city'] ?? "N/A";
        occupation = data['occupation'] ?? "N/A";
        mobile = data['mobile'].toString() ?? "N/A";
        religion = data['religion'] ?? "N/A";
        age = data['age'].toString() ?? "N/A";
        dob = data['dob'] ?? "N/A";
        dot = data['dot'] ?? "N/A";
        country = data['country'] ?? "N/A";
        rasi = data['rasi'] ?? "N/A";
        natchathiram = data['natchathiram'] ?? "N/A";
        profilePictureUrl =data['profileImages']?['profile_pic_url'] ?? "N/A";
        address = data['address'] ?? "N/A";
        isLoading = false;
        var expectations = data['expectations'] ?? [];
        print(widget.docId);
      });
    }
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
                ProfileInfo(full_name,profilePictureUrl),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWithText('assets/images/Group 2145.svg', '$age years', dob),
                    IconWithText('assets/images/Group 2146.svg', occupation, '$city - '),
                    IconWithText('assets/images/Group 2147.svg', city, city),
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
                    PhotoGallery(docId: widget.docId),
                    SizedBox(height:30),
                    SectionTitle('More about me'),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(width: 40),
                        SvgPicture.asset('assets/images/Line 11.svg'),
                      ],
                    ),
                    SizedBox(height: 25),

                    // First Section - Show if the form is not filled
                    if (!isFormFilled) ...[
                      Row(
                        children: [
                          SizedBox(width: 42),
                          Text(
                            'No more about me found',
                            style: TextStyle(
                              color: MyMateThemes.textColor.withOpacity(0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 40),
                          ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MoreAboutMePage(),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  isFormFilled = true; // Set this to true when the form is completed
                                });
                              }
                            },
                            child: Text(
                              '+ Add more about me ',
                              style: TextStyle(fontSize: 14, letterSpacing: 0.8),
                            ),
                            style: CommonButtonStyle.commonButtonStyle(),
                          ),

                        ],
                      ),
                    ],

                    // Second Section - Show if the form is filled
                    if (isFormFilled) ...[
                      // Your additional info section here
                      AdditionalInfo(context),
                    ],
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
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

