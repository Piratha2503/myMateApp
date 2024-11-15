import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/Homepages/ClosableContainer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  File? _imageFile;
  int _selectedIndex = 0;
  bool isChecked = false;
  String? _selectedCivilStatus = 'Unmarried';
  String? _selectedEmploymentType = 'Government';
  String? _selectedDistrict = 'Jaffna';
  String? _selectedReligion = 'Hindu';

  List<TextEditingController> controllers = [];
  List<String> errors = [];
  final TextEditingController _bioController = TextEditingController();
  int characterCount = 0;
  String error = '';

  @override
  void initState() {
    super.initState();
    _bioController.addListener(_updateCharacterCount);
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
            child: DropdownButton2<String>(
              value: value,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: item.startsWith('--')
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

  Widget _buildNavigationBar() {
    return CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: (index) {
        setState(() {
          _selectedIndex = index;
        });
        // Handle navigation here based on the index
      },
    );
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
              SizedBox(width: 120),
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
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
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
            _buildDropdownRow(
              label: "Civil Status",
              value: _selectedCivilStatus,
              items: [
                '-- Select Status --',
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
                '-- Select Type --',
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
            _buildDropdownRow(
              label: "District",
              value: _selectedDistrict,
              items: ['-- Select District --', 'Jaffna', 'Colombo'],
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
            _buildTextFieldRow(
              label: "Contact No",
              hintText: "Enter Contact No",
            ),
            SizedBox(height: 10),
            _buildDropdownRow(
              label: "Religion",
              value: _selectedReligion,
              items: [
                '-- Select Religion --',
                'Hindu',
                'Christian',
                'Muslim',
                'Buddhist'
              ],
              onChanged: (value) => setState(() {
                _selectedReligion = value;
              }),
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                print('saved');
              },
              style: CommonButtonStyle.commonButtonStyle(),
              child: Text('Save'),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }
}
