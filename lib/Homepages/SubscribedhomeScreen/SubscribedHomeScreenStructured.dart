import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../BadgeWidget.dart';
import '../CompleteProfileScreen/CompleteProfileMain.dart';
import '../checkMatchPages/checkMatchOptions.dart';
import 'SubscribedHomeScreenWidgets.dart';

class SubscribedhomescreenStructuredPage extends StatefulWidget {
  final String docId;
  const SubscribedhomescreenStructuredPage({super.key, required this.docId});

  @override
  State<SubscribedhomescreenStructuredPage> createState() =>
      _SubscribedhomescreenStructuredPageState();
}

class _SubscribedhomescreenStructuredPageState
    extends State<SubscribedhomescreenStructuredPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getClient();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPopupDialog();
      print("Subscribe HomeScreen docId:- \${widget.docId}");
    });
  }

  int badgeValue1 = 2;
  int badgeValue2 = 10;
  String name = 'Your Name';

  Future<void> getClient() async {
    final data = await fetchUserById(widget.docId);

    if (data.isNotEmpty) {
      setState(() {
        name = data['full_name'] ?? "N/A";
      });

      final completeProfilePending = data['completeProfilePending'];
      if (completeProfilePending != null) {
        if (completeProfilePending['_page1_complete'] == false) {
          _navigateToCompleteProfilePage(0);
        } else if (completeProfilePending['_page2_complete'] == false) {
          _navigateToCompleteProfilePage(2);
        } else if (completeProfilePending['_page3_complete'] == false) {
          _navigateToCompleteProfilePage(3);
        }
      }
    } else {
      print("Data is Empty");
    }
  }

  void _navigateToCompleteProfilePage(int pageIndex) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CompleteProfilePage(
          docId: widget.docId,
          initialPageIndex: pageIndex,
        ),
      ),
    );
  }

  void _showPopupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SubscribedhomescreenStructuredPagePopupDialogWidget(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      body: LayoutBuilder(

        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
          return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
                  child: AppBar(
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    title: Text(
                      name,
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: constraints.maxWidth * 0.045,
                      ),
                    ),
                    actions: <Widget>[
                      BadgeWidget(assetPath: 'assets/images/Group 2157.svg', badgeValue: badgeValue1),
                      SizedBox(width: 15),
                      // BadgeWidget(assetPath: 'assets/images/Group 2153.svg', badgeValue: badgeValue2),
                      // SizedBox(width: 20)
                    ],
                  ),
                ),

                SubscribedhomescreenStructuredPageTotalMatchColumn(context, widget.docId),
                 SizedBox(height: height * 0.02),

                Center(
                  child: Text(
                    'View Matches',
                    style: TextStyle(
                      color: MyMateThemes.primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Expanded(
                  child: SubscribeHomeScreenStructuredPageCarouselSliders(docId: widget.docId),
                ),
                SizedBox(height: height * 0.01),
                SubscribedhomescreenStructuredPageTokenContainers(context, widget.docId),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
                  child: SizedBox(
                    width: double.infinity,
                    height: height * 0.1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckMatchOptionsScreen(
                              soulDocId: '',
                              clientDocId: 'E0JFHhK2x6Gq2Ac6XSyP',
                            ),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(MyMateThemes.primaryColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Check Match',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                              ),
                ),
              ],

          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        docId: widget.docId,
      ),
    );
  }
}
