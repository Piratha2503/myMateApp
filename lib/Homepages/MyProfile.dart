import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../dbConnection/Firebase.dart';
import 'bottom_navigation_bar.dart';
import 'custom_outline_button.dart';

class ProfilePage extends StatefulWidget {
  final String docId;
  const ProfilePage({required this.docId,Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {

  String full_name = "";
  String gender = "";
  String education = "";
  String district = "";
  String occupation = "";
  String mobile = "";
  String religion = "";
  String age = "";
  String dob = "";

  final Firebase firebase = Firebase();

  Future<void> getClient() async {
    DocumentSnapshot client = await firebase.clients.doc(widget.docId).get();

    setState(() {
      full_name = client['full_name']??"N/A";
      gender = client['gender']??"N/A";
      education = client['education']??"N/A";
      district = client['district']??"N/A";
      occupation = client['occupation']??"N/A";
      mobile = client['mobile'].toString()??"N/A";
      religion = client['religion']??"N/A";
      age = client['age'].toString()??"N/A";
      dob = client['dob'] ?? "N/A";

    });
  }

  bool _isSmall = false;
  int _selectedIndex = 0;
  int _selectedButtonIndex = 0;
  ScrollController _scrollController = ScrollController();
  bool isSecondContainerVisible = true;
  bool isThirdContainerVisible = true;
  bool isFourthContainerVisible = true;
  int badgeValue1 = 1;
  int badgeValue2 = 10;

  @override
  void initState() {
    super.initState();
    getClient();
    _scrollController.addListener(_scrollListener);
  }


  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }


  void _toggleSize() {
    setState(() {
      _isSmall = !_isSmall;
    });
  }

  bool isButtonSelected(int index) {
    return _selectedButtonIndex == index;
  }

  void _scrollListener() {
    double containerHeight = 670.0;
    int newIndex = (_scrollController.offset / containerHeight).floor();
    if (newIndex != _selectedButtonIndex) {
      setState(() {
        _selectedButtonIndex = newIndex;
      });
    }
  }

  void _scrollToContainer(int index) {
    double containerHeight = 500.0;
    double targetPosition = index * containerHeight - containerHeight / 2;
    _scrollController.animateTo(
      targetPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: MyMateThemes.backgroundColor,
      title: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 50),
                Text(
                  '@user240676',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 40),
                _buildBadge('assets/images/Group 2157.svg', badgeValue1),
                SizedBox(width: 10),
                _buildBadge('assets/images/Group 2153.svg', badgeValue2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String assetPath, int badgeValue) {
    return Stack(
      children: [
        SvgPicture.asset(assetPath),
        if (badgeValue > 0)
          Positioned(
            top: -2,
            right: -1,
            child: Container(
              decoration: BoxDecoration(
                color: MyMateThemes.secondaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                badgeValue.toString(),
                style: TextStyle(
                  color: MyMateThemes.primaryColor,
                  fontSize: badgeValue > 9 ? 12 : 16,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleSize,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: _isSmall ? 50 : 230,
            alignment: _isSmall ? Alignment(-1.2, 1.0) : Alignment.center,
            child: SvgPicture.asset('assets/images/Group 2073 (1).svg'),
          ),
        ),
        GestureDetector(
          onTap: _toggleSize,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            alignment: _isSmall ? Alignment(0.1, 0.0) : Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$full_name',
                  style: TextStyle(
                    color: MyMateThemes.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Special Mention (Optional)',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 14,
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

  Widget _buildIconWithText(String iconPath, String text1, String text2) {
    return Container(
      width: 120,
      height: 72,
      child: Column(
        children: [
          SvgPicture.asset(iconPath),
          SizedBox(height: 5),
          Text(
            text1,
            style: TextStyle(
              color: MyMateThemes.textColor,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              color: MyMateThemes.primaryColor,
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      foregroundDecoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: MyMateThemes.secondaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            print("hello");
          },
          child: SvgPicture.asset('assets/images/EditButton.svg'),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        SizedBox(width: 40),
        SvgPicture.asset('assets/images/Group 2148.svg'),
        SizedBox(width: 4),
        Text(title),
      ],
    );
  }

  Widget _buildContainers() {
    return Column(
      children: [
        Visibility(
          visible: isSecondContainerVisible,
          child: Container(
            width: 340,
            height: 500,
            color: MyMateThemes.secondaryColor,
            child: Center(
              child: Text(
                'Container 2',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        Visibility(
          visible: isThirdContainerVisible,
          child: Container(
            width: 340,
            height: 500,
            color: MyMateThemes.secondaryColor,
            child: Center(
              child: Text(
                'Container 3',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        Visibility(
          visible: isFourthContainerVisible,
          child: Container(
            width: 340,
            height: 500,
            color: MyMateThemes.secondaryColor,
            child: Center(
              child: Text(
                'Container 4',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationBar() {
    return CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: (index) {
        setState(() {
          _selectedIndex = index;
        });
        // Handle navigation here based on the index
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _buildProfileInfo(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconWithText('assets/images/Group 2145.svg',
                          '$age years', '$dob'),
                      _buildIconWithText('assets/images/Group 2146.svg',
                          '$occupation', '$district - '),
                      _buildIconWithText('assets/images/Group 2147.svg',
                          '$district', 'Sri Lanka'),
                    ],
                  ),
                  SizedBox(height: 30),
                  _buildActionButtons(),
                  SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: SvgPicture.asset(
                                'assets/images/Group 2196.svg'),
                            onTap: () {
                              setState(() {
                                _selectedButtonIndex = 0;
                                isSecondContainerVisible = true;
                                isThirdContainerVisible = true;
                                isFourthContainerVisible = true;
                              });
                              _scrollToContainer(1);
                            },
                          ),
                          SizedBox(width: 30),
                          Column(
                            children: [
                              GestureDetector(
                                child: SvgPicture.asset(
                                    'assets/images/Group 2192.svg'),
                                onTap: () {
                                  setState(() {
                                    _selectedButtonIndex = 1;
                                    isSecondContainerVisible = true;
                                    isThirdContainerVisible = true;
                                    isFourthContainerVisible = true;
                                  });
                                  _scrollToContainer(2);
                                },
                              ),
                              SizedBox(height: 16),
                              GestureDetector(
                                child: SvgPicture.asset(
                                    'assets/images/Group 2197.svg'),
                                onTap: () {
                                  setState(() {
                                    _selectedButtonIndex = 2;
                                    isSecondContainerVisible = true;
                                    isThirdContainerVisible = true;
                                    isFourthContainerVisible = true;
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
                  _buildSectionTitle("Astrology"),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(width: 40),
                      SvgPicture.asset('assets/images/Line 11.svg'),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildContainers(),
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
                      isSecondContainerVisible = true;
                      isThirdContainerVisible = true;
                      isFourthContainerVisible = true;
                    });
                    _scrollToContainer(1);
                  },
                ),
                SizedBox(width: 10),
                CustomOutlineButton(
                  assetPath: 'assets/images/Group 2149.svg',
                  label: 'Family',
                  index: 1,
                  isSelected: isButtonSelected(1),
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 1;
                      isSecondContainerVisible = true;
                      isThirdContainerVisible = true;
                      isFourthContainerVisible = true;
                    });
                    _scrollToContainer(2);
                  },
                ),
                SizedBox(width: 10),
                CustomOutlineButton(
                  assetPath: 'assets/images/Group 2150.svg',
                  label: 'About me',
                  index: 2,
                  isSelected: isButtonSelected(2),
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 2;
                      isSecondContainerVisible = true;
                      isThirdContainerVisible = true;
                      isFourthContainerVisible = true;
                    });
                    _scrollToContainer(3);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }
}
