import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:mymateapp/Homepages/MyProfile.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:mymateapp/Homepages/MyProfile.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);
  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  int currentPage = 0;
  List<int> stepStates = [0, 0, 0]; // Use integers to represent step states

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle back button press
                    },
                    child: SvgPicture.asset(
                      'assets/images/chevron-left.svg',
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
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
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          FlutterStepIndicator(
            height: 24,
            paddingLine: const EdgeInsets.symmetric(horizontal: 0),
            positiveColor: MyMateThemes.primaryColor,
            progressColor: MyMateThemes.primaryColor.withOpacity(0.3),
            negativeColor: MyMateThemes.primaryColor.withOpacity(0.3),
            padding: const EdgeInsets.all(3),
            list: stepStates,
            onChange: (index) {},
            page: currentPage,
          ),
          Expanded(
            child: buildCurrentPage(
                currentPage), // Call the buildCurrentPage function
          ),
          ElevatedButton(
            onPressed: () {
              if (currentPage < stepStates.length - 1) {
                setState(() {
                  currentPage++;
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              }
            },
            style: const ButtonStyle(
              foregroundColor:
                  MaterialStatePropertyAll(MyMateThemes.backgroundColor),
              backgroundColor:
                  MaterialStatePropertyAll(MyMateThemes.primaryColor),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
            ),
            child:
                Text(currentPage < stepStates.length - 1 ? 'Next' : 'Complete'),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget buildCurrentPage(int currentPage) {
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
}

class PageOne extends StatefulWidget {
  @override
  State<PageOne> createState() => _PageOneState();
}

Future<void> _chooseImage(ImageSource source) async {
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
      // Handle the cropped image, e.g., update UI or save to storage
    }
  }
}

Future<void> _takePhoto(ImageSource source) async {
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
      // Handle the cropped image, e.g., update UI or save to storage
    }
  }
}

class _PageOneState extends State<PageOne> {
  File? _imageFile;

  void _openPopupScreen() {
    // Add your logic to open the popup screen here
    // For example, you can use showDialog to show a dialog box
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
                  child: SvgPicture.asset(
                    'assets/images/choose.svg',
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  //onTap: choose,
                  child: SvgPicture.asset(
                    'assets/images/or.svg',
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    _takePhoto(ImageSource.camera);
                  },
                  child: SvgPicture.asset(
                    'assets/images/take.svg',
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    //_isSwitched = false;
                  },
                  child: SvgPicture.asset(
                    'assets/images/Active.svg',
                  ),
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
          SizedBox(
            height: 50,
          ),
          Text("Update Your Profile"),
          SizedBox(height: 20),
          Stack(
            children: [
              GestureDetector(
                onTap: _openPopupScreen, // Your onTap function
                child: _imageFile != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(_imageFile!),
                      )
                    : SvgPicture.asset(
                        'assets/images/circle.svg',
                        // height: 100, // Adjust height and width as needed
                        // width: 100,
                      ),
              ),
              SizedBox(
                height: 50,
              ),
              Positioned(
                  child: GestureDetector(
                    onTap: _openPopupScreen, // Your onTap function
                    child: SvgPicture.asset(
                      'assets/images/edit.svg',
                    ),
                  ),
                  bottom: -1,
                  left: 95),
            ],
          ),
          SizedBox(height: 60),
          Text("Upload to gallery(Optional)"),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              _chooseImage(ImageSource.gallery);
            },
            child: SvgPicture.asset(
              'assets/images/cloud.svg',
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            //onTap: choose,
            child: SvgPicture.asset(
              'assets/images/orr.svg',
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              _takePhoto(ImageSource.camera);
            },
            child: SvgPicture.asset(
              'assets/images/took.svg',
            ),
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
  String? selectedValue;
  String? _selectedCivilStatus;
  String? _selectedEmploymentType;
  String? _selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Civil Status",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                    width: 90), // Placeholder space between text and dropdown
                DropdownButton<String>(
                  value: _selectedCivilStatus,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCivilStatus = value!;
                    });
                  },
                  items: <String>[
                    '--  Select Option  --',
                    'Unmarried',
                    'Divorced',
                    'Widowed'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: value == '-- Select Option --'
                            ? TextStyle(
                                color: Colors
                                    .grey) // Customize style for default option
                            : TextStyle(color: MyMateThemes.textColor),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Employment Type",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                    width: 40), // Placeholder space between text and dropdown
                DropdownButton<String>(
                  value: _selectedEmploymentType,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedEmploymentType = value!;
                    });
                  },
                  items: <String>[
                    '--  Select Option  --',
                    'Government',
                    'Private',
                    'Self Employed',
                    'Unemployed',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: value == '-- Select Option --'
                            ? TextStyle(
                                color: Colors
                                    .grey) // Customize style for default option
                            : TextStyle(color: MyMateThemes.textColor),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15, // Adjust the width as needed
                ),
                Text(
                  "Occupation",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                  width: 70, // Adjust the width as needed
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your Occupation',
                      hintStyle: TextStyle(
                          color: MyMateThemes.textColor.withOpacity(0.5)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    style: TextStyle(color: MyMateThemes.textColor),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15, // Adjust the width as needed
                ),
                Text(
                  "Height",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                  width: 100, // Adjust the width as needed
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your height',
                      hintStyle: TextStyle(
                          color: MyMateThemes.textColor.withOpacity(0.5)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    style: TextStyle(color: MyMateThemes.textColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "District",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(width: 110),
                DropdownButton<String>(
                  value: _selectedDistrict,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedDistrict = value!;
                    });
                  },
                  items: <String>[
                    '--  Select Option  --',
                    'Jaffna',
                    'Colombo',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: value == '-- Select Option --'
                            ? TextStyle(
                                color: Colors
                                    .grey) // Customize style for default option
                            : TextStyle(color: MyMateThemes.textColor),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15, // Adjust the width as needed
                ),
                Text(
                  "Education",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                  width: 80, // Adjust the width as needed
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your Education',
                      hintStyle: TextStyle(
                          color: MyMateThemes.textColor.withOpacity(0.5)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    style: TextStyle(color: MyMateThemes.textColor),
                  ),
                ),
              ],
            ),
          ),
          //SizedBox(height: 10),
          SizedBox(height: 10),

          Container(
            width: 360,
            height: 65,
            child: Row(
              children: [
                Expanded(
                  flex: 4, // This will make the text take 3/4 of the width
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0), // Adjust padding as needed
                    child: Text(
                      "Enter the code from the sms we sent xxxxxxxxxxxxxxxxxxxx yyyyyyyyyyyyyyyyyyy to +94 7x xxx xxx",
                      style: TextStyle(color: MyMateThemes.textColor),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1, // This will make the checkbox take 1/4 of the width
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
          ),

          //GestureDetector(),
          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15, // Adjust the width as needed
                ),
                Text(
                  "Contact Number",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                  width: 40, // Adjust the width as needed
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your Contact Number',
                      hintStyle: TextStyle(
                          color: MyMateThemes.textColor.withOpacity(0.5)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    style: TextStyle(color: MyMateThemes.textColor),
                  ),
                ),
              ],
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
  bool isChecked = false;
  String? selectedValue;
  String? _selectedReligion;
  String? _selectedLanguage;
  String? _selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Religion",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                    width: 90), // Placeholder space between text and dropdown
                DropdownButton<String>(
                  value: _selectedReligion,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedReligion = value!;
                    });
                  },
                  items: <String>[
                    '--  Select Option  --',
                    'Unmarried',
                    'Divorced',
                    'Widowed'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: value == '-- Select Option --'
                            ? TextStyle(
                                color: Colors
                                    .grey) // Customize style for default option
                            : TextStyle(color: MyMateThemes.textColor),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15, // Adjust the width as needed
                ),
                Text(
                  "Caste",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                  width: 70, // Adjust the width as needed
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your Caste',
                      hintStyle: TextStyle(
                          color: MyMateThemes.textColor.withOpacity(0.5)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    style: TextStyle(color: MyMateThemes.textColor),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Language",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                    width: 80), // Placeholder space between text and dropdown
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                  items: <String>[
                    '--  Select Option  --',
                    'Government',
                    'Private',
                    'Self Employed',
                    'Unemployed',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: value == '-- Select Option --'
                            ? TextStyle(
                                color: Colors
                                    .grey) // Customize style for default option
                            : TextStyle(color: MyMateThemes.textColor),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Father",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                    width: 100), // Placeholder space between text and dropdown
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                  items: <String>[
                    '--  Select Option  --',
                    'Government',
                    'Private',
                    'Self Employed',
                    'Unemployed',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: value == '-- Select Option --'
                            ? TextStyle(
                                color: Colors
                                    .grey) // Customize style for default option
                            : TextStyle(color: MyMateThemes.textColor),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Mother",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                    width: 100), // Placeholder space between text and dropdown
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                  items: <String>[
                    '--  Select Option  --',
                    'Government',
                    'Private',
                    'Self Employed',
                    'Unemployed',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: value == '-- Select Option --'
                            ? TextStyle(
                                color: Colors
                                    .grey) // Customize style for default option
                            : TextStyle(color: MyMateThemes.textColor),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          //GestureDetector(),
          SizedBox(height: 10),
          Container(
            width: 346,
            height: 46,
            color: MyMateThemes.secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20, // Adjust the width as needed
                ),
                Text(
                  "No of Sibilings",
                  style: TextStyle(color: MyMateThemes.textColor),
                ),
                SizedBox(
                  width: 100, // Adjust the width as needed
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Number',
                      hintStyle: TextStyle(
                          color: MyMateThemes.textColor.withOpacity(0.5)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    style: TextStyle(color: MyMateThemes.textColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
