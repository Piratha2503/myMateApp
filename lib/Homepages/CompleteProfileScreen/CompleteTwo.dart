import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../MyMateThemes.dart';
import 'CompleteProfileWidgets.dart';

class PageTwo extends StatefulWidget {
  final VoidCallback onSave;
  final String docId;
  PageTwo({required this.onSave, required this.docId});

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  bool isChecked = false;
  String? _selectedCivilStatus;
  String? _selectedEmploymentType;
  // String? _selectedDistrict;
  bool showGeneralError = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _DistrictController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();

  String? civilStatusError;
  String? employmentTypeError;
  String? districtError;
  String? occupationError;
  String? heightError;
  String? educationError;
  String? CivilStatusError;
  String? EmploymentTypeError;
  String? DistrictError;
  String? OccupationError;
  String? HeightError;
  String? EducationError;


  @override
  void initState() {
    super.initState();
    _selectedCivilStatus = '-- Select Option --';
    _selectedEmploymentType = '-- Select Option --';
    _DistrictController.text = '';
    _occupationController.text = '';
    _heightController.text = '';
    _educationController.text = '';
    _contactNumberController.text = '';
    isChecked = false;

    _heightController.addListener(() {
      final text = _heightController.text;
      setState(() {
        HeightError = text.isNotEmpty && !_validateHeight(text)
            ? 'Height should be a valid number'
            : null;
      });
    });

    _DistrictController.addListener(() {
      final text = _DistrictController.text;
      setState(() {
        DistrictError = text.isNotEmpty && !_validateLettersOnly(text)
            ? 'District should contain only letters'
            : null;
      });
    });

    _educationController.addListener(() {
      final text = _educationController.text;
      setState(() {
        EducationError = text.isNotEmpty && !_validateLettersOnly(text)
            ? 'Education should contain only letters'
            : null;
      });
    });

    _occupationController.addListener(() {
      final text = _occupationController.text;
      setState(() {
        OccupationError = text.isNotEmpty && !_validateLettersOnly(text)
            ? 'Occupation should contain only letters'
            : null;
      });
    });
  }

  bool _validateHeight(String input) {
    return RegExp(r'^\d+(\.\d+)?$').hasMatch(input);
  }

  bool _validateLettersOnly(String input) {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(input);
  }

  bool _validateFields() {
    setState(() {
      civilStatusError = _selectedCivilStatus == '-- Select Option --'
          ? 'Please select a civil status'
          : null;
      employmentTypeError = _selectedEmploymentType == '-- Select Option --'
          ? 'Please select an employment type'
          : null;
      // districtError = _selectedDistrict == '-- Select Option --'
      //     ? 'Please select a district'
      //     : null;

      districtError = (_DistrictController.text.isEmpty || !_validateLettersOnly(_DistrictController.text))
          ? 'District must contain only letters and cannot be empty'
          : null;

      occupationError = (_occupationController.text.isEmpty || !_validateLettersOnly(_occupationController.text))
          ? 'Occupation must contain only letters and cannot be empty'
          : null;
      heightError = (_heightController.text.isEmpty || !_validateHeight(_heightController.text))
          ? 'Height must be a valid number and cannot be empty'
          : null;
      educationError = (_educationController.text.isEmpty || !_validateLettersOnly(_educationController.text))
          ? 'Education must contain only letters and cannot be empty'
          : null;


      showGeneralError = civilStatusError != null ||
          employmentTypeError != null ||
          districtError != null ||
          occupationError != null ||
          heightError != null ||
          educationError != null;
    });

    return !showGeneralError;
  }

  Future<void> _updateForm() async {
    final data = {
      'docId': widget.docId,
      'contactInfo': {
        'address': {
          'city': _DistrictController,
        }
      },
      'personalDetails': {
        'marital_status': _selectedCivilStatus,
        'height': double.parse(_heightController.text),
      }
    };

    final url = 'https://backend.graycorp.io:9000/mymate/api/v1/updateClient';
    try {
      print('Sending data: ${json.encode(data)}');
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
      } else {
        setState(() {
          print('Failed to update: ${response.body}');
        });
      }
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> _saveDataToBackend() async {
    final String url =
        'https://backend.graycorp.io:9000/mymate/api/v1/saveClientData';

    final data = {
      'docId': widget.docId,
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
        print('Data saved successfully: ${response.body}');
      } else {
        print('Failed to save data: ${response.body}');
      }
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  void _onSave() async {
    if (_validateFields()) {
     await _saveDataToBackend();
       await _updateForm();
      widget.onSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 12),
          CompleteProfileWidgets.buildDropdownRow(
            label: "Civil Status",
            value: _selectedCivilStatus,
            items: ['-- Select Option --', 'Unmarried', 'Divorced', 'Widowed'],
            onChanged: (value) => setState(() {
              _selectedCivilStatus = value;
            }),
          ),
          SizedBox(height: 12),
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
          SizedBox(height: 12),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "Occupation",
            hintText: "Enter Occupation",
            controller: _occupationController,
          ),
          if (OccupationError != null)
            Text(OccupationError!,
                style: TextStyle(color: Colors.red[800], fontSize: 10)),
          SizedBox(height: 12),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "Height (in cm)",
            hintText: "Enter height",
            controller: _heightController,
          ),
          if (HeightError != null)
            Text(HeightError!,
                style: TextStyle(color: Colors.red[800], fontSize: 12)),
          SizedBox(height: 12),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "District",
            hintText: "Enter the district",
            controller: _DistrictController,
          ),
          if (DistrictError != null)
            Text(DistrictError!,
                style: TextStyle(color: Colors.red[800], fontSize: 10)),
          SizedBox(height: 12),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "Education",
            hintText: "Enter Education",
            controller: _educationController,
          ),
          if (EducationError != null)
            Text(EducationError!,
                style: TextStyle(color: Colors.red[800], fontSize: 10)),
          SizedBox(height: 20),


          if (showGeneralError)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Text(
                  "These fields are mandatory.",
                  style: TextStyle(color: Colors.red[800]),
                ),
              ),
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
