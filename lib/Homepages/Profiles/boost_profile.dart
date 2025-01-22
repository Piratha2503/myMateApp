import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../ProfilePageScreen/MyProfileMain.dart';

class boostprofile extends StatefulWidget {
  final String docId;

  const boostprofile({required this.docId});

  @override
  State<boostprofile> createState() => _boostprofileState();
}

class _boostprofileState extends State<boostprofile> {
  int _boostDays = 1;
  int _superBoostDays = 1;
  int _noOfTokens = 1;
  int _selectedTabIndex = 0;
  bool isLoading = true;
  bool _isButtonClicked = false;

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: MyMateThemes.backgroundColor,
      title: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage(selectedBottomBarIconIndex: 3, docId: widget.docId,)));
              },
              child: SvgPicture.asset('assets/images/chevron-left.svg'),
            ),
            SizedBox(width: 70.0),
            Center(
              child: Text(
                "Boost Profile",
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _handleComplete() {
    if (_selectedTabIndex == 0) {
      _updateProfileType("Boosted");
    } else {
      _updateProfileType("Super Boosted");
    }
  }


  Future<void> _updateProfileType(String profileType) async {
    setState(() {
      isLoading = true;
    });

    final apiUrl = "https://backend.graycorp.io:9000/mymate/api/v1/updateClient";




    final payload = {
      "docId": widget.docId,
      "profile_type": profileType,
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile updated successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update profile: ${response.reasonPhrase}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }


  void _updateTokens() {
    setState(() {
      if (_selectedTabIndex == 0) {
        _noOfTokens = _boostDays;
      } else {
        _noOfTokens = _superBoostDays * 2;
      }
    });
  }

  void _handleDayIncrement() {
    setState(() {
      if (_selectedTabIndex == 0) {
        _boostDays++;
      } else {
        _superBoostDays++;
      }
      _updateTokens();
    });
  }

  void _handleDayDecrement() {
    setState(() {
      if (_selectedTabIndex == 0 && _boostDays > 1) {
        _boostDays--;
      } else if (_selectedTabIndex == 1 && _superBoostDays > 1) {
        _superBoostDays--;
      }
      _updateTokens();
    });
  }

  void _handleTabChange(int index) {
    setState(() {
      _selectedTabIndex = index;
      _updateTokens();
    });
  }

  void _handleClear() {
    setState(() {
      if (_selectedTabIndex == 0) {
        _boostDays = 1;
      } else {
        _superBoostDays = 1;
      }
      _updateTokens();
    });
  }

  void _handleButtonClick() {
    setState(() {
      _isButtonClicked = !_isButtonClicked;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildBoostContainer(
              context,
              title: 'Boost',
              description:
              'Your profile will be boosted. It helps you that your profile will be prioritized suggestions to others every searches. It takes 1 token per day.',
              tokensPerDay: '× 1 Token per day',
              backgroundColor: MyMateThemes.containerColor,
              textColor: MyMateThemes.textGray,
              titlecolor: MyMateThemes.textGray,
            ),
            const SizedBox(height: 16),
            buildBoostContainer(
              context,
              title: 'Super Boost',
              description:
              'Your profile will be boosted. It helps you that your profile will be highly prioritized suggestions to others every searches. It takes 2 tokens per day.',
              tokensPerDay: '× 2 Tokens per Day',
              backgroundColor: MyMateThemes.primaryColor,
              textColor: Colors.white,
              titlecolor: MyMateThemes.premiumAccent,
            ),
            const SizedBox(height: 16),
            _buildBoostCount(),
          ],
        ),
      ),
    );
  }

  Widget _buildBoostCount() {
    return DefaultTabController(
      length: 2,
      child: Expanded(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: MyMateThemes.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: MyMateThemes.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: MyMateThemes.primaryColor,
                  labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  tabs: [
                    _buildTabButton('Boost'),
                    _buildTabButton('Super Boost'),
                  ],
                  onTap: _handleTabChange,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                children: [
                  _buildBoostContent(
                    noOfDays: _boostDays,
                    noOfTokens: _noOfTokens,
                  ),
                  _buildBoostContent(
                    noOfDays: _superBoostDays,
                    noOfTokens: _noOfTokens,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _handleClear();
                      _handleButtonClick(); // Change button colors
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      _isButtonClicked ? MyMateThemes.primaryColor : MyMateThemes.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        color: _isButtonClicked ? Colors.white : MyMateThemes.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _handleComplete();
                      _handleButtonClick(); // Change button colors
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      _isButtonClicked ? MyMateThemes.backgroundColor : MyMateThemes.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Complete',
                      style: TextStyle(
                        color: _isButtonClicked ? MyMateThemes.primaryColor : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoostContent({
    required int noOfDays,
    required int noOfTokens,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCounterRow(
            label: "No of Days",
            value: noOfDays,
            onIncrement: _handleDayIncrement,
            onDecrement: _handleDayDecrement,
            showLightningBolt: false,
            showControls: true,
          ),
          const SizedBox(height: 16),
          _buildCounterRow(
            label: "No of Tokens",
            value: noOfTokens,
            showLightningBolt: true,
            showControls: false,
          ),
        ],
      ),
    );
  }
}

Tab _buildTabButton(String title) {
  return Tab(
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title),
    ),
  );
}

Widget buildBoostContainer(
    BuildContext context, {
      required String title,
      required Color titlecolor,
      required String description,
      required String tokensPerDay,
      required Color backgroundColor,
      required Color textColor,
    }) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/firenew.svg',
                      height: 16.0,
                      width: 16.0,
                      color: textColor,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      tokensPerDay,
                      style: TextStyle(
                        color: textColor.withOpacity(0.8),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  title,
                  style: TextStyle(
                    color: titlecolor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8.0),
            SvgPicture.asset(
              'assets/images/lightning-bolt.svg',
              height: 24.0,
              width: 24.0,
              color: title == 'Super Boost'
                  ? MyMateThemes.premiumAccent
                  : textColor,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Text(
          description,
          style: TextStyle(
            color: textColor.withOpacity(0.7),
            fontSize: 14.0,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCounterRow({
  required String label,
  required int value,
  required bool showLightningBolt,
  required bool showControls,
  Function()? onIncrement,
  Function()? onDecrement,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16.0),
      ),
      Row(
        children: [
          if (showControls)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: onDecrement,
                color: Colors.grey,
                splashRadius: 20.0,
              ),
            ),
          // Conditionally apply the padding for "No of Tokens" only
          if (label == "No of Tokens")
            Padding(
              padding: const EdgeInsets.only(right: 55.0), // Adjust padding as needed
              child: Container(
                width: 73,
                height: 27,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showLightningBolt)
                      SvgPicture.asset(
                        'assets/images/firenew.svg',
                        height: 16.0,
                        width: 16.0,
                        color: MyMateThemes.primaryColor,
                      ),
                    if (showLightningBolt) const SizedBox(width: 4.0),
                    Text(
                      value.toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              width: 73,
              height: 27,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showLightningBolt)
                    SvgPicture.asset(
                      'assets/images/firenew.svg',
                      height: 16.0,
                      width: 16.0,
                      color: MyMateThemes.primaryColor,
                    ),
                  if (showLightningBolt) const SizedBox(width: 4.0),
                  Text(
                    value.toString().padLeft(2, '0'),
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          if (showControls)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: onIncrement,
                color: MyMateThemes.primaryColor,
                splashRadius: 20.0,
              ),
            ),
        ],
      ),
    ],
  );
}
