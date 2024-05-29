import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mymateapp/Homepages/MyProfile.dart';
import 'package:mymateapp/MyMateThemes.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  int currentPage = 0;
  List<int> stepStates = [0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          _buildStepIndicator(),
          Expanded(child: _buildCurrentPage(currentPage)),
          _buildNextButton(),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/images/chevron-left.svg'),
            ),
            SizedBox(width: 100),
            Text(
              'Complete Profile',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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

  Widget _buildCurrentPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return PageOne();
      case 1:
        return PageTwo();
      case 2:
        return PageThree();
      default:
        return SizedBox();
    }
  }

  ElevatedButton _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        if (currentPage < stepStates.length - 1) {
          setState(() {
            currentPage++;
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage(docId: "",)),
          );
        }
      },
      style: const ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(MyMateThemes.backgroundColor),
        backgroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ),
      child: Text(currentPage < stepStates.length - 1 ? 'Next' : 'Complete'),
    );
  }
}

class PageOne extends StatefulWidget {
  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  File? _imageFile;

  void _chooseImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      File? croppedFile = (await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,
      )) as File?;

      if (croppedFile != null) {
        setState(() {
          _imageFile = croppedFile;
        });
      }
    }
  }

  void _openPopupScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 300,
            width: 400,
            child: Column(
              children: [
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    _chooseImage(ImageSource.gallery);
                  },
                  child: SvgPicture.asset('assets/images/choose.svg'),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  child: SvgPicture.asset('assets/images/or.svg'),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    _chooseImage(ImageSource.camera);
                  },
                  child: SvgPicture.asset('assets/images/take.svg'),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset('assets/images/Active.svg'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),
          Text("Update Your Profile"),
          SizedBox(height: 20),
          Stack(
            children: [
              GestureDetector(
                onTap: _openPopupScreen,
                child: _imageFile != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(_imageFile!),
                      )
                    : SvgPicture.asset('assets/images/circle.svg'),
              ),
              Positioned(
                child: GestureDetector(
                  onTap: _openPopupScreen,
                  child: SvgPicture.asset('assets/images/edit.svg'),
                ),
                bottom: -1,
                left: 95,
              ),
            ],
          ),
          SizedBox(height: 60),
          Text("Upload to gallery(Optional)"),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              _chooseImage(ImageSource.gallery);
            },
            child: SvgPicture.asset('assets/images/cloud.svg'),
          ),
          SizedBox(height: 20),
          GestureDetector(
            child: SvgPicture.asset('assets/images/orr.svg'),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              _chooseImage(ImageSource.camera);
            },
            child: SvgPicture.asset('assets/images/took.svg'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  bool isChecked = false;
  String? _selectedCivilStatus;
  String? _selectedEmploymentType;
  String? _selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
          _buildDropdownRow(
            label: "Civil Status",
            value: _selectedCivilStatus,
            items: [
              '--  Select Option  --',
              'Unmarried',
              'Divorced',
              'Widowed'
            ],
            onChanged: (value) => setState(() {
              _selectedCivilStatus = value;
            }),
          ),
          SizedBox(height: 10),
          _buildDropdownRow(
            label: "Employment Type",
            value: _selectedEmploymentType,
            items: [
              '--  Select Option  --',
              'Government',
              'Private',
              'Self Employed',
              'Unemployed'
            ],
            onChanged: (value) => setState(() {
              _selectedEmploymentType = value;
            }),
          ),
          SizedBox(height: 10),
          _buildTextFieldRow(
            label: "Occupation",
            hintText: "Enter your Occupation",
          ),
          SizedBox(height: 10),
          _buildTextFieldRow(
            label: "Height",
            hintText: "Enter your height",
          ),
          SizedBox(height: 10),
          _buildDropdownRow(
            label: "District",
            value: _selectedDistrict,
            items: ['--  Select Option  --', 'Jaffna', 'Colombo'],
            onChanged: (value) => setState(() {
              _selectedDistrict = value;
            }),
          ),
          SizedBox(height: 10),
          _buildTextFieldRow(
            label: "Education",
            hintText: "Enter your Education",
          ),
          SizedBox(height: 10),
          _buildCodeVerificationRow(),
          SizedBox(height: 10),
          _buildTextFieldRow(
            label: "Contact Number",
            hintText: "Enter your Contact Number",
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownRow({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: 346,
      height: 46,
      color: MyMateThemes.secondaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: MyMateThemes.textColor)),
          Spacer(),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: item == '-- Select Option --'
                      ? TextStyle(color: Colors.grey)
                      : TextStyle(color: MyMateThemes.textColor),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldRow({required String label, required String hintText}) {
    return Container(
      width: 346,
      height: 46,
      color: MyMateThemes.secondaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15),
          Text(label, style: TextStyle(color: MyMateThemes.textColor)),
          Spacer(),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle:
                    TextStyle(color: MyMateThemes.textColor.withOpacity(0.5)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              style: TextStyle(color: MyMateThemes.textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeVerificationRow() {
    return Container(
      width: 360,
      height: 65,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Enter the code from the sms we sent xxxxxxxxxxxxxxxxxxxx yyyyyyyyyyyyyyyyyyy to +94 7x xxx xxx",
                style: TextStyle(color: MyMateThemes.textColor),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Checkbox(
                value: isChecked,
                onChanged: (newValue) {
                  setState(() {
                    isChecked = newValue!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageThree extends StatefulWidget {
  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  String? _selectedReligion;
  String? _selectedLanguage;
  String? _selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
          _buildDropdownRow(
            label: "Religion",
            value: _selectedReligion,
            items: [
              '--  Select Option  --',
              'Hindu',
              'Christian',
              'Muslim',
              'Buddhist'
            ],
            onChanged: (value) => setState(() {
              _selectedReligion = value;
            }),
          ),
          SizedBox(height: 15),
          _buildTextFieldRow(
            label: "Caste",
            hintText: "Enter your Caste",
          ),
          SizedBox(height: 10),
          _buildDropdownRow(
            label: "Language",
            value: _selectedLanguage,
            items: ['--  Select Option  --', 'Tamil', 'Sinhala', 'English'],
            onChanged: (value) => setState(() {
              _selectedLanguage = value;
            }),
          ),
          SizedBox(height: 10),
          _buildTextFieldRow(
            label: "No of Siblings",
            hintText: "Enter Number",
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownRow({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: 346,
      height: 46,
      color: MyMateThemes.secondaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: MyMateThemes.textColor)),
          Spacer(),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: item == '-- Select Option --'
                      ? TextStyle(color: Colors.grey)
                      : TextStyle(color: MyMateThemes.textColor),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldRow({required String label, required String hintText}) {
    return Container(
      width: 346,
      height: 46,
      color: MyMateThemes.secondaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15),
          Text(label, style: TextStyle(color: MyMateThemes.textColor)),
          Spacer(),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle:
                    TextStyle(color: MyMateThemes.textColor.withOpacity(0.5)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              style: TextStyle(color: MyMateThemes.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
