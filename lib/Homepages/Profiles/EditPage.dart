import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymateapp/MyMateCommonBodies/MyMateApis.dart';

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
  String clientId = "E0JFHhK2x6Gq2Ac6XSyP";

  @override
  void initState() {
    super.initState();
    _fetchClientData();
  }

  Future<void> _fetchClientData() async {
    try {
      Map<String, dynamic> clientData = await fetchUserById(clientId);

      if (clientData.isNotEmpty) {
        setState(() {
          _selectedCivilStatus = clientData['civil_status'] ?? 'Select Status';
          _selectedEmploymentType = clientData['occupation_type'] ?? 'Select Type';
          _selectedDistrict = clientData['city'] ?? 'Select District';
          _selectedReligion = clientData['religion'] ?? 'Select Religion';
          occupationController.text = clientData['occupation'] ?? '';
          educationController.text = clientData['education'] ?? '';
          contactController.text = clientData['contact'] ?? '';
          _bioController.text = clientData['bio'] ?? '';
          isLoading = false;

          var expectations = clientData['expectations'] ?? [];

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
            left: 189,
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

  void _saveChanges() async {
    setState(() {
      isLoading = true;
    });

    List<String> updatedExpectations = controllers.map((controller) => controller.text).toList();


    Map<String, dynamic> personalDetails = {

      'marital_status': _selectedCivilStatus ?? 'Single',
      'religion': _selectedReligion ?? 'Christian-Rc',
    };

    Map<String, dynamic> contactInfo = {
      'mobile': contactController.text,
      'address': {

        'city': _selectedDistrict,
      },
    };

    Map<String, dynamic> careerStudies = {
      'occupation': occupationController.text,

    };

    Map<String, dynamic> lifestyle = {
      'expectations': updatedExpectations,

    };


    Map<String, dynamic> payload = {
      "docId": clientId,
      "personalDetails": personalDetails,
      "contactInfo": contactInfo,
      "careerStudies": careerStudies,
      "lifestyle": lifestyle,

    };
    try {
      var response = await http.put(
        Uri.parse("https://backend.graycorp.io:9000/mymate/api/v1/updateClient"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(payload),
      );
      print(contactController);

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        _fetchClientData();
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
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
  void dispose() {
    occupationController.dispose();
    educationController.dispose();
    contactController.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
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
                      'Single',
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

                      '$_selectedEmploymentType',
                      'professional',
                      'Private'
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
                      'Christian-Rc',
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
                          (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: Container(
                            width: 340,
                            decoration: BoxDecoration(
                              color: MyMateThemes.secondaryColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: controllers[index],
                                    decoration: InputDecoration(
                                      hintText: 'Enter expectation',
                                      hintStyle: TextStyle(
                                        color: MyMateThemes.textColor.withOpacity(0.5),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    style: TextStyle(color: MyMateThemes.textColor),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.close, color: Colors.red),
                                  onPressed: () => handleClose(index),
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 340.0, // Set desired width
                    height: 50.0, // Set desired height
                    child: ElevatedButton(
                      onPressed: () {
                        if (controllers.length < 5) {
                          setState(() {
                            addNewContainer();
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(MyMateThemes.secondaryColor),
                        foregroundColor:
                        MaterialStateProperty.all<Color>(MyMateThemes.primaryColor),
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
