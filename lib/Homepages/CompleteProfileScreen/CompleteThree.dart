import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // For making the HTTP request
import 'dart:convert'; // For encoding the data
import '../../MyMateThemes.dart';
import '../ClosableContainer.dart';
import 'CompleteProfileWidgets.dart';

class PageThree extends StatefulWidget {
  final VoidCallback onSave;
  final String docId;

  PageThree({required this.onSave,required this.docId});

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
    _selectedReligion = '-- Select Option --';
    _selectedLanguage = '-- Select Option --';
    _casteController.text = '';
    _siblingsController.text = '';
    _bioController.text = '';
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

  Future<void> _saveForm() async {
    if (_validateForm()) {
      final Map<String, dynamic> data = {
        'docId': widget.docId,

        'lifestyle': {
          'expectations': controllers.map((c) => c.text).toList(),
        },
      };

      final url = 'https://backend.graycorp.io:9000/mymate/api/v1/saveClientData';
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
            error = 'Failed to save data: ${response.body}';
          });
        }
      } catch (e) {
        setState(() {
          error = 'Error while saving data: $e';
        });
      }
    }
  }

  Future<void> _updateForm() async {
    if (_validateForm()) {
      final Map<String, dynamic> data = {
        'docId': widget.docId,
        'personalDetails': {
          'religion': _selectedReligion,
          'language': _selectedLanguage,
          'caste': _casteController.text,
          'num_of_siblings': _siblingsController.text,
          'bio': _bioController.text,
        },

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
            error = 'Failed to save data: ${response.body}';
          });
        }
      } catch (e) {
        setState(() {
          error = 'Error while saving data: $e';
        });
      }
    }
  }

  void _saveAndUpdateForms() async {
  await _saveForm();
   await _updateForm();
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
                backgroundColor: MaterialStateProperty.all<Color>(MyMateThemes.secondaryColor),
                foregroundColor: MaterialStateProperty.all<Color>(MyMateThemes.primaryColor),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('+ Add more'),
              ),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: _saveAndUpdateForms, // Save form data when pressed
            style: CommonButtonStyle.commonButtonStyle(),
            child: Text('Complete'),
          ),
        ],
      ),
    );
  }
}
