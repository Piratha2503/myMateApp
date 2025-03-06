import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../ProfilePageScreen/MyProfileStatelessWidgets.dart';
import '../checkMatchPages/CheckMatch.dart';
import '../ProfilePageScreen/navamsaChartDesign.dart';
import '../ProfilePageScreen/photoGalleryPage.dart';
import '../ProfilePageScreen/rasiChartDesign.dart';
import '../custom_outline_button.dart';
import '../explorePage/explorePageMain.dart';

class OtherProfilePage extends StatefulWidget {
  final String SoulId;

  const OtherProfilePage({required this.SoulId, super.key});

  String get soulDocId => SoulId;

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
  bool isBookmarked = false; // Track bookmark state

  String _notificationStatus ="";


  final GlobalKey _anchorKey1 = GlobalKey();
  final GlobalKey _anchorKey2 = GlobalKey();
  final GlobalKey _anchorKey3 = GlobalKey();



  Future<String?> getSavedDocId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('docId');

  }

  Future <String?> getSavedToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


  Future<void> _updateNotificationStatus(String status) async {
    final senderDocId = await getSavedDocId();
    final receiverDocId = widget.SoulId;
    final String? receiverToken = await getSavedToken();
    final senderName = await _fetchdetails(senderDocId);
    final url = Uri.parse(
      "https://backend.graycorp.io:9000/mymate/api/v1/requestSending?sender_docId=$senderDocId&receiver_docId=$receiverDocId&notification_status=$status",
    );

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print("Notification status updated successfully to $status");
        _checkNotificationStatus();

        // String? receiverToken = 'eZSq6wLcQUy7bb4-ykFkfG:APA91bGlLxNqvzOJO4pXrgnIx7XJKEvIHVxboz6WM6hJOz8kyr2ETQR0oVukTCmH6NKQ9v9jTSu7qFOEd56d-obZ9i32OuA4XjXCI1leTVfBUIFW2vWwUIA';
        // await _fetchFCMToken(receiverDocId);

        // if (receiverToken != null) {
        //   await NotificationService.sendPushNotification(receiverToken, senderName, status);
        // }

      } else {
        print("Failed to update notification status. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error updating notification status: $e");
    }
  }

  Future<String> _fetchdetails(String? docId) async {
    final senderDocId = await getSavedDocId();


    final url = Uri.parse("https://backend.graycorp.io:9000/mymate/api/v1/getClientDataByDocId?docId=$senderDocId");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['personalDetails']['full_name'] ?? "Unknown User";

      } else {
        print(" Failed to fetch sender's name: ${response.statusCode}");
        return "Unknown User";
      }
    } catch (e) {
      print(" Error fetching sender's name: $e");
      return "Unknown User";
    }
  }



  Future<void> _checkNotificationStatus() async {
    final senderDocId = await getSavedDocId();
    final receiverDocId = widget.SoulId;
    try {
      final url = Uri.parse(
        'https://backend.graycorp.io:9000/mymate/api/v1/checkNotificationStatus?sender_docId=$senderDocId&receiver_docId=$receiverDocId',
      );

      final response = await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        setState(() {
          _notificationStatus = response.body.trim();
          print(_notificationStatus);
        });
      } else {
        print('Failed to fetch notification status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error checking notification status: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getClient() async {
    try {
      final data = await fetchUserById(widget.SoulId);

      if (data.isNotEmpty) {
        setState(() {
          full_name = data['full_name'] ?? "N/A";
          gender = data['gender'] ?? "N/A";
          education = data['education'] ?? "N/A";
          city = data['city'] ?? "N/A";
          occupation = data['occupation'] ?? "N/A";
          mobile = data['mobile'].toString() ?? "N/A";
          religion = data['religion'] ?? "N/A";
          age = data['age']?.toString() ?? "N/A";
          dob = data['dob'] ?? "N/A";
          dot = data['dot'] ?? "N/A";
          country = data['country'] ?? "N/A";
          rasi = data['rasi'] ?? "N/A";
          natchathiram = data['natchathiram'] ?? "N/A";
          profilePictureUrl = data['profile_pic_url'] ?? "N/A";
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
    _checkNotificationStatus();
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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min, // Prevent Row from taking extra space
          children: [
            // Back Button (SVG)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExplorePage(
                      results: [],
                      initialTabIndex: 0,
                      search: [],
                      docId: '',
                    ),
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/images/chevron-left.svg',
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ),

            SizedBox(width: MediaQuery.of(context).size.width * 0.02), // Small spacing
            Spacer(), // Pushes icons to the right

            // Profile Name
            Text(
              "@ $full_name",
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),

            Spacer(), // Pushes icons to the right

            // Bookmark Icon
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: MyMateThemes.primaryColor,
              ),
              onPressed: () {
                setState(() {
                  isBookmarked = !isBookmarked;
                });
              },
            ),

            // Kebab Menu (Three Dots)
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: MyMateThemes.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
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
                          : MediaQuery.of(context).size.width * 0.45,
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
          onTap: _toggleSize,
          child: Column(
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconWithText(String iconPath, String text1, String text2) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      height: MediaQuery.of(context).size.height * 0.1,
      foregroundDecoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: MyMateThemes.secondaryColor,
            width: MediaQuery.of(context).size.width * 0.005,
          ),
        ),
      ),
      child: Column(
        children: [
          SvgPicture.asset(iconPath,
            width: MediaQuery.of(context).size.width * 0.08,
            height: MediaQuery.of(context).size.width * 0.08,),
          SizedBox(height: MediaQuery.of(context).size.height * 0.007),
          Text(
            text1,
            style: TextStyle(
              color: MyMateThemes.textColor,
              fontSize: MediaQuery.of(context).size.width * 0.03,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              color: MyMateThemes.primaryColor,
              fontSize: MediaQuery.of(context).size.width * 0.025,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildActionButtons() {
    String buttonText;
    VoidCallback? buttonAction;

    if (_notificationStatus == "New") {
      buttonText = "Send Request";
      buttonAction = () {
        _showConfirmationDialog(
          "Are you sure you want to send the request?",
          onConfirm: () => _updateNotificationStatus("Request_Sent"),
        );
      };
    } else if (_notificationStatus == "Request_Sent") {
      buttonText = "Request Sent";
      buttonAction = null;
    } else if (_notificationStatus == "Request Received") {
      buttonText = "Accept Request";
      buttonAction = () {
        _showConfirmationDialog(
          "Are you sure you want to accept the request?",
          onConfirm: () => _updateNotificationStatus("Accept"),
        );
      };
    } else if (_notificationStatus == "Accept") {
      buttonText = "Connected";
      buttonAction = null;
    } else {
      buttonText = "Send Request";
      buttonAction = () {
        _showConfirmationDialog(
          "Are you sure you want to send the request?",
          onConfirm: () => _updateNotificationStatus("Request_Sent"),
        );
      };
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      SizedBox(
       height:MediaQuery.of(context).size.height * 0.06 ,
       width: MediaQuery.of(context).size.width * 0.35,
          child: ElevatedButton(
            onPressed: buttonAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonAction == null
                  ? Colors.grey
                  : MyMateThemes.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.025),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.015,
              ),
              foregroundColor: Colors.white,
            ),
            child: Text(buttonText),
          ),
        ),
        SizedBox(width: 30),
        SizedBox(
          height:MediaQuery.of(context).size.height * 0.06 ,
          width: MediaQuery.of(context).size.width * 0.35,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CheckmatchPage(
                      soulDocId: widget.SoulId,
                      clientDocId: 'E0JFHhK2x6Gq2Ac6XSyP',
                    )),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: MyMateThemes.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.025),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.015,
                ),
                foregroundColor: Colors.white),
            child: Text('Check Match'),
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(String message, {required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmation"),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        SvgPicture.asset(
          'assets/images/Group 2148.svg',
          width: MediaQuery.of(context).size.width * 0.05,
          height: MediaQuery.of(context).size.width * 0.05,
        ),        SizedBox(width: 4),
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

  Widget _buildContainers({required List<Widget> children}) {
    return Column(
      children: children,
    );
  }

  Widget _buildProfileDetails() {
    return FutureBuilder<Map<String, dynamic>>(
        future: fetchUserById(widget.SoulId),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }
           if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final data = snapshot.data!;

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                _buildSectionTitle('About me'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.007),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                    SvgPicture.asset(
                      'assets/images/Line 11.svg',
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                _buildInfoRow('Full Name', data['full_name'] ?? 'N/A'),
                _buildInfoRow('Education', data['education'] ?? 'N/A'),
                _buildInfoRow('Height', '${data['height'] ?? 'N/A'} CM'),
                _buildInfoRow('Religion', data['religion'] ?? 'N/A'),
                _buildInfoRow('Language', data['language'] ?? 'Tamil, English'),
                _buildInfoRow('Caste', data['caste'] ?? 'Optional'),
                _buildInfoRow('Father\'s Name', data['first_name'] ?? 'N/A'),
                _buildInfoRow('Mother\'s Name', data['mother_name'] ?? 'N/A'),
                _buildInfoRow('Siblings', data['num_of_siblings']?.toString() ?? 'N/A'),
                _buildInfoRow('Age', data['age']?.toString() ?? 'N/A'),
                _buildInfoRow('Date of Birth', data['dob']?.toString() ?? 'N/A'),
                _buildInfoRow('Mobile', data['contact'] ?? 'N/A'),
                _buildInfoRow('Address', data['address'] ?? 'N/A'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.045),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    Text(
                      'Expectations',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                _buildExpectations(),
              ],
            ),
          );
        });
  }

  Widget _buildInfoRow(String title, String value) {
    double containerWidth = MediaQuery.of(context).size.width * 0.8;
    double containerHeight = MediaQuery.of(context).size.height * 0.05;
    double fontSize = MediaQuery.of(context).size.width * 0.04;

    return Container(
      height: containerHeight,
      width: containerWidth,
      margin: EdgeInsets.symmetric(vertical: containerHeight * 0.13),
      padding: EdgeInsets.all(containerHeight * 0.2),
      decoration: BoxDecoration(
        border: Border.all(
          color: MyMateThemes.textColor.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(containerWidth * 0.01), // Dynamic border radius
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: MyMateThemes.textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: MyMateThemes.textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );  }

  Widget _buildExpectations() {
    double containerWidth = MediaQuery.of(context).size.width * 0.8;
    double containerHeight = MediaQuery.of(context).size.height * 0.05;
    double fontSize = MediaQuery.of(context).size.width * 0.04;

    return Column(
      children: List.generate(
        controllers.length,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Container(
              height: containerHeight,
              width: containerWidth,
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyMateThemes.textColor.withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(containerWidth * 0.01), // Dynamic border radius
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  controllers[index].text,
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                  softWrap: false,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBar() {
    return FutureBuilder<String?>(
      future: getSavedDocId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading docId'));
        } else {
          final docId = snapshot.data ?? '';
          return CustomBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            docId: docId,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor:Colors.white,
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
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconWithText('assets/images/Group 2145.svg', '$age years', dob),
                      _buildIconWithText('assets/images/Group 2146.svg', occupation, '$city'),
                      _buildIconWithText('assets/images/Group 2147.svg', city, '$country'),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  _buildActionButtons(),
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

                  _buildContainers(
                    children: [


                      // 🌟 Add anchor point before Astrology section
                      SizedBox(key: _anchorKey1),
                      SizedBox(height: screenHeight * 0.06),
                      AstrologySection(),


                      // 🌟 Add anchor point before Profile Details section
                      SizedBox(key: _anchorKey2),
                      SizedBox(height: screenHeight * 0.06),
                      _buildProfileDetails(),



                      // 🌟 Add anchor point before Photo Gallery section
                      SizedBox(key: _anchorKey3),
                      SizedBox(height: screenHeight * 0.06),

                      PhotoGallery(docId: widget.SoulId),
                    ],
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.06),
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