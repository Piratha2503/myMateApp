import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../MyMateThemes.dart';
import 'CompleteProfileWidgets.dart';

class PageTwo extends StatefulWidget {
  final VoidCallback onSave;

  PageTwo({required this.onSave});

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

  final String docId = 'kQkNnxHFw3MF1riqIiEQ';

  @override
  void initState() {
    super.initState();
    _selectedCivilStatus = '-- Select Option --';
    _selectedEmploymentType = '-- Select Option --';
    _selectedDistrict = '-- Select Option --';
    _occupationController.text = '';
    _heightController.text = '';
    _educationController.text = '';
    _contactNumberController.text = '';
    isChecked = false;
  }

  Future<void> _saveDataToBackend() async {
    final String url = 'https://backend.graycorp.io:9000/mymate/api/v1/saveClientData';

    final Map<String, dynamic> data = {
      'docId': docId,
      'personalDetails': {


        'marital_status': _selectedCivilStatus,
        'height': int.parse(_heightController.text),

      },
      'contactInfo': {
        'mobile': _contactNumberController.text,



        'address': {

          'city': _selectedDistrict,

        }
      },

      'careerStudies': {
        'occupation': _occupationController.text,
        'occupation_type': _selectedEmploymentType,
        'higher_studies': _educationController.text,
      },

    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('Data saved successfully');
      } else {
        print('Failed to save data: ${response.body}');
      }
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  void _onSave() {
    _saveDataToBackend();
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
            onPressed: _onSave,
            style: CommonButtonStyle.commonButtonStyle(),
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
