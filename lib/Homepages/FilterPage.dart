import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../MyMateCommonBodies/MyMateApis.dart';
import '../MyMateThemes.dart';
import 'explorePage/explorePageMain.dart';

class FilterPage extends StatefulWidget {


  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // final TextEditingController countryController = TextEditingController();
  // final TextEditingController casteController = TextEditingController();
  // final TextEditingController languageController = TextEditingController();
  // final TextEditingController minAgeController = TextEditingController();
  // final TextEditingController maxAgeController = TextEditingController();

  final TextEditingController AgeController = TextEditingController();
  String marital_status = '';
  String occupation_type = '';
  String age = '';

  // List<String> countryTags = [];
  // List<String> casteTags = [];
  // List<String> languageTags = [];

  void _addTag(TextEditingController controller, List<String> tags) {
    if (controller.text.isNotEmpty) {
      setState(() {
        tags.add(controller.text);
        controller.clear();
      });
    }
  }

  void _clearAllSelections() {
    setState(() {
      // countryTags.clear();
      // casteTags.clear();
      // languageTags.clear();
      marital_status = '';
      occupation_type = '';
      AgeController.clear();
      // minAgeController.clear();
      // maxAgeController.clear();
    });
  }

  // Future<void> _applyFilters() async {
  //   // Build the query parameters dynamically
  //   final queryParams = {
  //
  //     if (maritalStatus.isNotEmpty) 'marital_status': maritalStatus,
  //     if (selectedOccupationType.isNotEmpty) 'occupation_type': selectedOccupationType,
  //     if (minAgeController.text.isNotEmpty) 'min_age': minAgeController.text,
  //     if (maxAgeController.text.isNotEmpty) 'max_age': maxAgeController.text,
  //   };
  //
  //   // Construct the URL with query parameters
  //   final uri = Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/clientFilter')
  //       .replace(queryParameters: queryParams);
  //
  //   // Make the GET request
  //   final response = await http.get(
  //     uri,
  //     headers: {'Content-Type': 'application/json'}, // Add any additional headers if needed
  //   );
  //
  //   // Log the request and response for debugging
  //   print('Request URL: $uri');
  //   print('Response Status: ${response.statusCode}');
  //   print('Response Body: ${response.body}');
  //
  //   // Handle the response
  //   if (response.statusCode == 200) {
  //     final results = json.decode(response.body);
  //
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Explorepage(results: results),
  //       ),
  //     );
  //   } else {
  //     print('Failed response: ${response.body}');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to fetch results: ${response.reasonPhrase}')),
  //     );
  //   }
  // }

  // Future<void> _applyFilters() async {
  //   final filters = {
  //
  //     if(marital_status!=null){
  //       'occupation_type': occupation_type
  //     }
  //     else{
  //       print('hello')
  //     }
  //     //
  //     //
  //     // if (occupation_type.isNotEmpty) 'occupation_type': occupation_type,
  //     // if (minAgeController.text.isNotEmpty) 'min_age': minAgeController.text,
  //     // if (maxAgeController.text.isNotEmpty) 'max_age': maxAgeController.text,
  //   };
  //
  //
  //
  //   try
  //   {
  //     final results = await filterAllUsers(filters as Map<String, String>); // Fetch filtered profiles
  //     print('Filtered Results: $results');
  //
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ExplorePage(
  //           initialTabIndex: 2,
  //           results: [], // Provide filtered or default results
  //         ),
  //       ),
  //     );
  //
  //   } catch (error) {
  //     print('Error: $error');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to fetch results: $error')),
  //     );
  //   }
  // }

  Future<void> _applyFilters() async {
    final Map<String, String> filters = {};

    // Add filters conditionally
    if (marital_status != null) {
      filters['marital_status'] = marital_status!;
    }

    if (occupation_type.isNotEmpty) {
      filters['occupation_type'] = occupation_type;
    }

    if (AgeController.text.isNotEmpty) {
      filters['age'] = AgeController.text;
    }

    try {
      // Fetch filtered profiles
      final results = await filterAllUsers(filters);
      print('Filtered Results: $results');

      // ✅ Pass all necessary data back to `ExplorePage`
      Navigator.pop(context, {
        'filters': filters,
        'results': results,
        'initialTabIndex': 2, // ✅ Ensure tab index is passed back
        'search': [], // ✅ Preserve search parameter
        'docId': '', // ✅ Preserve docId
      });
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch results: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;

          return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,

            title: SafeArea(
              child: Row(
                children: [
                  // GestureDetector(
                  //   child: SvgPicture.asset('assets/images/chevron-left.svg'),
                  // ),
                  SizedBox(width: width*0.11),
                  Text(
                    'Filter',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: width*0.05,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: MyMateThemes.backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height*0.02),

                Row(
                  children: [
                    SizedBox(width: width*0.15),

                    Text(
                      'Civil Status',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: width*0.038,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height*0.01),
                SvgPicture.asset('assets/images/Line 11.svg',width: width*0.8,),
                SizedBox(height: height*0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSelectableButton('Single', 'marital_status', () => marital_status = 'Single'),
                    _buildSelectableButton('Divorced', 'marital_status', () => marital_status = 'Divorced'),
                    _buildSelectableButton('Widowed', 'marital_status', () => marital_status = 'Widowed'),
                  ],
                ),
                SizedBox(height: height*0.05),
                Row(
                  children: [
                    SizedBox(width: width*0.15),
                    Text(
                      'Employment Type',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: width*0.038,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height*0.01),
                SvgPicture.asset('assets/images/Line 11.svg',width: width*0.8,),
                SizedBox(height: height*0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSelectableButton('Government', 'occupation_type', () => occupation_type = 'Government'),
                    _buildSelectableButton('Private', 'occupation_type', () => occupation_type = 'Private'),
                    _buildSelectableButton('Self', 'occupation_type', () => occupation_type = 'Self'),
                  ],
                ),
                // Row(
                //   children: [
                //     SizedBox(width: 60),
                //     Text(
                //       'Height',
                //       style: TextStyle(
                //         color: MyMateThemes.textColor,
                //         fontSize: 14,
                //         fontWeight: FontWeight.normal,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 15),
                // SvgPicture.asset('assets/images/Line 11.svg'),
                // SizedBox(height: 30),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     _buildText(minHeightController, 'Min'),
                //     SizedBox(width: 20),
                //     Text('-'),
                //     SizedBox(width: 20),
                //     _buildText(maxHeightController, 'Max'),
                //   ],
                // ),
                // SizedBox(height: 40),
                // Row(
                //   children: [
                //     SizedBox(width: 60),
                //     Text(
                //       'Religion',
                //       style: TextStyle(
                //         color: MyMateThemes.textColor,
                //         fontSize: 14,
                //         fontWeight: FontWeight.normal,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 15),
                // SvgPicture.asset('assets/images/Line 11.svg'),
                // SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SizedBox(width: 40),
                //     buildContainer('Hindusiam', 'religion'),
                //     SizedBox(width: 5),
                //     buildContainer('Christianity', 'religion'),
                //     SizedBox(width: 5),
                //     buildContainer('Buddishm', 'religion'),
                //   ],
                // ),
                // SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SizedBox(width: 40),
                //     buildContainer('Islam', 'religion'),
                //     SizedBox(width: 5),
                //     buildContainer('Irreligious', 'religion'),
                //     SizedBox(width: 5),
                //     buildContainer('Others', 'religion'),
                //   ],
                // ),
                // SizedBox(height: 20),
                // Row(
                //   children: [
                //     SizedBox(width: 60),
                //     Text(
                //       'Caste',
                //       style: TextStyle(
                //         color: MyMateThemes.textColor,
                //         fontSize: 14,
                //         fontWeight: FontWeight.normal,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 20),
                // SvgPicture.asset('assets/images/Line 11.svg'),
                // SizedBox(height: 20),
                // _buildTextField(casteController, 'Caste', _addCasteTag),
                // SizedBox(height: 20),
                // Wrap(
                //   alignment: WrapAlignment.center,
                //   children: casteTags.map((tag) => _buildTag(tag)).toList(),
                // ),
                // SizedBox(height: 30),
                // Row(
                //   children: [
                //     SizedBox(width: 60),
                //     Text(
                //       'Language',
                //       style: TextStyle(
                //         color: MyMateThemes.textColor,
                //         fontSize: 14,
                //         fontWeight: FontWeight.normal,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 20),
                // SvgPicture.asset('assets/images/Line 11.svg'),
                // SizedBox(height: 20),
                // _buildTextField(languageController, 'Language', _addLanguageTag),
                // SizedBox(height: 20),
                // Wrap(
                //   alignment: WrapAlignment.center,
                //   children: languageTags.map((tag) => _buildTag(tag)).toList(),
                // ),
                SizedBox(height: height*0.05),
                Row(
                  children: [
                    SizedBox(width: width*0.15),
                    Text(
                      'Age',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: width*0.038,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height*0.01),
                SvgPicture.asset('assets/images/Line 11.svg',width: width*0.8,),
                SizedBox(height: height*0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildText(AgeController, 'Age'),

                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     _buildText(minAgeController, 'Min'),
                //     SizedBox(width: 20),
                //     _buildText(maxAgeController, 'Max'),
                //   ],
                // ),
                SizedBox(height: height*0.13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height*0.07,
                      width: width*0.3,
                      child: ElevatedButton(
                        onPressed: _clearAllSelections,
                        style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
                          backgroundColor: MaterialStatePropertyAll(MyMateThemes.containerColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(width*0.01)
                              )),

                        ),
                        child: Text('Clear', style: TextStyle(color: MyMateThemes.primaryColor,fontSize: width*0.04)),
                      ),
                    ),
                    SizedBox(width: width*0.08),
                    SizedBox(
                      height: height*0.07,
                      width: width*0.3,
                      child: ElevatedButton(
                        onPressed: _applyFilters,
                        style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(Colors.white),
                          backgroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(width*0.01)
                              )),

                        ),
                        child: Text('Apply', style: TextStyle(color: Colors.white,fontSize: width*0.04)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: MyMateThemes.textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableButton(String label, String category, VoidCallback onTap) {
    final isSelected = (category == 'marital_status' && marital_status == label) ||
        (category == 'occupation_type' && occupation_type == label);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        setState(onTap);
      },
      child:Container(
        margin: EdgeInsets.symmetric(horizontal: width*0.02, vertical: height*0.04),
        padding: EdgeInsets.symmetric(horizontal: width*0.045, vertical: height*0.016),
        decoration: BoxDecoration(
          color: isSelected
              ? MyMateThemes.primaryColor
              : MyMateThemes.containerColor,
          borderRadius: BorderRadius.circular(width*0.01),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : MyMateThemes.primaryColor,
            fontSize: width*0.035,
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: MyMateThemes.primaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget _buildTagChip(String tag, List<String> tags) {
    return Chip(
      label: Text(tag),
      onDeleted: () {
        setState(() {
          tags.remove(tag);
        });
      },
    );
  }

  Widget _buildText(TextEditingController controller, String hintText) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: MyMateThemes.containerColor,
            borderRadius: BorderRadius.circular(width*0.01),
          ),
          width: width*0.3,
          height: height*0.055, // Increased height to accommodate TextField
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:width*0.025,vertical: height*0.005),
            child: TextField(
              style: TextStyle(color: MyMateThemes.textColor,fontWeight: FontWeight.normal,fontSize: width*0.04),


    controller: controller,
              decoration: InputDecoration(

                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal:width*0.02,vertical:height*0.012), // Adjust padding as needed

                hintText: hintText,
                hintStyle:
                TextStyle(color: MyMateThemes.textColor.withOpacity(0.7),fontWeight: FontWeight.normal,fontSize: width*0.04),              ),
              onChanged: (value) {
                setState(() {}); // Rebuild to show suggestion tag
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ResultsPage extends StatelessWidget {
  final List results;

  const ResultsPage({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
        ),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final item = results[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item['name'] ?? 'Unknown'),
                Text(item['detail'] ?? 'No details'),
              ],
            ),
          );
        },
      ),
    );
  }
}
