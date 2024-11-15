import 'package:flutter/material.dart';
import '../../MyMateThemes.dart';
import 'CompleteProfileWidgets.dart';

class PageTwo extends StatefulWidget {
  final VoidCallback onSave;
  final Map<String, dynamic> formData; // Add formData parameter

  PageTwo({required this.onSave, required this.formData});

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  bool isChecked = false;
  String? _selectedCivilStatus;
  String? _selectedEmploymentType;
  String? _selectedDistrict;

  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCivilStatus = widget.formData['civilStatus'] ?? '-- Select Option --';
    _selectedEmploymentType = widget.formData['employmentType'] ?? '-- Select Option --';
    _selectedDistrict = widget.formData['district'] ?? '-- Select Option --';
    _occupationController.text = widget.formData['occupation'] ?? '';
    _heightController.text = widget.formData['height'] ?? '';
    _educationController.text = widget.formData['education'] ?? '';
    _contactNumberController.text = widget.formData['contactNumber'] ?? '';
    isChecked = widget.formData['isCodeVerified'] ?? false;
  }

  void _onSave() {
    // Save the form data into formData map
    widget.formData['civilStatus'] = _selectedCivilStatus;
    widget.formData['employmentType'] = _selectedEmploymentType;
    widget.formData['district'] = _selectedDistrict;
    widget.formData['occupation'] = _occupationController.text;
    widget.formData['height'] = _heightController.text;
    widget.formData['education'] = _educationController.text;
    widget.formData['contactNumber'] = _contactNumberController.text;
    widget.formData['isCodeVerified'] = isChecked;

    // Print the saved values
    print('Civil Status: ${widget.formData['civilStatus']}');
    print('Employment Type: ${widget.formData['employmentType']}');
    print('District: ${widget.formData['district']}');
    print('Occupation: ${widget.formData['occupation']}');
    print('Height: ${widget.formData['height']}');
    print('Education: ${widget.formData['education']}');
    print('Contact Number: ${widget.formData['contactNumber']}');
    print('Code Verified: ${widget.formData['isCodeVerified']}');

    widget.onSave();
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
            label: "Civil Status",
            value: _selectedCivilStatus,
            items: ['-- Select Option --', 'Unmarried', 'Divorced', 'Widowed'],
            onChanged: (value) => setState(() {
              _selectedCivilStatus = value;
            }),
          ),
          SizedBox(height: 10),
          CompleteProfileWidgets.buildDropdownRow(
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
          CompleteProfileWidgets.buildTextFieldRow(
            label: "Occupation",
            hintText: "Enter Occupation",
            controller: _occupationController,
          ),
          SizedBox(height: 10),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "Height (in cm)",
            hintText: "Enter height",
            controller: _heightController,
          ),
          SizedBox(height: 10),
          CompleteProfileWidgets.buildDropdownRow(
            label: "District",
            value: _selectedDistrict,
            items: ['-- Select Option --', 'Jaffna', 'Colombo'],
            onChanged: (value) => setState(() {
              _selectedDistrict = value;
            }),
          ),
          SizedBox(height: 10),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "Education",
            hintText: "Enter Education",
            controller: _educationController,
          ),
          SizedBox(height: 10),
          CompleteProfileWidgets.buildCodeVerificationRow(
            context,
            isChecked,
                (newValue) {
              setState(() {
                isChecked = newValue!;
              });
            },
          ),
          SizedBox(height: 10),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "Contact Number",
            hintText: "Enter Contact Number",
            controller: _contactNumberController,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _onSave, // Save and print form data
            style: CommonButtonStyle.commonButtonStyle(),
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
