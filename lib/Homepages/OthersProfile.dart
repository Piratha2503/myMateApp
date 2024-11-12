import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymateapp/Homepages/MoreAboutMe.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../dbConnection/Firebase.dart';
import 'EditPage.dart';
import '../MyMateCommonBodies/MyMateBottomBar.dart';
import 'custom_outline_button.dart';

class OtherProfilePage extends StatefulWidget {
  final String docId;

  const OtherProfilePage({required this.docId, super.key});

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
  String age = "";
  String dob = "";

  final Firebase firebase = Firebase();

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
    });
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoreAboutMePage()));
                        },
                        child:
                            SvgPicture.asset('assets/images/chevron-left.svg'),
                      ),
                      SizedBox(width: 70.0),
                      Text(
                        " @ User240672 ",
                        style: TextStyle(
                            color: MyMateThemes.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
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

  Widget _buildContainers({required List<Widget> children}) {
    return Column(
      children: children,
    );
  }

  Widget _buildProfileDetails() {
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
          _buildInfoRow('Education', 'Bsc Computer Science'),
          _buildInfoRow('Height', '165 CM'),
          _buildInfoRow('Religion', 'Hinduism'),
          _buildInfoRow('Language', 'Tamil, English'),
          _buildInfoRow('Caste', 'Optional'),
          _buildInfoRow('Father\'s Name', 'Bsc Computer Science'),
          _buildInfoRow('Mother\'s Name', 'Bsc Computer Science'),
          _buildInfoRow('Siblings', '6'),
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

  Widget _buildPhotoGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Photo Gallery'),
        SizedBox(height: 5),
        Row(
          children: [
            SizedBox(width: 40),
            SvgPicture.asset('assets/images/Line 11.svg'),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: 139.5,
                    height: 169,
                    decoration: BoxDecoration(
                      color: MyMateThemes.secondaryColor,
                      borderRadius: BorderRadius.circular(
                          20.0), // Set the border radius to make it circular
                      image: DecorationImage(
                        image: NetworkImage('https://via.placeholder.com/100'),
                        fit: BoxFit
                            .cover, // Ensure the image covers the entire container
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 139.5,
                    height: 78,
                    decoration: BoxDecoration(
                      color: MyMateThemes.secondaryColor,
                      borderRadius: BorderRadius.circular(
                          20.0), // Set the border radius to make it circular
                      image: DecorationImage(
                        image: NetworkImage('https://via.placeholder.com/100'),
                        fit: BoxFit
                            .cover, // Ensure the image covers the entire container
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 139.5,
                    height: 78,
                    decoration: BoxDecoration(
                      color: MyMateThemes.secondaryColor,
                      borderRadius: BorderRadius.circular(
                          20.0), // Set the border radius to make it circular
                      image: DecorationImage(
                        image: NetworkImage('https://via.placeholder.com/100'),
                        fit: BoxFit
                            .cover, // Ensure the image covers the entire container
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: MyMateThemes.primaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
      ),
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

  Widget RasiChartDesign() {
    return Container(
      height: 258,
      width: 258,
      color: MyMateThemes.containerColor,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 72,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 134,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 196,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 72,
            left: 10,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 134,
            left: 10,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 196,
            left: 10,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 72,
            left: 196,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 134,
            left: 196,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 196,
            left: 196,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 196,
            left: 134,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 196,
            left: 72,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 72,
            left: 72,
            child: Container(
              height: 114,
              width: 114,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  // Positioned(
                  //   top: 10,
                  //   left: 10,
                  //   child:
                  //   SvgPicture.asset(
                  //
                  //       'assets/images/heart.svg'),
                  //
                  // ),
                  Positioned(
                    bottom: 5,
                    left: 3,
                    child: Column(
                      children: [
                        Text(
                          'Hastam',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          'Virgo (kanni)',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget NavamsaChartDesign() {
    return Container(
      height: 258,
      width: 258,
      color: MyMateThemes.containerColor,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 72,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '02',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 134,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '03',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 196,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '04',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 72,
            left: 10,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '05',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 134,
            left: 10,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '06',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 196,
            left: 10,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '07',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 72,
            left: 196,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '08',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 134,
            left: 196,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '09',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 196,
            left: 196,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '10',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 196,
            left: 134,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '11',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 196,
            left: 72,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Text(
                      '12',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 72,
            left: 72,
            child: Container(
              height: 114,
              width: 114,
              decoration: BoxDecoration(
                color: MyMateThemes.primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    left: 2,
                    child: Column(
                      children: [
                        Text(
                          'Hastam',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          'Virgo (kanni)',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                  SizedBox(height: 40),
                  _buildSectionTitle("Astrology"),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 40),
                      SvgPicture.asset('assets/images/Line 11.svg'),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 140,
                        height: 172,
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: MyMateThemes.containerColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              left: 10,
                              child:
                                  SvgPicture.asset('assets/images/Group.svg'),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 5,
                              child: Column(
                                children: [
                                  Text(
                                    '19 OCT 1998',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: MyMateThemes.primaryColor,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '10.30 AM',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: MyMateThemes.textColor,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    'Jaffna, Sri Lanka',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: MyMateThemes.primaryColor,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        width: 140,
                        height: 172,
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: MyMateThemes.primaryColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 8,
                              left: 6.5,
                              child: SvgPicture.asset(
                                  'assets/images/Group 2217.svg'),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 48,
                              child: Column(
                                children: [
                                  Text(
                                    'Hastam',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    'Virgo (kanni)',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  _buildContainers(
                    children: [
                      RasiChartDesign(),
                      SizedBox(height: 40),
                      NavamsaChartDesign(),
                      SizedBox(height: 40),
                      _buildProfileDetails(),
                      SizedBox(height: 40),
                      _buildPhotoGallery(),
                      SizedBox(height: 40),
                    ],
                  ),
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
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final bool isActive;

  _CirclePainter({required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isActive ? MyMateThemes.primaryColor : Colors.grey[300]!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 12, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 2;

    double startX = size.width / 10;
    double endX = size.width - size.width / 10;
    double centerY = size.height / 2;

    canvas.drawLine(Offset(startX, centerY), Offset(endX, centerY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
