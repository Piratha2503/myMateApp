import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/CompleteProfileScreen/Completegallerypage.dart';
import 'package:mymateapp/Homepages/HomeScreenBeforeSubscribe.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../ProfilePageScreen/MyProfileMain.dart';
import 'CompleteOne.dart';
import 'CompleteThree.dart';
import 'CompleteTwo.dart';

class CompleteProfilePage extends StatefulWidget {
  final String docId;
  final int initialPageIndex;
  const CompleteProfilePage({Key? key, required this.docId,this.initialPageIndex = 0}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  int currentPage = 0;
  List<int> stepStates = [0, 0, 0,0];


  Map<String, dynamic> formData = {};


  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPageIndex; // Set initial page based on navigation
    for (int i = 0; i < currentPage; i++) {
      stepStates[i] = 1; // Mark previous steps as completed
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(

              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height*0.02,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.02),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreenBeforeSubscibe(0,docId: widget.docId,)),
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/images/chevron-left.svg',
                            height: height * 0.02,
                          ),
                        ),
                        SizedBox(width: width*0.2,),
                        Text(
                          "Complete Profile",
                          style: TextStyle(
                            color: MyMateThemes.textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: width * 0.045,
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    ),
                  ),
                  SizedBox(height: height*0.05,),
                  _buildStepIndicator(),
                  SizedBox(height: height*0.01,),
                  _buildCurrentPage(currentPage,constraints),
                  SizedBox(height: height*0.01,),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  AppBar _buildAppBar() {
    return
      AppBar(
      title:
      Text(
        'Complete Profile',
        style: TextStyle(
          color: MyMateThemes.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  LayoutBuilder _buildStepIndicator() {
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
        return FlutterStepIndicator(
          height: 24,
          paddingLine:  EdgeInsets.symmetric(horizontal: 0),
          positiveColor: MyMateThemes.primaryColor,
          progressColor: MyMateThemes.primaryColor.withOpacity(0.3),
          negativeColor: MyMateThemes.primaryColor.withOpacity(0.3),
          padding:  EdgeInsets.all(width*0.01),
          list: stepStates,
          onChange: (index) {},
          page: currentPage,
        );
      }
    );
  }

  // Build the current page and pass the formData to each page
  Widget _buildCurrentPage(int currentPage, BoxConstraints constraints) {
    switch (currentPage) {
      case 0:
        return PageOne(onSave: _onPageSaved, docId: widget.docId, constraints: constraints);
      case 1:
        return Completegallerypage(onSave: _onPageSaved, docId: widget.docId, constraints: constraints);
      case 2:
        return PageTwo(onSave: _onPageSaved, docId: widget.docId, constraints: constraints);
      case 3:
        return PageThree(onSave: _onPageSaved, docId: widget.docId, constraints: constraints);
      default:
        return SizedBox();
    }
  }


  void _onPageSaved() {
    if (currentPage < stepStates.length - 1) {
      setState(() {
        stepStates[currentPage] = 1;
        currentPage++;
      });
    } else {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            docId: widget.docId, selectedBottomBarIconIndex: 3,
          ),
        ),
      );
    }
  }
}
