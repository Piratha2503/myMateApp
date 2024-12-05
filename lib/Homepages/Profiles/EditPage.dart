import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../MyMateThemes.dart';
import '../ClosableContainer.dart';

class EditPage extends StatefulWidget {
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool isLoading = true;
  File? _imageFile;
  String? _selectedCivilStatus;
  String? _selectedEmploymentType;
  String? _selectedDistrict;
  String? _selectedReligion;

  List<TextEditingController> controllers = [];
  List<String> errors = [];
  final TextEditingController _bioController = TextEditingController();
  int characterCount = 0;
  String error = '';
  TextEditingController occupationController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchClientData();
  }

  Future<void> _fetchClientData() async {
    try {
      // Hardcoded client ID
      String clientId = "9l2knrHe8XLZL2S3erxy";

      // Fetch the specific client document by clientId
      DocumentSnapshot clientSnapshot =
      await firestore.collection('clients').doc(clientId).get();

      if (clientSnapshot.exists) {
        setState(() {
          // Populate state variables with the client's data
          _selectedCivilStatus = clientSnapshot['civil_status'] ?? 'Select Status';
          _selectedEmploymentType =
              clientSnapshot['employment_type'] ?? 'Select Type';
          _selectedDistrict = clientSnapshot['district'] ?? 'Select District';
          _selectedReligion = clientSnapshot['religion'] ?? 'Select Religion';
          occupationController.text = clientSnapshot['occupation'] ?? '';
          educationController.text = clientSnapshot['education'] ?? '';
          contactController.text = clientSnapshot['mobile']?.toString() ?? '';
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
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

  Widget _buildTextFieldRow({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
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
              child: Text(label, style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          Positioned(
            left: 189, // Adjust this value to set the starting position of the hint text
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: MyMateThemes.textColor.withOpacity(0.5)),
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
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 8,
            bottom: 0,
            child: Text(label, style: TextStyle(color: Colors.black, fontSize: 15)),
          ),
          Positioned(
            left: 175,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                value: value,
                onChanged: onChanged,
                items: items.map<DropdownMenuItem<String>>((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: item.startsWith('Select')
                          ? TextStyle(color: MyMateThemes.textColor.withOpacity(0.5))
                          : TextStyle(color: MyMateThemes.textColor),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
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

  Future<void> _saveChanges() async {
    setState(() {
      isLoading = true;
    });

    String clientId = "9l2knrHe8XLZL2S3erxy"; // Hardcoded client ID
    await firestore.collection('clients').doc(clientId).update({
      'civil_status': _selectedCivilStatus,
      'employment_type': _selectedEmploymentType,
      'district': _selectedDistrict,
      'religion': _selectedReligion,
      'occupation': occupationController.text,
      'education': educationController.text,
      'mobile': contactController.text,
    });

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );
  }

  @override
  void dispose() {
    occupationController.dispose();
    educationController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
              SizedBox(width: 110),
              Text(
                'Edit Profile',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                 // SizedBox(height: 10),
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

                  SizedBox(height: 25),
                  _buildDropdownRow(
                    label: 'Civil Status',
                    value: _selectedCivilStatus,
                    items: [
                      'Select Status',
                      'single',
                      'Married',
                      'Widowed',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCivilStatus = value;
                      });
                    },
                  ),
                  SizedBox(height: 13),
                  _buildDropdownRow(
                    label: 'Employment Type',
                    value: _selectedEmploymentType,
                    items: [
                      'Select Type',
                      'professional'

                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedEmploymentType = value;
                      });
                    },
                  ),
                  SizedBox(height: 13),
                  _buildTextFieldRow(
                    label: 'Occupation',
                    hintText: 'Enter your occupation',
                    controller: occupationController,
                  ),
                  SizedBox(height: 13),
                  _buildTextFieldRow(
                    label: 'Contact No',
                    hintText: 'Enter your contact number',
                    controller: contactController,
                  ),

                  SizedBox(height: 13),
                  _buildDropdownRow(
                    label: 'District',
                    value: _selectedDistrict,
                    items: [
                      'Select District',
                      'Colombo',
                      'Kandy',
                      'Jaffna',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedDistrict = value;
                      });
                    },
                  ),
                  SizedBox(height:13),
                  _buildTextFieldRow(
                    label: 'Education',
                    hintText: 'Enter your education',
                    controller: educationController,
                  ),

                  SizedBox(height: 13),
                  _buildDropdownRow(
                    label: 'Religion',
                    value: _selectedReligion,
                    items: [
                      'Select Religion',
                      'Christianity',
                      'hindu',
                      'Islam',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedReligion = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 5),
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
                  SizedBox(height: 5),
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

                        backgroundColor: MaterialStateProperty.all<Color>(
                            MyMateThemes.secondaryColor),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            MyMateThemes.primaryColor),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('+Add more'),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    child: Text('Save'),
                    style: CommonButtonStyle.commonButtonStyle(),
                  ),

                ],
              ),
            )

          ],

        ),
      ),

    );
  }
}
