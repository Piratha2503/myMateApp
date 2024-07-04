import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'bottom_navigation_bar.dart';
import 'custom_outline_button.dart';

class OtherProfilePage extends StatefulWidget {
  const OtherProfilePage({super.key});

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  int _selectedIndex = 0;
  int _selectedButtonIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool isSecondContainerVisible = false;
  bool isThirdContainerVisible = false;
  bool isFourthContainerVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double containerHeight = 500.0;
    int newIndex = (_scrollController.offset / containerHeight).floor();
    if (newIndex != _selectedButtonIndex) {
      setState(() {
        _selectedButtonIndex = newIndex;
      });
    }
  }

  bool isButtonSelected(int index) {
    return _selectedButtonIndex == index;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    _buildProfileDetails(),
                    _buildBioSection(),
                    SizedBox(height: 15),
                    _buildVisibleContainer(
                        isSecondContainerVisible, 'Container 2'),
                    SizedBox(height: 15),
                    _buildVisibleContainer(
                        isThirdContainerVisible, 'Container 3'),
                    SizedBox(height: 15),
                    _buildVisibleContainer(
                        isFourthContainerVisible, 'Container 4'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildOutlineButtons(),
          SizedBox(height: 10),
          _buildGetStartedButton(),
          SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: MyMateThemes.backgroundColor,
      title: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // Handle back button press
              },
              child: SvgPicture.asset('assets/images/chevron-left.svg'),
            ),
            SizedBox(width: 110),
            Text(
              '@user240676',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        SizedBox(height: 10),
        SvgPicture.asset('assets/images/Group 2073 (1).svg'),
        SizedBox(height: 25),
        Text(
          'Full Name',
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
    );
  }

  Widget _buildProfileDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDetailColumn(
            'assets/images/Group 2145.svg', '27 Years', '12 Dec 1997'),
        _buildDivider(),
        _buildDetailColumn(
            'assets/images/Group 2146.svg', 'Teacher', 'Mannar - SL'),
        _buildDivider(),
        _buildDetailColumn(
            'assets/images/Group 2147.svg', 'Jaffna', 'Sri Lanka'),
      ],
    );
  }

  Widget _buildDetailColumn(String assetPath, String text1, String text2) {
    return Container(
      foregroundDecoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: MyMateThemes.secondaryColor, width: 3),
        ),
      ),
      child: Column(
        children: [
          SvgPicture.asset(assetPath),
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

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: VerticalDivider(
        width: 40,
        thickness: 2,
        indent: 40,
        endIndent: 100,
        color: MyMateThemes.secondaryColor,
      ),
    );
  }

  Widget _buildBioSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 340,
          height: 100,
          color: MyMateThemes.secondaryColor,
          child: const Center(
            child: Text(
              'Bio (192 letters)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVisibleContainer(bool isVisible, String text) {
    return Visibility(
      visible: isVisible,
      child: Container(
        width: 340,
        height: 500,
        color: MyMateThemes.secondaryColor,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MyMateThemes.textColor,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButtons() {
    return Row(
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
    );
  }

  Widget _buildGetStartedButton() {
    return SizedBox(
      width: 132.0,
      height: 39.0,
      child: OutlinedButton(
        onPressed: () {
          print('Button pressed');
        },
        style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        ),
        child: Text(
          'Get Started ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
