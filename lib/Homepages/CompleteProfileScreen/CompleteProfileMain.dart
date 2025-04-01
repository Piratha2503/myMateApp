import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/CompleteProfileScreen/Completegallerypage.dart';
import 'package:mymateapp/Homepages/HomeScreenBeforeSubscribe.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../ProfilePageScreen/MyProfileMain.dart';
import '../SubscribedhomeScreen/SubscribedHomeScreenStructured.dart';
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
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;

          return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(

              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height*0.02,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.005),
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
                            height: height * 0.015,
                          ),
                        ),
                        SizedBox(width: width*0.23,),
                        Text(
                          "Complete Profile",
                          style: TextStyle(
                            color: MyMateThemes.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.05,
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    ),
                  ),
                  SizedBox(height: height*0.05,),

                  _buildCustomStepIndicator(currentPage),
                  SizedBox(height: height*0.01,),
                  _buildCurrentPage(currentPage,),
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

  Widget _buildCustomStepIndicator(int currentPage) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4 * 2 - 1, (index) {
        if (index.isEven) {
          // Circle
          int stepIndex = index ~/ 2;
          bool isCompleted = stepIndex < currentPage;
          bool isCurrent = stepIndex == currentPage;

          return Container(
            width: width*0.07,
            height: height*0.04,
            decoration: BoxDecoration(
              color: isCompleted ? MyMateThemes.primaryColor : Colors.white,
              border: Border.all(
                color: isCompleted || isCurrent
                    ? MyMateThemes.primaryColor
                    : MyMateThemes.secondaryColor,
                width: width * 0.004,
              ),
              shape: BoxShape.circle,
            ),
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size:width*0.05)
                : null,
          );
        } else {
          // Line between circles
          int lineIndex = (index - 1) ~/ 2;
          return Container(
            width: width*0.2, // Adjust this to control line length
            height: height*0.0015,
            color: lineIndex < currentPage - 1
                ? MyMateThemes.primaryColor
                : MyMateThemes.primaryColor
          );
        }
      }),
    );
  }

  // Build the current page and pass the formData to each page
  Widget _buildCurrentPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return PageOne(onSave: _onPageSaved, docId: widget.docId);
      case 1:
        return Completegallerypage(onSave: _onPageSaved, docId: widget.docId);
      case 2:
        return PageTwo(onSave: _onPageSaved, docId: widget.docId);
      case 3:
        return PageThree(onSave: _onPageSaved, docId: widget.docId);
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
          builder: (context) => SubscribedhomescreenStructuredPage(docId: widget.docId,)
        ),
      );
    }
  }
}
