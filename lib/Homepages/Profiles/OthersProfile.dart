import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Homepages/Profiles/MoreAboutMe.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../dbConnection/Firebase.dart';
import '../CheckMatch.dart';
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
  final ScrollController _scrollController = ScrollController();
  List<TextEditingController> controllers = [];
  bool isLoading = true;


  final Firebase firebase = Firebase();

  /// Fetch data from API using fetchUserById
  Future<void> getClient() async {
    try {
      final data = await fetchUserById(widget.docId);

      if (data.isNotEmpty) {
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
          profilePictureUrl =data['profile_pic_url'] ?? "N/A";
          address = data['address'] ?? "N/A";
          isLoading = false;
          var expectations = data['expectations'] ?? [];

          print('Profile Picture URL: $profilePictureUrl');

          if (expectations is List<String>) {
            controllers = expectations
                .map((expectation) => TextEditingController(text: expectation))
                .toList();
          } else if (expectations is List) {
            controllers = expectations
                .whereType<String>()
                .map((expectation) => TextEditingController(text: expectation))
                .toList();
          } else {
            controllers = [];
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Profile Picture URL: $profilePictureUrl');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Client data not found!')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

  }



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
  Widget _buildIconWithText(String iconPath, String age, String dob) {
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
            age,
            style: TextStyle(
              color: MyMateThemes.textColor,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            dob,
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
              foregroundColor: Colors.white
          ),
          child: Text('Send Request '),
        ),
        SizedBox(width: 30),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckmatchPage(docId: widget.docId,)),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: MyMateThemes.primaryColor,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0),),
              foregroundColor: Colors.white
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
                _buildInfoRow('Father\'s Name', data['first_name'] ?? 'N/A'),
                _buildInfoRow('Mother\'s Name', data['mother_name'] ?? 'N/A'),
                _buildInfoRow(
                    'Siblings', data['num_of_siblings']?.toString() ?? 'N/A'),
                _buildInfoRow('Age', data['age']?.toString() ?? 'N/A'),
                _buildInfoRow(
                    'Date of Birth', data['dob']?.toString() ?? 'N/A'),
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
        }
    );

  }
  Widget _buildInfoRow(String title, String value) {
    return Container(
      height: 34,
      width: 297,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: MyMateThemes.containerColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          // Fixed width for title
          Container(
            width: 120, // Adjust the width based on your design
            child: Text(
              title,
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 50), // Space between title and value

          // Scrollable text for value
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                value,
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                softWrap: false,
                overflow: TextOverflow.visible,
              ),
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
      children: List.generate(
        controllers.length,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child:Container(
              height: 34,
              width: 297,
              margin: EdgeInsets.symmetric(vertical: 5.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: MyMateThemes.containerColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                  Text(
                    controllers[index].text,
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.visible,
                  ),

                ),

              ),
            ),

          ),
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
                      _buildIconWithText(
                          'assets/images/Group 2145.svg', '$age years', dob),
                      _buildIconWithText('assets/images/Group 2146.svg',
                          occupation, '$city  '),
                      _buildIconWithText('assets/images/Group 2147.svg',
                          city, '$country'),
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
                                    dob,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: MyMateThemes.primaryColor,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    dot,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: MyMateThemes.textColor,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '$city ,$country  ',
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
                                    natchathiram,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    rasi,
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
                      PhotoGallery(docId: widget.docId),
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
          SizedBox(height: 10),

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