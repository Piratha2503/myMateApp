import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../ProfilePageScreen/MyProfileMain.dart';
import 'CompleteOne.dart';
import 'CompleteThree.dart';
import 'CompleteTwo.dart';

class CompleteProfilePage extends StatefulWidget {
  final String docId;
  const CompleteProfilePage({Key? key, required this.docId}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  int currentPage = 0;
  List<int> stepStates = [0, 0, 0];


  Map<String, dynamic> formData = {};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _buildStepIndicator(),
            SizedBox(height: 20),
            _buildCurrentPage(currentPage),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Complete Profile',
        style: TextStyle(
          color: MyMateThemes.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  FlutterStepIndicator _buildStepIndicator() {
    return FlutterStepIndicator(
      height: 24,
      paddingLine: const EdgeInsets.symmetric(horizontal: 0),
      positiveColor: MyMateThemes.primaryColor,
      progressColor: MyMateThemes.primaryColor.withOpacity(0.3),
      negativeColor: MyMateThemes.primaryColor.withOpacity(0.3),
      padding: const EdgeInsets.all(3),
      list: stepStates,
      onChange: (index) {},
      page: currentPage,
    );
  }

  // Build the current page and pass the formData to each page
  Widget _buildCurrentPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return PageOne(onSave: _onPageSaved,docId: widget.docId);
      case 1:
        return PageTwo(onSave: _onPageSaved,docId: widget.docId );
      case 2:
        return PageThree(onSave: _onPageSaved,docId:widget.docId);
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
