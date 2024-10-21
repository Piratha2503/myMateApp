import 'package:flutter/material.dart';
import '../../MyMateThemes.dart';
import '../ClosableContainer.dart';
import 'CompleteProfileWidgets.dart';

class PageThree extends StatefulWidget {
  final VoidCallback onSave;
  final Map<String, dynamic> formData; // Add formData parameter

  PageThree({required this.onSave, required this.formData});

  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  String? _selectedReligion;
  String? _selectedLanguage;
  List<TextEditingController> controllers = [];
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _casteController = TextEditingController();
  final TextEditingController _siblingsController = TextEditingController();
  int characterCount = 0;
  String error = '';

  @override
  void initState() {
    super.initState();
    _selectedReligion = widget.formData['religion'] ?? '-- Select Option --';
    _selectedLanguage = widget.formData['language'] ?? '-- Select Option --';
    _casteController.text = widget.formData['caste'] ?? '';
    _siblingsController.text = widget.formData['siblings'] ?? '';
    _bioController.text = widget.formData['bio'] ?? '';
    List<String> expectations = List<String>.from(widget.formData['expectations'] ?? []);
    expectations.forEach((expectation) {
      final controller = TextEditingController(text: expectation);
      controllers.add(controller);
    });
    characterCount = _bioController.text.length;
  }

  bool _validateForm() {
    if (_selectedReligion == '-- Select Option --' ||
        _selectedLanguage == '-- Select Option --' ||
        _casteController.text.isEmpty ||
        _siblingsController.text.isEmpty ||
        characterCount > 192) {
      setState(() {
        error = 'Please fill in all required fields and ensure Bio is within the character limit.';
      });
      return false;
    }
    return true;
  }

  void _saveForm() {
    if (_validateForm()) {
      // Save the form data into the formData map
      widget.formData['religion'] = _selectedReligion;
      widget.formData['language'] = _selectedLanguage;
      widget.formData['caste'] = _casteController.text;
      widget.formData['siblings'] = _siblingsController.text;
      widget.formData['bio'] = _bioController.text;
      widget.formData['expectations'] = controllers.map((c) => c.text).toList();

      // Print the saved values
      print('Religion: ${widget.formData['religion']}');
      print('Language: ${widget.formData['language']}');
      print('Caste: ${widget.formData['caste']}');
      print('Siblings: ${widget.formData['siblings']}');
      print('Bio: ${widget.formData['bio']}');
      print('Expectations: ${widget.formData['expectations']}');

      widget.onSave(); // Trigger the save action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          CompleteProfileWidgets.buildDropdownRow(
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
          SizedBox(height: 20),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "Caste",
            hintText: "Enter your Caste",
            controller: _casteController,
          ),
          SizedBox(height: 10),
          CompleteProfileWidgets.buildDropdownRow(
            label: "Language",
            value: _selectedLanguage,
            items: ['-- Select Option --', 'Tamil', 'English', 'Sinhala'],
            onChanged: (value) => setState(() {
              _selectedLanguage = value;
            }),
          ),
          SizedBox(height: 10),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "No of Siblings",
            hintText: "Enter Number",
            controller: _siblingsController,
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
              child: Column(
                children: [
                  TextField(
                    controller: _bioController,
                    maxLength: 192,
                    maxLines: null,
                    minLines: 1,
                    onChanged: (text) {
                      setState(() {
                        characterCount = _bioController.text.length;
                        error = characterCount > 192 ? 'Character limit exceeded' : '';
                      });
                    },
                    decoration: InputDecoration(
                      label: Text(
                        'Bio',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      counterText: characterCount <= 192
                          ? '$characterCount/192'
                          : '',
                    ),
                  ),
                  if (error.isNotEmpty)
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    ),
                ],
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
                  fontSize: 20,
                ),
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
                onClose: (idx) {
                  setState(() {
                    controllers.removeAt(index);
                  });
                },
                parentContext: context,
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 340.0,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                if (controllers.length < 5) {
                  setState(() {
                    controllers.add(TextEditingController());
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    MyMateThemes.secondaryColor),
                foregroundColor:
                MaterialStateProperty.all<Color>(MyMateThemes.primaryColor),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('+ Add more'),
              ),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: _saveForm, // Save form data when pressed
            style: CommonButtonStyle.commonButtonStyle(),
            child: Text('Complete'),
          ),
        ],
      ),
    );
  }
}
