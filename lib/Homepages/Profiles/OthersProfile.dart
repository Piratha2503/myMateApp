import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Homepages/Profiles/MoreAboutMe.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../dbConnection/Firebase.dart';
import '../ProfilePageScreen/navamsaChartDesign.dart';
import '../ProfilePageScreen/photoGalleryPage.dart';
import '../ProfilePageScreen/rasiChartDesign.dart';
import '../custom_outline_button.dart';
import 'EditPage.dart';
import 'package:http/http.dart' as http;




class OtherProfilePage extends StatefulWidget {
  final String docId;

  const OtherProfilePage({this.docId = 'E0JFHhK2x6Gq2Ac6XSyP', super.key});

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage>
    with TickerProviderStateMixin {
  String full_name = "";
  String gender = "";
  String education = "";
  String district = "";
  String occupation = "";
  String mobile = "";
  String religion = "";
  String mother_name = "";
  String num_of_siblings = "";
  String age = "";
  String dob = "";
  String profilePictureUrl = "";
  bool _isSmall = false;
  int _selectedIndex = 0;
  int _selectedButtonIndex = 0;
  final ScrollController _scrollController = ScrollController();

  int selectedAlcoholIndex = 0;
  int selectedCookingIndex = 0;

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

  /// Fetch data from API using fetchUserById
  Future<void> getClient() async {
    try {
      final data = await fetchUserById(widget.docId);

      if (data.isNotEmpty) {
        setState(() {
          full_name = data['full_name'] ?? "N/A";
          gender = data['gender'] ?? "N/A";
          education = data['education'] ?? "N/A";
          district = data['city'] ?? "N/A"; // Adjusted key to match your API structure
          occupation = data['occupation'] ?? "N/A";
          mobile = data['contact']?.toString() ?? "N/A";
          religion = data['religion'] ?? "N/A";
          mother_name = data['mother_name'] ?? "N/A";
          num_of_siblings = data['num_of_siblings'] ?? "N/A";
          age = data['age']?.toString() ?? "N/A";
          dob = data['date_of_birth'] ?? "N/A";
          profilePictureUrl =data['profile_pic_url'] ?? "N/A";

        });
        print('Profile Picture URL: $profilePictureUrl');

      } else {
        print('No data found for the given docId');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
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
    double containerHeight = 620.0;
    int newIndex = (_scrollController.offset / containerHeight).floor();
    if (newIndex != _selectedButtonIndex) {
      setState(() {
        _selectedButtonIndex = newIndex;
      });
    }
  }

  void _scrollToContainer(int index) {
    double containerHeight = 550.0;
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
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MoreAboutMePage()));
              },
              child: SvgPicture.asset('assets/images/chevron-left.svg'),
            ),
            SizedBox(width: 70.0),
            Text(
              "@ $full_name",
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
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
            child: profilePictureUrl.isNotEmpty
                ? ClipOval(
              child: Image.network(
                profilePictureUrl,
                fit: BoxFit.cover,
                height: _isSmall ? 50 : 230,
                width: _isSmall ? 50 : 230,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: _isSmall ? 50 : 230);
                },
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
                : Icon(Icons.account_circle, size: _isSmall ? 50 : 230),
          ),
        ),
        GestureDetector(
          onTap: _toggleSize,
          child: Column(
            children: [
              Text(
                full_name,
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: MyMateThemes.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Text('Send Request '),
        ),
        SizedBox(width: 30),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyMateThemes.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Text('Check Match'),
        ),
      ],
    );
  }


  Widget _buildProfileDetails() {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserById(widget.docId), // Call API with docId
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final data = snapshot.data!;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              _buildSectionTitle('About me'),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 40),
                  SvgPicture.asset('assets/images/Line 11.svg'),
                ],
              ),
              SizedBox(height: 10),
              _buildInfoRow('Full Name', data['full_name'] ?? 'N/A'),
              _buildInfoRow('Education', data['education'] ?? 'N/A'),
              _buildInfoRow('Height', '${data['height'] ?? 'N/A'} CM'),
              _buildInfoRow('Religion', data['religion'] ?? 'N/A'),
              _buildInfoRow('Language', data['language'] ?? 'Tamil, English'),
              _buildInfoRow('Caste', data['caste'] ?? 'Optional'),
              _buildInfoRow('Father\'s Name', data['father_name'] ?? 'N/A'),
              _buildInfoRow('Mother\'s Name', data['mother_name'] ?? 'N/A'),
              _buildInfoRow('Siblings', data['num_of_siblings']?.toString() ?? 'N/A'),
              _buildInfoRow('Age', data['age']?.toString() ?? 'N/A'),
              _buildInfoRow('Date of Birth', data['date_of_birth'] ?? 'N/A'),
              _buildInfoRow('Mobile', data['contact'] ?? 'N/A'),
              _buildInfoRow('Address', data['address'] ?? 'N/A'),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 40),
                  Text(
                    'Expectations',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _buildExpectations(),
            ],
          ),
        );
      },
    );
  }


  Widget _buildInfoRow(String title, String value) {
    return Container(
      height: 34,
      width: 297,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: MyMateThemes.containerColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: MyMateThemes.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: MyMateThemes.textColor,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSectionTitle(String title) {
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

  Widget _buildExpectationRow(String title) {
    return Container(
      height: 34,
      width: 297,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: MyMateThemes.containerColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: MyMateThemes.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildExpectations() {
    return Column(
      children: [
        _buildExpectationRow('Expectation 1'),
        _buildExpectationRow('Expectation 2'),
        _buildExpectationRow('Expectation 3'),
        _buildExpectationRow('Expectation 4'),
        _buildExpectationRow('Expectation 5'),
        SizedBox(height: 20),
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
      },
    );
  }

  Widget _buildIconWithText(String iconPath, String text1, String text2) {
    return Container(
      width: 120,
      height: 72,
      foregroundDecoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: MyMateThemes.secondaryColor,
            width: 2,
          ),
        ),
      ),
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
                      _buildIconWithText(
                          'assets/images/Group 2145.svg', '$age years', dob),
                      _buildIconWithText('assets/images/Group 2146.svg',
                          occupation, '$district - '),
                      _buildIconWithText('assets/images/Group 2147.svg',
                          district, 'Sri Lanka'),
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
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 40),
                      SvgPicture.asset('assets/images/Line 11.svg'),
                    ],
                  ),
                  SizedBox(height: 25),
                  RasiChartDesign(),
                  SizedBox(height: 40),
                  NavamsaChartDesign(),
                  SizedBox(height: 40),
                  // _buildProfileDetails(),
                  SizedBox(height: 40),
                  PhotoGallery(docId: widget.docId,),
                  SizedBox(height: 40),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          _buildNavigationBar(),
        ],
      ),
    );
  }
}
