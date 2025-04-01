import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // For making the HTTP request
import 'dart:convert'; // For encoding the data
import '../../MyMateThemes.dart';
import '../ClosableContainer.dart';
import '../ProfilePageScreen/MyProfileMain.dart';
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
      final expectations = controllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList();

      final Map<String, dynamic> data = {
        'docId': widget.docId,
        'lifestyle': {
          // If there are no expectations, send null.
          'expectations': expectations.isEmpty ? null : expectations,
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

        if (response.statusCode != 200) {
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
      try {
        final response = await http.put(
          Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/updateClient'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'docId': widget.docId,
            'personalDetails': {
              'religion': _selectedReligion,
              'language': _selectedLanguage,
              'caste': _casteController.text,
              'num_of_siblings': _siblingsController.text,
              'bio': _bioController.text,
            },
          }),
        );

        if (response.statusCode == 200) {
          print('Data updated successfully');
        } else {
          setState(() {
            error = 'Failed to save data: ${response.body}';
          });
        }
      } catch (e) {
        setState(() {
          error = 'Error while updating data: $e';
        });
      }
    }
  }

  Future <void> _saveAndUpdateForms() async {
    print("Triggered _saveAndUpdateForms");

    await _saveForm();
    await _updateForm();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage(docId: widget.docId, selectedBottomBarIconIndex: 3,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height*0.03),
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
            }), context: context,
          ),
          SizedBox(height: height*0.015),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "Caste",
            hintText: "Enter your Caste",

            controller: _casteController, context: context,
          ),
          SizedBox(height: height*0.015),
          CompleteProfileWidgets.buildDropdownRow(
            label: "Language",
            value: _selectedLanguage,

            items: ['-- Select Option --', 'Tamil', 'English', 'Sinhala'],
            onChanged: (value) => setState(() {
              _selectedLanguage = value;
            }), context: context,
          ),
          SizedBox(height: height*0.015),
          CompleteProfileWidgets.buildTextFieldRow(
            label: "No of Siblings",
            hintText: "Enter Number",

            controller: _siblingsController,  context:context ,
          ),
          SizedBox(height: height*0.03),
          Row(
            children: [
              SizedBox(width: width*0.01),
              Text(
                'Bio',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: width*0.045,
                ),
              ),
            ],
          ),
          SizedBox(height: height*0.015),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: MyMateThemes.textColor.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(width * 0.02),
            ),
            height: height * 0.15,
            width: width * 0.9,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.035,
              vertical: height * 0.01,
            ),
            child: Column(
              children: [
                Expanded(
                  child: TextField(
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
                      border: InputBorder.none,
                      counterText: '', // Hide default counter
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    characterCount <= 192
                        ? '$characterCount/192'
                        : 'Character limit exceeded',
                    style: TextStyle(
                      color: characterCount > 192 ? Colors.red : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: height*0.01),
          if (error.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:  EdgeInsets.only(left: width*0.02),
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red[800]),
                ),
              ),
            ),
          SizedBox(height: height*0.02),
          Row(
            children: [
              SizedBox(width: width*0.01),
              Text(
                'Expectations',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: width*0.045,
                ),
              ),
            ],
          ),
          SizedBox(height: height*0.01),
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
          SizedBox(height: height*0.01),
          SizedBox(
            width: width*0.9,
            height: height*0.07,
            child: ElevatedButton(
              onPressed: () {
                if (controllers.length < 5) {
                  setState(() {
                    controllers.add(TextEditingController());
                  });
                }
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: MyMateThemes.secondaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width*0.03),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('+ Add more',style: TextStyle(color: MyMateThemes.primaryColor,fontSize: width*0.04,fontWeight: FontWeight.normal),),
              ),
            ),
          ),
          SizedBox(height: height*0.06),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.45,
              child:     ElevatedButton(
                onPressed: () async {
                  await _saveAndUpdateForms();
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: MyMateThemes.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width*0.01),
                ),
              ),
                child: Text('Complete', style: TextStyle(color:Colors.white,fontSize: width * 0.045,fontWeight: FontWeight.normal), // Responsive font size
    ),),
              ),
            ),
          SizedBox(height: height*0.03),

        ],
      ),
    );
  }
}