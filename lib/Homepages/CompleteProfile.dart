import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mymateapp/Homepages/MyProfile.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/Homepages/ClosableContainer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  int currentPage = 0;
  List<int> stepStates = [0, 0, 0];

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
            SizedBox(height: 20), // Add space before the page content
            _buildCurrentPage(currentPage),
            _buildNextButton(),
            SizedBox(height: 50),
          ],
        ),
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
            // MaterialPageRoute(builder: (context) => SubscribedhomescreenPage()),
            MaterialPageRoute(
                builder: (context) => ProfilePage(
                      docId: "",
                    )),
          );
        }
      },
      style: CommonButtonStyle.commonButtonStyle(),
      child: Text(currentPage < stepStates.length - 1 ? 'Next' : 'Complete'),
    );
  }
}

Widget _buildTextFieldRow({required String label, required String hintText}) {
  return Container(
    decoration: BoxDecoration(
      color: MyMateThemes.secondaryColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    width: 346,
    height: 44,
    child: Stack(
      children: [
        Positioned(
          left: 15,
          top: 0,
          bottom: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(label, style: TextStyle(color: Colors.black)),
          ),
        ),
        Positioned(
          left:
              180, // Adjust this value to set the starting position of the hint text
          right: 0,
          top: 0,
          bottom: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle:
                    TextStyle(color: MyMateThemes.textColor.withOpacity(0.5)),
                border: InputBorder.none,
              ),
              style: TextStyle(color: MyMateThemes.textColor),
            ),
          ),
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
    decoration: BoxDecoration(
      color: MyMateThemes.secondaryColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    width: 346,
    height: 42,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 15), // Add this line
        Text(label, style: TextStyle(color: Colors.black)),
        Spacer(),
        SizedBox(width: 5),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: value,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: item == '-- Select Option --'
                      ? TextStyle(
                          color: MyMateThemes.textColor.withOpacity(0.5))
                      : TextStyle(color: MyMateThemes.textColor),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

class PageOne extends StatefulWidget {
  const PageOne({super.key});

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
          content: SizedBox(
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
                bottom: -1,
                left: 95,
                child: GestureDetector(
                  onTap: _openPopupScreen,
                  child: SvgPicture.asset('assets/images/edit.svg'),
                ),
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
  const PageTwo({super.key});

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  bool isChecked = false;
  String? _selectedCivilStatus = '-- Select Option --';
  String? _selectedEmploymentType = '-- Select Option --';
  String? _selectedDistrict = '-- Select Option --';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          _buildDropdownRow(
            label: "Civil Status",
            value: _selectedCivilStatus,
            items: ['-- Select Option --', 'Unmarried', 'Divorced', 'Widowed'],
            onChanged: (value) => setState(() {
              _selectedCivilStatus = value;
            }),
          ),
          SizedBox(height: 10),
          _buildDropdownRow(
            label: "Employment Type",
            value: _selectedEmploymentType,
            items: [
              '-- Select Option --',
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
            hintText: "Enter Occupation",
          ),
          SizedBox(height: 10),
          _buildTextFieldRow(
            label: "Height (in cm) ",
            hintText: "Enter height",
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
            hintText: "Enter Education",
          ),
          SizedBox(height: 10),
          _buildCodeVerificationRow(),
          SizedBox(height: 10),
          _buildTextFieldRow(
            label: "Contact Number",
            hintText: "Enter Contact Number",
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildCodeVerificationRow() {
    return SizedBox(
      width: 360,
      height: 65,
      child: Row(
        children: [
          SizedBox(width: 10),
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
  const PageThree({super.key});

  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  String? _selectedReligion = '-- Select Option --';
  String? _selectedLanguage = '-- Select Option --';

  List<TextEditingController> controllers = [];
  List<String> errors = [];

  final TextEditingController _bioController = TextEditingController();
  int characterCount = 0;
  String error = '';

  @override
  void initState() {
    super.initState();
    _bioController.addListener(_updateCharacterCount);
    // Add the initial container
    addNewContainer();
  }

  @override
  void dispose() {
    _bioController.removeListener(_updateCharacterCount);
    _bioController.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {
      characterCount = _bioController.text.length;
      error = characterCount > 192 ? 'Character limit exceeded' : '';
    });
  }

  void addNewContainer() {
    final controller = TextEditingController();
    controllers.add(controller);
    errors.add('');
  }

  void handleClose(int index) {
    setState(() {
      controllers.removeAt(index);
      errors.removeAt(index);
    });
  }

  Widget _buildDropdownRow({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: MyMateThemes.secondaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 346,
      height: 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15), // Add this line
          Text(label, style: TextStyle(color: Colors.black)),
          Spacer(),
          SizedBox(width: 5),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: item == '-- Select Option --'
                        ? TextStyle(
                            color: MyMateThemes.textColor.withOpacity(0.5))
                        : TextStyle(color: MyMateThemes.textColor),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldRow({required String label, required String hintText}) {
    return Container(
      decoration: BoxDecoration(
        color: MyMateThemes.secondaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 346,
      height: 44,
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(label, style: TextStyle(color: Colors.black)),
            ),
          ),
          Positioned(
            left:
                192, // Adjust this value to set the starting position of the hint text
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle:
                      TextStyle(color: MyMateThemes.textColor.withOpacity(0.5)),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: MyMateThemes.textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildDropdownRow(
              label: "Religion",
              value: _selectedReligion,
              items: [
                '-- Select Option --',
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
              items: [
                '-- Select Option --',
                'Tamil',
                'English',
                'Singala',
              ],
              onChanged: (value) => setState(() {
                _selectedLanguage = value;
              }),
            ),
            SizedBox(height: 10),
            _buildTextFieldRow(
              label: "No of Siblings",
              hintText: "Enter Number",
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: MyMateThemes.secondaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: 346,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      TextField(
                        controller: _bioController,
                        maxLength: 192,
                        maxLines:
                            null, // Allow the TextField to expand vertically
                        minLines: 1,
                        textInputAction: TextInputAction
                            .done, // Show done button on keyboard
                        decoration: InputDecoration(
                          label: Text(
                            'Bio',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          hintText: '',
                          counterText: characterCount <= 192
                              ? '$characterCount/192'
                              : '',
                        ),
                      ),
                      if (error.isNotEmpty)
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                SizedBox(width: 40),
                Text(
                  'Expectations',
                  style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 15),
            Column(
              children: List.generate(
                controllers.length,
                (index) => ClosableContainer(
                  controller: controllers[index],
                  index: index,
                  onClose: handleClose,
                  parentContext:
                      context, // Pass the context from the parent widget
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 340.0, // Set desired width (adjust as needed)
              height: 50.0, // Set desired height (adjust as needed)
              child: ElevatedButton(
                onPressed: () {
                  if (controllers.length < 5) {
                    setState(() {
                      addNewContainer();
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      MyMateThemes.secondaryColor),
                  foregroundColor: WidgetStateProperty.all<Color>(
                      MyMateThemes.primaryColor),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('+Add more'),
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
