import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'MyProfile.dart';
import 'bottom_navigation_bar.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int _selectedIndex = 0;

  final TextEditingController countryController = TextEditingController();
  final TextEditingController casteController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController minAgeController = TextEditingController();
  final TextEditingController maxAgeController = TextEditingController();
  final TextEditingController minHeightController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();

  String selectedText = '';

  String selectedCivilStatus = '';
  String selectedEmploymentType = '';
  String selectedReligion = '';

  List<String> countryTags = [];
  List<String> casteTags = [];
  List<String> languageTags = [];

  void _addCountryTag() {
    setState(() {
      countryTags.add(countryController.text);
      countryController.clear();
    });
  }

  void _addCasteTag() {
    setState(() {
      casteTags.add(casteController.text);
      casteController.clear();
    });
  }

  void _addLanguageTag() {
    setState(() {
      languageTags.add(languageController.text);
      languageController.clear();
    });
  }

  void _storeSelectedValues() {
    final selectedValues = {
      'country': countryTags,
      'caste': casteTags,
      'language': languageTags,
      'civilStatus': selectedCivilStatus,
      'employmentType': selectedEmploymentType,
      'religion': selectedReligion,
      'minAge': minAgeController.text,
      'maxAge': maxAgeController.text,
      'minHeight': minHeightController.text,
      'maxHeight': maxHeightController.text,
    };

    print('Selected Values: $selectedValues');

    // Example: If you are using Firebase Firestore to store the data
    // FirebaseFirestore.instance.collection('userPreferences').add(selectedValues).then((_) {
    //   print('Values stored successfully');
    // }).catchError((error) {
    //   print('Failed to store values: $error');
    // });

    // Optionally, navigate to another page or show a success message
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => ProfilePage(
    //           docId: '',
    //         )));
  }

  void _clearAllSelections() {
    setState(() {
      countryTags.clear();
      countryController.clear();
      casteTags.clear();
      casteController.clear();
      languageTags.clear();
      languageController.clear();
      selectedCivilStatus = '';
      selectedEmploymentType = '';
      selectedReligion = '';
      minAgeController.clear();
      maxAgeController.clear();
      minHeightController.clear();
      maxHeightController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyMateThemes.backgroundColor,
        title: SafeArea(
          child: Center(
            child: Text(
              'Filter',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: MyMateThemes.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(height: 48),
                SizedBox(width: 60),
                Text(
                  'Civil Status',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            SvgPicture.asset('assets/images/Line 11.svg'),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildContainer('UnMarried', 'civilStatus'),
                SizedBox(width: 20),
                buildContainer('Divorced', 'civilStatus'),
                SizedBox(width: 20),
                buildContainer('Widowed', 'civilStatus'),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'Employment Type',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            SvgPicture.asset('assets/images/Line 11.svg'),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildContainer('Government', 'employmentType'),
                SizedBox(width: 5),
                buildContainer('Private', 'employmentType'),
                SizedBox(width: 5),
                buildContainer('Self Employed', 'employmentType'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 32),
                buildContainer('Unemployed', 'employmentType'),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'Country/District',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SvgPicture.asset('assets/images/Line 11.svg'),
            SizedBox(height: 20),
            _buildTextField(
                countryController, 'Country/District', _addCountryTag),
            SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              children: countryTags.map((tag) => _buildTag(tag)).toList(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'Age',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            SvgPicture.asset('assets/images/Line 11.svg'),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildText(minAgeController, 'Min'),
                SizedBox(width: 20),
                Text('-'),
                SizedBox(width: 20),
                _buildText(maxAgeController, 'Max'),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'Height',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            SvgPicture.asset('assets/images/Line 11.svg'),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildText(minHeightController, 'Min'),
                SizedBox(width: 20),
                Text('-'),
                SizedBox(width: 20),
                _buildText(maxHeightController, 'Max'),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'Religion',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            SvgPicture.asset('assets/images/Line 11.svg'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 40),
                buildContainer('Hindusiam', 'religion'),
                SizedBox(width: 5),
                buildContainer('Christianity', 'religion'),
                SizedBox(width: 5),
                buildContainer('Buddishm', 'religion'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 40),
                buildContainer('Islam', 'religion'),
                SizedBox(width: 5),
                buildContainer('Irreligious', 'religion'),
                SizedBox(width: 5),
                buildContainer('Others', 'religion'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'Caste',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SvgPicture.asset('assets/images/Line 11.svg'),
            SizedBox(height: 20),
            _buildTextField(casteController, 'Caste', _addCasteTag),
            SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              children: casteTags.map((tag) => _buildTag(tag)).toList(),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'Language',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SvgPicture.asset('assets/images/Line 11.svg'),
            SizedBox(height: 20),
            _buildTextField(languageController, 'Language', _addLanguageTag),
            SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              children: languageTags.map((tag) => _buildTag(tag)).toList(),
            ),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _clearAllSelections,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyMateThemes.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Clear',
                    style: TextStyle(color: Colors.black, letterSpacing: 1.5),
                  ),
                ),
                SizedBox(width: 26),
                ElevatedButton(
                  onPressed: _storeSelectedValues,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyMateThemes.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(color: Colors.white, letterSpacing: 1.5),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(),
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

  Widget _buildTextField(TextEditingController controller, String hintText,
      VoidCallback onSubmitted) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: MyMateThemes.secondaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: 300,
          height: 37, // Increased height to accommodate TextField
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(8.0), // Adjust padding as needed
                hintText: hintText,
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  onSubmitted();
                }
              },
              onChanged: (value) {
                setState(() {}); // Rebuild to show suggestion tag
              },
            ),
          ),
        ),
        if (controller.text.isNotEmpty)
          GestureDetector(
            onTap: onSubmitted,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: MyMateThemes.secondaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text('+ Add "${controller.text}"'),
            ),
          ),
      ],
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

  Widget buildContainer(String text, String category) {
    final isSelected =
        (category == 'civilStatus' && selectedCivilStatus == text) ||
            (category == 'employmentType' && selectedEmploymentType == text) ||
            (category == 'religion' && selectedReligion == text);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (category == 'civilStatus') {
            selectedCivilStatus = text;
          } else if (category == 'employmentType') {
            selectedEmploymentType = text;
          } else if (category == 'religion') {
            selectedReligion = text;
          }
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? MyMateThemes.primaryColor
              : MyMateThemes.secondaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : MyMateThemes.primaryColor,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  Widget _buildText(TextEditingController controller, String hintText) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: MyMateThemes.secondaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: 84,
          height: 35, // Increased height to accommodate TextField
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(8.0), // Adjust padding as needed
                hintText: hintText,
              ),
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
