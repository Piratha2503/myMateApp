import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/MyProfileMain.dart';
import 'package:mymateapp/MyMateCommonBodies/MyMateApis.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';

import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../MyMateThemes.dart';
import '../ClosableContainer.dart';
import 'EditGalleryScreen.dart';

class EditPage extends StatefulWidget {
  final VoidCallback onSave;
  final String docId;


  const EditPage({required this.docId, super.key, required this.onSave});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool showmoreaboutme = false;
  bool isLoading = true;
  File? _imageFile;
  String? _selectedCivilStatus;
  String? _selectedEmploymentType;
  String? _selectedDistrict;
  String? _selectedReligion;
  String? profilePicUrl;
  List<TextEditingController> controllers = [];
  List<String> errors = [];
  final TextEditingController _bioController = TextEditingController();
  int characterCount = 0;
  String error = '';
  TextEditingController DistrictController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  int selectedAlcoholIndex = -1;
  int selectedSmokingIndex = -1;
  int selectedCookingIndex = -1;

  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController favoritesController = TextEditingController();
  final TextEditingController sportsController = TextEditingController();

  List<String> hobbyTags = [];

  String _selectedValue = '';

  @override
  void initState() {
    super.initState();
    print(widget.docId);
    _fetchClientData();
  }

  Future<void> _fetchClientData() async {
    try {
      Map<String, dynamic> clientData = await fetchUserById(widget.docId);

      if (clientData.isNotEmpty) {
        setState(() {
          showmoreaboutme = clientData['completeProfilePending']['_anything_filled_lifestyle'] ?? "";
          _selectedCivilStatus = clientData['civil_status'] ?? 'Select Status';
          _selectedEmploymentType = clientData['occupation_type'] ?? 'Select Type';
          DistrictController.text = clientData['city'] ?? '';

          _selectedValue = clientData['eating_habit'] ?? '';
          selectedAlcoholIndex =
              _getIndexFromString(clientData['alcoholIntake'], _alcoholOptions);
          selectedSmokingIndex =
              _getIndexFromString(clientData['smoking'], _smokingOptions);
          selectedCookingIndex =
              _getIndexFromString(clientData['cooking'], _cookingOptions);
          // hobbyTags = List<String>.from(clientData['favorites'] ?? []);
          if (clientData['favorites'] is List) {
            hobbyTags = List<String>.from(clientData['favorites']);
          } else if (clientData['favorites'] is String) {
            hobbyTags = clientData['favorites'].toString().isEmpty ? [] : [clientData['favorites']];
          } else {
            hobbyTags = [];
          }
          _selectedReligion = clientData['religion'] ?? 'Select Religion';
          occupationController.text = clientData['occupation'] ?? '';
          educationController.text = clientData['education'] ?? '';
          contactController.text = clientData['contact'] ?? '';
          _bioController.text = clientData['bio'] ?? '';
          isLoading = false;
          // _imageFile = clientData['profile_pic_url'] ?? '' ;
          profilePicUrl = clientData['profile_pic_url'] ?? '';
          var expectations = clientData['expectations'] ?? [];
          print(profilePicUrl);
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
          isLoading = true;
          print(ClientData);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Client data not found!')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  int _getIndexFromString(String value, List<String> options) {
    return options.indexOf(value);
  }

  final List<String> _alcoholOptions = [
    'Never Had',
    'Rarely Drinker',
    'Occasionally Drinker',
    'Regularly Drinker',
    'Swimming in it (24/7)',
  ];

  final List<String> _smokingOptions = [
    'Never Had',
    'Rarely Smoker',
    'Occasionally Smoker',
    'Regularly Smoker',
    'Chain Smoker',
  ];

  final List<String> _cookingOptions = [
    'Zero',
    'Novice',
    'Basic',
    'Intermediate',
    'Advanced',
  ];

  Future<void> _uploadImageToBackend(File imageFile) async {
    final url = Uri.parse(
        "https://backend.graycorp.io:9000/mymate/api/v1/uploadProfileImages");

    try {
      var request = http.MultipartRequest('PUT', url)
        ..fields['docId'] = widget.docId
        ..files.add(await http.MultipartFile.fromPath(
          'profile_Image',
          imageFile.path,
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final uploadedUrl = responseBody;

        setState(() {
          profilePicUrl = uploadedUrl;
        });

        print("Image uploaded successfully: $uploadedUrl");
      } else {
        print("Failed to upload image. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  void _onSave() async {
    print(widget.docId);
    setState(() {
      isLoading = true;
    });

    try {
      await _uploadImageToBackend(_imageFile!);
      await _fetchClientData();

      setState(() {
        profilePicUrl = profilePicUrl;
      });

      print("Profile updated successfully!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      print("Error saving profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile. Please try again.')),
      );
    }
  }

  void _addHobbyTag() {
    setState(() {
      hobbyTags.add(hobbyController.text);
      hobbyController.clear();
    });
  }

  void _openPopupScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get screen width & height using MediaQuery
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            height: screenHeight * 0.4, // 35% of screen height
            width: screenWidth * 0.5, // 50% of screen width
            child: Column(
              mainAxisSize: MainAxisSize.min, // Avoid unnecessary space
              children: [
                SizedBox(height: screenHeight * 0.02), // 2% of screen height

                GestureDetector(
                  onTap: () {
                    _chooseImage(ImageSource.gallery);
                  },
                  child: SvgPicture.asset(
                    'assets/images/choose.svg',
                    height: screenHeight * 0.08, // Scaled image size
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                GestureDetector(
                  child: SvgPicture.asset(
                    'assets/images/or.svg',
                    height: screenHeight * 0.06, // Adjusted icon size
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                GestureDetector(
                  onTap: () {
                    _chooseImage(ImageSource.camera);
                  },
                  child: SvgPicture.asset(
                    'assets/images/take.svg',
                    height: screenHeight * 0.08, // Scaled image size
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                GestureDetector(
                  onTap: () {
                    _onSave();
                    _fetchClientData();
                  },
                  child: SvgPicture.asset(
                    'assets/images/Active.svg',
                    height: screenHeight * 0.08, // Adjusted image size
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildTextFieldRow({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required BuildContext context, // Pass context to access MediaQuery
  }) {
    // Get screen width & height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Label
        Row(
          children: [
            SizedBox(width: screenWidth * 0.06), // 9% of screen width
            Text(
              label,
              style: TextStyle(
                color: MyMateThemes.textColor, // Change to your theme color
                fontWeight: FontWeight.w400,
                fontSize: screenWidth * 0.042, // Adjust font size dynamically
              ),
            ),
          ],
        ),

        SizedBox(height: screenHeight * 0.01), // 1% of screen height

        // Text Field
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: MyMateThemes.textColor.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(screenWidth * 0.02), // Dynamic border radius
          ),
          width: screenWidth * 0.9, // 90% of screen width
          height: screenHeight * 0.06, // 6% of screen height
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: MyMateThemes.textColor.withOpacity(0.5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Responsive padding
            ),
            style: TextStyle(
              color: MyMateThemes.textColor.withOpacity(0.7), // Selected item text color
              fontSize: screenWidth * 0.038,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildDropdownRow({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          children: [
            SizedBox(width: width*0.02),
            Text(
              label,
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontWeight: FontWeight.w400,
                fontSize:width*0.042,
              ),
            ),
          ],
        ),
        SizedBox(height: height*0.01), // Add space between the label and the dropdown
        // Dropdown Field
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: MyMateThemes.textColor.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(width*0.02),
          ),
          width: width*0.9,
          height:height*0.06,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              value: value,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item,
                      style: item.startsWith('Select')
                          ? TextStyle(
                          color: MyMateThemes.textColor.withOpacity(0.5),
                          fontSize: width*0.04,
                          fontWeight: FontWeight.w400)
                          : TextStyle(
                          color: MyMateThemes.textColor.withOpacity(0.7),
                          fontSize: width*0.04,
                          fontWeight: FontWeight.w400)),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _updateCharacterCount() {
    setState(() {
      characterCount = _bioController.text.length;
      error = characterCount > 192 ? 'Character limit exceeded' : '';
    });
  }

  void _chooseImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,
      );

      if (croppedFile != null) {
        setState(() {
          _imageFile = File(croppedFile.path);
        });
        await _uploadImageToBackend(_imageFile!);

        setState(() {
          profilePicUrl = profilePicUrl;
        });
        Navigator.pop(context);
      }
    }
  }

  void addNewContainer() {
    final controller = TextEditingController();
    controllers.add(controller);
    errors.add('');
  }

  void handleClose(int index) {
    if (controllers.isNotEmpty && index >= 0 && index < controllers.length) {
      setState(() {
        controllers
            .removeAt(index); // Remove the controller at the specified index
      });
    } else {
      print("Invalid index: $index");
    }
  }

  Future<void> _saveChanges() async {
    setState(() {
      isLoading = true;
    });

    List<String> updatedExpectations =
    controllers.map((controller) => controller.text).toList();

    Map<String, dynamic> personalDetails = {
      'marital_status': _selectedCivilStatus ?? '',
      'religion': _selectedReligion ?? '',
    };

    Map<String, dynamic> contactInfo = {
      'mobile': contactController.text,
      'address': {
        'city': DistrictController.text,
      },
    };

    Map<String, dynamic> careerStudies = {
      'occupation': occupationController.text,
      'occupation_type': _selectedEmploymentType ?? '',
    };

    final Map<String, dynamic> lifestyle = {
      'expectations': updatedExpectations,
      'eating_habit': _selectedValue,
      'alcoholIntake': _getAlcoholString(selectedAlcoholIndex),
      'smoking': _getSmokingString(selectedSmokingIndex),
      'cooking': _getCookingString(selectedCookingIndex),
      'personal_interest': hobbyTags,
    };
    Map<String, dynamic> profileImages = {
      'profilePicUrl': profilePicUrl,
    };

    Map<String, dynamic> payload = {
      "docId": widget.docId,
      "personalDetails": personalDetails,
      "contactInfo": contactInfo,
      "careerStudies": careerStudies,
      "lifestyle": lifestyle,
      "profileImages": profileImages,
    };
    try {
      var response = await http.put(
        Uri.parse(
            "https://backend.graycorp.io:9000/mymate/api/v1/updateClient"),
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
        print(payload);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );

        _fetchClientData();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(
                docId: widget.docId,
                selectedBottomBarIconIndex: 3,
              )),
        );
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

  String _getAlcoholString(int index) {
    switch (index) {
      case 0:
        return 'Never Had';
      case 1:
        return 'Rarely Drinker';
      case 2:
        return 'Occasionally Drinker';
      case 3:
        return 'Regularly Drinker';
      case 4:
        return 'Swimming in it (24/7)';
      default:
        return 'Unknown';
    }
  }

  String _getSmokingString(int index) {
    switch (index) {
      case 0:
        return 'Never Had';
      case 1:
        return 'Rarely Smoker';
      case 2:
        return 'Occasionally Smoker';
      case 3:
        return 'Regularly Smoker';
      case 4:
        return 'Chain Smoker';
      default:
        return 'Unknown';
    }
  }

  String _getCookingString(int index) {
    switch (index) {
      case 0:
        return 'Zero';
      case 1:
        return 'Novice';
      case 2:
        return 'Basic';
      case 3:
        return 'Intermediate';
      case 4:
        return 'Advanced';
      default:
        return 'Unknown';
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
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;

          return Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: SafeArea(
                  child: Padding(
                    padding: new EdgeInsets.all(width*0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset('assets/images/chevron-left.svg',
                              height: height*0.02, width: width*0.02),
                        ),
                        SizedBox(width: width*0.32),
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: MyMateThemes.textColor,
                            fontSize: width*0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height*0.035),
                    Center(
                      child: Column(
                        children: [
                          // SizedBox(height: 10),
                          // Stack(
                          //   alignment: Alignment.center,
                          //   children: [
                          GestureDetector(
                            onTap: _openPopupScreen,
                            child: profilePicUrl != null
                                ? Container(
                              width:
                              width*0.32, // Double the radius for width and height
                              height: height*0.16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                border: Border.all(
                                  color: MyMateThemes
                                      .secondaryColor, // Set the border color
                                  width: width*0.01, // Set the border width
                                ),
                              ),
                              child: CircleAvatar(
                                radius: width*0.3,
                                backgroundImage:
                                NetworkImage(profilePicUrl!),
                                backgroundColor: Colors
                                    .transparent, // To ensure no background color
                              ),
                            )
                                : SvgPicture.asset('assets/images/circle.svg'),
                          ),
                          SizedBox(height: width*0.01),
                          TextButton(
                              onPressed: _openPopupScreen,
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    color: MyMateThemes.primaryColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: width*0.04),
                              ))
                          // Positioned(
                          //   bottom : 0,
                          //   right: -5,
                          //   child: GestureDetector(
                          //     onTap: _openPopupScreen,
                          //     child: SvgPicture.asset('assets/images/edit.svg',color: MyMateThemes.textColor),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    //SizedBox(height: 10),
                    EditGalleryScreen(
                      docId: widget.docId,
                      onSave: () {},
                    ),
                    SizedBox(height: height*0.03),
                    CustomDropdown(
                      label: 'Civil Status',
                      value: _selectedCivilStatus,
                      items: [
                        'Select Option',
                        'Single',
                        'Unmarried',
                        'Divorced',
                        'Widowed'
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCivilStatus = value;
                        });
                      },
                    ),
                    SizedBox(height: height*0.018),
                    CustomDropdown(
                      label: 'Employment Type',
                      value: _selectedEmploymentType,
                      items: [
                        'Select Option ',
                        'Government',
                        'Private',
                        'Self Employed',
                        'Unemployed',
                        'Professional'
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedEmploymentType = value;
                        });
                      },
                    ),
                    SizedBox(height: height*0.018),
                    _buildTextFieldRow(
                      context:context,
                      label: 'Occupation',
                      hintText: 'Enter your occupation',
                      controller: occupationController,
                    ),
                    SizedBox(height: height*0.018),
                    _buildTextFieldRow(
                      label: 'Contact No',
                      hintText: 'Enter your contact number',
                      controller: contactController, context: context,
                    ),

                    SizedBox(height: height*0.018),
                    _buildTextFieldRow(
                      context:context,
                      label: 'District',
                      hintText: 'Enter your District',
                      controller: DistrictController,
                    ),

                    SizedBox(height: height*0.018),
                    _buildTextFieldRow(
                      context:context,
                      label: 'Education',
                      hintText: 'Enter your education',
                      controller: educationController,
                    ),

                    SizedBox(height: height*0.018),
                    CustomDropdown(
                      label: 'Religion',
                      value: _selectedReligion,
                      items: [
                        'Select Option',
                        'Hindu',
                        'Christian',
                        'Muslim',
                        'Buddhist'
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedReligion = value;
                        });
                      },
                    ),
                    SizedBox(height: height*0.08),
                    Row(
                      children: [
                        SizedBox(width:width*0.07),
                        Text(
                          'Expectations',
                          style: TextStyle(
                              color: MyMateThemes.textColor,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.8,
                              fontSize: width*0.05),
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.02),
                    Column(
                      children: List.generate(
                        controllers.length,
                            (index) => Padding(
                          padding: EdgeInsets.all(height*0.01),
                          child: Center(
                            child: Container(
                              width: width*0.9,
                              height: height*0.08,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                  MyMateThemes.textColor.withOpacity(0.2),
                                  width: width*0.0025,
                                ),
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
                                          color: MyMateThemes.textColor
                                              .withOpacity(0.5),
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: width*0.03),
                                      ),
                                      style: TextStyle(
                                          color: MyMateThemes.textColor
                                              .withOpacity(0.8)),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close,
                                        color: MyMateThemes.textColor,
                                        size: width*0.045),
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
                    SizedBox(height: height*0.03),
                    SizedBox(
                      width: width*0.9,
                      height: height*0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controllers.length < 5) {
                            setState(() {
                              addNewContainer();
                            });
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                              MyMateThemes.primaryColor),
                          backgroundColor: MaterialStateProperty.all(
                              MyMateThemes.secondaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(width*0.02))),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '+ Add more',

                            style: TextStyle(color:MyMateThemes.primaryColor,fontSize: width*0.038,letterSpacing: 0.8),
                          ),
                        ),
                      ),
                    ),
                    moreaboutme(),
                  ],
                ),
              ));
        }
    );
  }

  Widget moreaboutme() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Builder(
      builder: (context) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: width*0.04),
          child: Column(
            children: [
              SizedBox(height: height*0.08),
              Row(
                children: [
                  SizedBox(width: width*0.02),
                  Text(
                    'More About Me',
                    style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: width*0.05),
                  ),
                ],
              ),
              SizedBox(height: height*0.06),
              Row(
                children: [
                  SizedBox(width: width*0.02),
                  Text(
                    'Personal Interest',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: width*0.042,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.015),
              Row(
                children: [
                  SizedBox(width: width*0.03),
                  SvgPicture.asset('assets/images/Line 11.svg',width: width*0.87,),
                ],
              ),
              SizedBox(height: height*0.03),
              _buildTextField(hobbyController, '-- Type here --', _addHobbyTag),
              SizedBox(height:  height*0.025),
              Wrap(
                children: hobbyTags.map((tag) {
                  return _buildTagWithCloseButton(tag);
                }).toList(),
              ),
              SizedBox(height:height*0.06),
              Row(
                children: [
                  SizedBox(width: width*0.02),
                  Text(
                    'Skills & Habits',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: width*0.042,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height:height*0.015),
              Row(
                children: [
                  SizedBox(width:width*0.03),
                  SvgPicture.asset('assets/images/Line 11.svg',width: width*0.87,),
                ],
              ),
              SizedBox(height: height*0.03),
              Row(
                children: [
                  SizedBox(width: width*0.02),
                  Text(
                    'Eating Habits',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: width*0.04,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width:width*0.06 ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedValue = 'Vegetarian'; // Update selected state
                          });
                        },
                        child: Container(
                          width: width * 0.063, // Circle size
                          height: width * 0.063,
                          decoration: BoxDecoration(
                            color: _selectedValue == 'Vegetarian'
                                ? MyMateThemes.primaryColor // Selected color (filled)
                                : Colors.transparent, // Unselected (transparent inside)
                            border: Border.all(
                              color: _selectedValue == 'Vegetarian'
                                  ? Colors.transparent // Selected color (filled)
                                  : MyMateThemes.secondaryColor, // Outline color
                              width: 3, // Thickness of the outline
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: _selectedValue == 'Vegetarian'
                              ? Center(
                            child: Container(
                              width: width * 0.015, // Inner dot size
                              height: width * 0.015,
                              decoration: BoxDecoration(
                                color: Colors.white, // White inner dot for selected state
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                              : null, // No inner dot when unselected
                        ),
                      ),

                      SizedBox(width: width * 0.025),

                      Text(
                        'Vegetarian',
                        style: TextStyle(
                          color: MyMateThemes.textColor,
                          fontWeight: FontWeight.normal,
                          fontSize: width * 0.027,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: width * 0.15),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedValue = 'Non-Vegetarian'; // Update selected state
                          });
                        },
                        child: Container(
                          width: width * 0.063, // Circle size
                          height: width * 0.063,
                          decoration: BoxDecoration(
                            color: _selectedValue == 'Non-Vegetarian'
                                ? MyMateThemes.primaryColor // Selected color (filled)
                                : Colors.transparent, // Unselected (transparent inside)
                            border: Border.all(
                              color: _selectedValue == 'Non-Vegetarian'
                                  ? Colors.transparent // Selected color (filled)
                                  : MyMateThemes.secondaryColor, // Outline color
                              width: 3, // Thickness of the outline
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: _selectedValue == 'Non-Vegetarian'
                              ? Center(
                            child: Container(
                              width: width * 0.015, // Inner dot size
                              height: width * 0.015,
                              decoration: BoxDecoration(
                                color: Colors.white, // White inner dot for selected state
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                              : null, // No inner dot when unselected
                        ),
                      ),

                      SizedBox(width: width * 0.025),

                      Text(
                        'Non-Vegetarian',
                        style: TextStyle(
                          color: MyMateThemes.textColor,
                          fontWeight: FontWeight.normal,
                          fontSize: width * 0.027,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height:  height*0.05),

              Row(
                children: [
                  SizedBox(width:  width*0.02),
                  Text(
                    'Cooking',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize:  width*0.04,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.04),
              _buildCookingSelection(),

              SizedBox(height: height*0.05),

              Row(
                children: [
                  SizedBox(width: width*0.02),
                  Text(
                    'Alcohol',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize:  width*0.04,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height:  height*0.04),
              _buildAlcoholSelection(),

              SizedBox(height: height*0.05),

              Row(
                children: [
                  SizedBox(width: width*0.02),
                  Text(
                    'Smoking',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize:  width*0.04,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height:  height*0.04),
              _buildSmokingSelection(),

              SizedBox(height:  height*0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Store the selected values
                      await _saveChanges();
                      // await  StoreSelectedValues();
                    },
                    style: CommonButtonStyle.commonButtonStyle(),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white,fontSize: width*0.04, letterSpacing: 1.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height:height*0.1),
            ],
          ),
        );
      }
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      VoidCallback onSubmitted) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: MyMateThemes.textColor.withOpacity(0.2),
              width:  width*0.003,
            ),
            borderRadius: BorderRadius.circular(width*0.01),
          ),
          width: width*0.9,
          height: height*0.06,
          child: Padding(
            padding: EdgeInsets.only(left:  height*0.01),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: MyMateThemes.textColor.withOpacity(0.5),
                    fontSize:  width*0.035,
                    fontWeight: FontWeight.normal),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all( width*0.04),
                // Adjust padding as needed
                hintText: hintText,
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  onSubmitted();
                }
              },
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ),
        if (controller.text.isNotEmpty)
          GestureDetector(
            onTap: onSubmitted,
            child: Container(
              // width: 350,
              // height: 50,

              padding: EdgeInsets.symmetric(horizontal: width*0.03, vertical: height*0.01),
              margin: EdgeInsets.only(top:height*0.01),
              decoration: BoxDecoration(
                color: MyMateThemes.secondaryColor,
                borderRadius: BorderRadius.circular( width*0.01),
              ),
              child: Text('+ Add "${controller.text}"'),
              // child: Row(
              //   children: [
              //     Text(
              //       '+ Add',
              //       style: TextStyle(color: MyMateThemes.primaryColor),
              //     ),
              //     Text(
              //       '"${controller.text}"',
              //       style: TextStyle(color: MyMateThemes.textColor),
              //     ),
              //   ],
              // ),
            ),
          ),
      ],
    );
  }

  Widget _buildTagWithCloseButton(String tag) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width*0.03, vertical:  height*0.008),
      margin: EdgeInsets.symmetric(horizontal:  width*0.02, vertical:  height*0.01),
      decoration: BoxDecoration(
        color: MyMateThemes.primaryColor,
        borderRadius: BorderRadius.circular( width*0.01),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: TextStyle(
              color: Colors.white,
              fontSize:  width*0.035,
            ),
          ),
          SizedBox(width: width*0.02),
          GestureDetector(
            onTap: () {
              setState(() {
                hobbyTags.remove(
                    tag); // Remove the tag when the close button is pressed
              });
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
              size:  width*0.045,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlcoholSelection() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, height*0.02),
          painter: _LinePainter(selectedAlcoholIndex: selectedAlcoholIndex),
        ),
        Row(
          children: [
            SizedBox(width: width*0.01),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAlcoholIndex = 0;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedAlcoholIndex >= 0),
                      child: SizedBox(
                        width:width*0.06,
                        height: height*0.02,
                      ),
                    ),
                    SizedBox(height:  height*0.015),
                    Text(
                      'Never',
                      style: TextStyle(
                        color:MyMateThemes.textColor,

                        fontSize:  width*0.027,
                      ),
                    ),
                    Text(
                      'Had',
                      style: TextStyle(
                        color:MyMateThemes.textColor,

                        fontSize:  width*0.027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAlcoholIndex = 1;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedAlcoholIndex >= 1),
                      child: SizedBox(
                        width:  width*0.06,
                        height:  height*0.02,
                      ),
                    ),
                    SizedBox(height:  height*0.015),
                    Text(
                      'Rarely',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize:  width*0.027,
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize:  width*0.027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAlcoholIndex = 2;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedAlcoholIndex >= 2),
                      child: SizedBox(
                        width:  width*0.06,
                        height:  height*0.02,
                      ),
                    ),
                    SizedBox(height:  height*0.015),
                    Text(
                      'Occasionally',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize: width*0.027,
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize:  width*0.027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAlcoholIndex = 3;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedAlcoholIndex >= 3),
                      child: SizedBox(
                        width:  width*0.06,
                        height:  height*0.02,
                      ),
                    ),
                    SizedBox(height:  height*0.015),
                    Text(
                      'Regularly',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize: width*0.027,
                      ),
                    ),
                    Text(
                      'Drinker',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize:  width*0.027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAlcoholIndex = 4;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedAlcoholIndex >= 4),
                      child: SizedBox(
                        width:  width*0.06,
                        height:  height*0.02,
                      ),
                    ),
                    SizedBox(height:  height*0.015),
                    Text(
                      'Swimming',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize:  width*0.027,
                      ),
                    ),
                    Text(
                      'in it (24/7)',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize:  width*0.027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSmokingSelection() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width,  height*0.02),
          painter:
          _SmokingLinePainter(selectedSmokingIndex: selectedSmokingIndex),
        ),
        Row(
          children: [
            SizedBox(width:width*0.01),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSmokingIndex = 0;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedSmokingIndex >= 0),
                      child: SizedBox(
                        width: width*0.06,
                        height: height*0.02,
                      ),
                    ),
                    SizedBox(height: height*0.015),
                    Text(
                      'Never',
                      style: TextStyle(
                        color: selectedSmokingIndex >= 0
                            ? MyMateThemes.textColor
                            : MyMateThemes.textColor.withOpacity(0.6),
                        fontSize: width*0.027,
                          fontWeight: FontWeight.w300

                      ),
                    ),
                    Text(
                      'Had',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize: width*0.027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSmokingIndex = 1;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedSmokingIndex >= 1),
                      child: SizedBox(
                        width: width*0.06,
                        height: height*0.02,
                      ),
                    ),
                    SizedBox(height: height*0.015),
                    Text(
                      'Rarely',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize: width*0.027,
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize: width*0.027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSmokingIndex = 2;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedSmokingIndex >= 2),
                      child: SizedBox(
                        width: width*0.06,
                        height: height*0.02,
                      ),
                    ),
                    SizedBox(height: height*0.015),
                    Text(
                      'Occasionally',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize: width*0.027,
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize: width*0.027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSmokingIndex = 3;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedSmokingIndex >= 3),
                      child: SizedBox(
                        width: width*0.06,
                        height: height*0.02,
                      ),
                    ),
                    SizedBox(height: height*0.015),
                    Text(
                      'Regularly',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize: width*0.027,
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize: width*0.027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSmokingIndex = 4;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedSmokingIndex >= 4),
                      child: SizedBox(
                        width: width*0.06,
                        height: height*0.02,
                      ),
                    ),
                    SizedBox(height: height*0.015),
                    Text(
                      'Chain',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize: width*0.027,
                      ),
                    ),
                    Text(
                      'Smoker',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        fontWeight: FontWeight.w300,

                        fontSize: width*0.027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCookingSelection() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, height*0.02),
          painter: _LinearPainter(selectedCookingIndex: selectedCookingIndex),
        ),
        Row(
          children: [
            SizedBox(width:width*0.01),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCookingIndex = 0;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedCookingIndex >= 0),
                      child: SizedBox(
                        width: width*0.06,
                        height: height*0.02,
                      ),
                    ),
                    SizedBox(height: height*0.015),
                    Text(
                      'Zero',
                      style: TextStyle(
                        color:MyMateThemes.textColor,
                        //selectedCookingIndex >= 0
                            // ? MyMateThemes.textColor
                            // : MyMateThemes.textColor.withOpacity(0.6),
                        fontSize: width*0.027,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCookingIndex = 1;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedCookingIndex >= 1),
                      child: SizedBox(
                        width: width*0.06,
                        height: height*0.02,
                      ),
                    ),
                    SizedBox(height: height*0.015),
                    Text(
                      'Novice',
                      style: TextStyle(
                        color:MyMateThemes.textColor,

                        fontSize: width*0.027,
                          fontWeight: FontWeight.w300,


                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCookingIndex = 2;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedCookingIndex >= 2),
                      child: SizedBox(
                        width: width*0.06,
                        height:height*0.02,
                      ),
                    ),
                    SizedBox(height: height*0.015),
                    Text(
                      'Basic',
                      style: TextStyle(
                          color:MyMateThemes.textColor,

                          fontSize: width*0.027,
                          fontWeight: FontWeight.w300

                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCookingIndex = 3;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedCookingIndex >= 3),
                      child: SizedBox(
                        width: width*0.06,
                        height: height*0.02,
                      ),
                    ),
                    SizedBox(height:height*0.015),
                    Text(
                      'Intermediate',
                      style: TextStyle(
                     color:MyMateThemes.textColor,

                          fontSize: width*0.027,
                          fontWeight: FontWeight.w300

                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCookingIndex = 4;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter:
                      _CirclePainter(isActive: selectedCookingIndex >= 4),
                      child: SizedBox(
                        width: width*0.06,
                        height: height*0.02,
                      ),
                    ),
                    SizedBox(height: height*0.015),
                    Text(
                      'Advanced',
                      style: TextStyle(
                          color:MyMateThemes.textColor,

                          fontSize: width*0.027,
                          fontWeight: FontWeight.w300

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CirclePainter extends CustomPainter {
  final bool isActive;

  _CirclePainter({required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = isActive ? MyMateThemes.primaryColor : Colors.white // Fill only if active
      ..style = isActive ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 3.0; // Border thickness

    final Paint borderPaint = Paint()
      ..color = isActive ? MyMateThemes.primaryColor : MyMateThemes.secondaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Draw circle with border
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2.2,
      borderPaint,
    );

    // Draw filled circle only when active
    if (isActive) {
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.width / 2.2,
        paint,
      );
    }
  }



  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class _LinePainter extends CustomPainter {
  final int selectedAlcoholIndex;


  _LinePainter({required this.selectedAlcoholIndex,});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyMateThemes.primaryColor
      ..strokeWidth = 3;

    final double segmentWidth = size.width / 5;

    // Draw lines between circles
    for (int i = 0; i < 4; i++) {
      if (i < selectedAlcoholIndex) {
        paint.color = MyMateThemes.primaryColor;
      } else {
        paint.color = Colors.grey.withOpacity(0.1);
      }
      canvas.drawLine(
        Offset((i + 0.7) * segmentWidth, size.height / 2),
        Offset((i + 1.4) * segmentWidth, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _SmokingLinePainter extends CustomPainter {
  final int selectedSmokingIndex;


  _SmokingLinePainter({required this.selectedSmokingIndex,});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyMateThemes.primaryColor
      ..strokeWidth = 3;

    final double segmentWidth = size.width / 5;

    // Draw lines between circles
    for (int i = 0; i < 4; i++) {
      if (i < selectedSmokingIndex) {
        paint.color = MyMateThemes.primaryColor;
      } else {
        paint.color = Colors.grey.withOpacity(0.1);
      }
      canvas.drawLine(
        Offset((i + 0.7) * segmentWidth, size.height / 2),
        Offset((i + 1.4) * segmentWidth, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



class _LinearPainter extends CustomPainter {
  final int selectedCookingIndex;

  _LinearPainter({required this.selectedCookingIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyMateThemes.primaryColor
      ..strokeWidth = 3;

    final double segmentWidth = size.width / 5;

    // Draw lines between circles
    for (int i = 0; i < 4; i++) {
      if (i < selectedCookingIndex) {
        paint.color = MyMateThemes.primaryColor;
      } else {
        paint.color = Colors.grey.withOpacity(0.1);
      }
      canvas.drawLine(
        Offset((i + 0.7) * segmentWidth, size.height / 2),
        Offset((i + 1.4) * segmentWidth, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}