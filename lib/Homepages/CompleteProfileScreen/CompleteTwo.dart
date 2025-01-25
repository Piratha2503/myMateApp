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
  String? _selectedDistrict;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();


  String? civilStatusError;
  String? employmentTypeError;
  String? districtError;
  String? occupationError;
  String? heightError;
  String? educationError;

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



  bool _validateFields() {
    setState(() {
      civilStatusError = _selectedCivilStatus == '-- Select Option --'
          ? 'Please select a civil status'
          : null;
      employmentTypeError = _selectedEmploymentType == '-- Select Option --'
          ? 'Please select an employment type'
          : null;
      districtError = _selectedDistrict == '-- Select Option --'
          ? 'Please select a district'
          : null;
      occupationError =
      _occupationController.text.isEmpty ? 'This field is mandatory' : null;
      heightError =
      _heightController.text.isEmpty ? 'This field is mandatory' : null;
      educationError =
      _educationController.text.isEmpty ? 'This field is mandatory' : null;

    });

    return civilStatusError == null &&
        employmentTypeError == null &&
        districtError == null &&
        occupationError == null &&
        heightError == null &&
        educationError == null ;

  }

  Future<void> _saveDataToBackend() async {
    final String url =
        'https://backend.graycorp.io:9000/mymate/api/v1/saveClientData';

    // final double height = double.parse(_heightController.text);

    final data = {
      'docId': widget.docId,
      // 'personalDetails': {
      //
      //
      //   'marital_status': _selectedCivilStatus,
      //   // 'height': height,
      //
      // },


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

  Future<void> _updateForm() async {
    final data = {
      'docId': widget.docId,
      'contactInfo': {
        'address': {
          'city': _selectedDistrict,
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
        widget.onSave();
      } else {
        setState(() {
          print('Failed to update: ${response.body}');
        });
      }
    } catch (e) {
      setState(() {});
    }
  }

  void _onSave() {
    if (_validateFields()) {
      _saveDataToBackend();
      _updateForm();
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
            hintText:  "Enter Occupation",
            controller: _occupationController,
            errorText: occupationError,

          ),
          

          SizedBox(height: 12),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "Height (in cm)",
            hintText: "Enter height",
            controller: _heightController,
            errorText: occupationError,

          ),
          SizedBox(height: 12),
          CompleteProfileWidgets.buildDropdownRow(
            label: "District",
            value: _selectedDistrict,
            items: ['-- Select Option --', 'Jaffna', 'Colombo'],
            onChanged: (value) => setState(() {
              _selectedDistrict = value;
            }),
          ),
          SizedBox(height: 12),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "Education",
            hintText: "Enter Education",
            controller: _educationController,
            errorText: occupationError,

          ),
          SizedBox(height: 12),
          // CompleteProfileWidgets.buildCodeVerificationRow(
          //   context,
          //   isChecked,
          //   (newValue) {
          //     setState(() {
          //       isChecked = newValue!;
          //     });
          //   },
          // ),
          // SizedBox(height: 12),
          // CompleteProfileWidgets.buildTextFieldRow(
          //   label: "Contact Number",
          //   hintText: "Enter Contact Number",
          //   controller: _contactNumberController,
          // ),
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
