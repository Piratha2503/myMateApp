import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../dbConnection/Firebase.dart';
import 'CheckMatch.dart';
import '../SubscribedhomeScreen/SubscribedHomeScreenStructured.dart';


class CheckMatchOptionsScreen extends StatefulWidget {
  final String clientDocId;
  final String soulDocId;
  const CheckMatchOptionsScreen({Key? key, required this.clientDocId, required this.soulDocId}) : super(key: key);

  @override
  _CheckMatchOptionsScreenState createState() => _CheckMatchOptionsScreenState();
}

class _CheckMatchOptionsScreenState extends State<CheckMatchOptionsScreen> {
  final Firebase firebase = Firebase();

  String leftDropdownValue = '@ My username';
  String rightDropdownValue = 'Select';
  String district = "";
  TimeOfDay selectedTime = TimeOfDay.now();
  String amPm = "AM";
  String gender = "Male";
  String? _selectedValue;

  String soulfull_name = "";
  String? soulprofilePicUrl;
  String souldob = "";
  String souldot = "";
  String soulcity = "";
  String soulcountry = "";

  String? clientprofilePicUrl;
  String? clientfull_name="";
  String? clientdob="";
  String? clientdot="";
  String? clientcity="";
  String? clientcountry="";


  Future<void> getProfileData() async {
    final soulData = await fetchUserById(widget.soulDocId);
    final clientData = await fetchUserById(widget.clientDocId);

    if (soulData.isNotEmpty && clientData.isNotEmpty) {
      setState(() {
        soulfull_name = soulData['full_name'] ?? "N/A";
        soulprofilePicUrl = soulData['profile_pic_url'] ?? '';
        souldob = soulData['dob'] ?? "N/A";
        souldot = soulData['dot'] ?? "N/A";
        soulcity = soulData['city'] ?? "N/A";
        soulcountry = soulData['country'] ?? "N/A";


        clientfull_name = clientData['full_name'] ?? "N/A";
        clientprofilePicUrl = clientData['profile_pic_url'] ?? '';  // Fetching client pic separately
        clientdob = clientData['dob'] ?? "N/A";
        clientdot = clientData['dot'] ?? "N/A";
        clientcity = clientData['city'] ?? "N/A";
        clientcountry = clientData['country'] ?? "N/A";
      });
    }
  }


  @override
  void initState() {
    super.initState();
    getProfileData();
  }



  Map<String, String> leftDetails = {
    'Name': 'John Fernando',
    'Gender': 'Male',
    'DOB': '19/10/1998',
    'POB': 'Jaffna, Sri Lanka',
    'TOB': '11:30 PM'
  };
  Map<String, String> rightDetails = {
    'Name': 'Name',
    'Gender': 'Gender',
    'DOB': 'DOB',
    'POB': 'POB',
    'TOB': 'TOB'
  };
  bool isButtonActive = false;

  void checkButtonState() {
    setState(() {
      isButtonActive = leftDetails.values.every((value) => value.isNotEmpty) &&
          rightDetails.values.every((value) => value.isNotEmpty);
    });
  }



  void showAddNewPopup(bool isLeft) {
    resizeToAvoidBottomInset: false; // Prevent resizing when the keyboard appears

    showDialog(


      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController dobController = TextEditingController();
        TextEditingController placeController = TextEditingController();
        TextEditingController timeController = TextEditingController();

        String? selectedGender; // Local state for gender inside dialog

        Future<void> _selectDate(BuildContext context, Function setDialogState) async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            setDialogState(() {  // Update the local dialog state
              dobController.text = DateFormat('dd/MM/yyyy').format(picked);
            });
          }
        }

        Future<void> _selectTime(BuildContext context, Function setDialogState) async {
          TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: selectedTime
          );
          if (picked != null) {
            setDialogState(() {  // Update the local dialog state
              selectedTime = picked;
              amPm = picked.period == DayPeriod.am ? "AM" : "PM";
              timeController.text =
              "${picked.hourOfPeriod.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')} $amPm";
            });
          }
        }

        return AlertDialog(
          backgroundColor: Colors.white,
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              double width = MediaQuery.of(context).size.width;
              double height = MediaQuery.of(context).size.height;
              double fontSize = width * 0.04;

              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Name Input
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: EdgeInsets.symmetric(vertical: height * 0.005, horizontal: width * 0.025),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyMateThemes.textColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(width*0.02),
                      ),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: MyMateThemes.textColor,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: height*0.01),

                    // Gender Selection (Now updates correctly)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Male',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setDialogState(() {  // Updates state inside dialog
                                  selectedGender = value!;
                                });
                              },
                              activeColor:MyMateThemes.primaryColor,
                            ),
                             Text('Male',
                              style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(width: width*0.04),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Female',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setDialogState(() {  // Updates state inside dialog
                                  selectedGender = value!;
                                });
                              },
                              activeColor: MyMateThemes.primaryColor,
                            ),
                             Text('Female',
                              style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.01),
                    // Date Picker
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.07,
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.005,
                        horizontal: MediaQuery.of(context).size.width * 0.025,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyMateThemes.textColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: dobController,
                              readOnly: true,
                              onTap: () => _selectDate(context, setDialogState),
                              decoration: InputDecoration(
                                labelText: "Date Of Birth",
                                hintText: 'DD/MM/YY',
                                hintStyle: TextStyle(
                                  color: MyMateThemes.textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                ),
                                labelStyle: TextStyle(
                                  color: MyMateThemes.textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                ),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.calendar_today),
                                contentPadding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.007,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.01),

                    // Place of Birth Input
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.07,

                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.008,
                        horizontal: MediaQuery.of(context).size.width * 0.02,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyMateThemes.textColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IntrinsicHeight(
                        child: GooglePlaceAutoCompleteTextField(
                          countries: ["LK"],
                          textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: MyMateThemes.textColor,
                          ),
                          boxDecoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: Colors.transparent),
                            ),
                          ),
                          textEditingController: placeController,
                          googleAPIKey: "AIzaSyAFhnkirk4iFypOdxfiECUWKRVOtE0azMo",
                          inputDecoration: InputDecoration(
                            labelText: "Place of birth",
                            labelStyle: TextStyle(
                              color: MyMateThemes.textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          debounceTime: 400,
                          isLatLngRequired: true,
                          getPlaceDetailWithLatLng: (Prediction prediction) {
                            print("placeDetails${prediction.lat}");
                          },
                          itemClick: (Prediction prediction) {
                            List<String>? stringList = prediction.description?.split(",");
                            setState(() {
                              district = stringList![0].toString();
                            });
                            placeController.text = prediction.description ?? "";
                            placeController.selection = TextSelection.fromPosition(
                              TextPosition(offset: prediction.description?.length ?? 0),
                            );
                          },
                          seperatedBuilder: Divider(),
                          containerHorizontalPadding: 10,
                          itemBuilder: (context, index, Prediction prediction) {
                            return Container(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      prediction.description ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          isCrossBtnShown: true,
                        ),
                      ),
                    ),
                    SizedBox(height: height*0.01),

                    // Time Picker
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.07,
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.007,
                        horizontal: MediaQuery.of(context).size.width * 0.025,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyMateThemes.textColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: timeController,
                        readOnly: true,
                        onTap: () => _selectTime(context, setDialogState),
                        decoration: InputDecoration(
                          labelText: "Time Of Birth",
                          labelStyle: TextStyle(
                            color: MyMateThemes.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                    SizedBox(height: height*0.01),

                    // Confirm Button
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isEmpty ||
                            selectedGender == null ||
                            dobController.text.isEmpty ||
                            placeController.text.isEmpty ||
                            timeController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Please complete all fields."),
                              backgroundColor: MyMateThemes.primaryColor,
                            ),
                          );
                          return;
                        }

                        Navigator.of(context).pop();
                        setState(() { // Update main widget state
                          if (isLeft) {
                            leftDetails = {
                              'Name': nameController.text,
                              'Gender': selectedGender!, // Use selectedGender instead of _selectedValue
                              'DOB': dobController.text,
                              'POB': placeController.text,
                              'TOB': timeController.text,
                            };
                          } else {
                            rightDetails = {
                              'Name': nameController.text,
                              'Gender': selectedGender!, // Use selectedGender instead of _selectedValue
                              'DOB': dobController.text,
                              'POB': placeController.text,
                              'TOB': timeController.text,
                            };
                          }
                          checkButtonState();
                        });
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(MyMateThemes.primaryColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                        ),
                      ),
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showAddFriendPopup(bool isLeft) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController dobController = TextEditingController();
        TextEditingController placeController = TextEditingController();
        TextEditingController timeController = TextEditingController();
        TextEditingController searchController = TextEditingController();

        String? selectedGender;

        return AlertDialog(
          backgroundColor: Colors.white,
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              double screenWidth = MediaQuery.of(context).size.width;
              double screenHeight = MediaQuery.of(context).size.height;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyMateThemes.textColor.withOpacity(0.1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                      child: TextField(
                        controller: searchController,
                        cursorColor: MyMateThemes.textColor,
                        style: TextStyle(fontSize: screenWidth * 0.04, color: MyMateThemes.textColor),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: MyMateThemes.textColor,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.8,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            child: SvgPicture.asset(
                              'assets/images/search.svg',
                              height: screenHeight*0.01,
                              colorFilter: ColorFilter.mode(
                                MyMateThemes.textColor.withOpacity(0.3),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        if (isLeft) {
                          leftDetails = {
                            'Name': nameController.text,
                            'Gender': selectedGender!,
                            'DOB': dobController.text,
                            'POB': placeController.text,
                            'TOB': timeController.text,
                          };
                        } else {
                          rightDetails = {
                            'Name': nameController.text,
                            'Gender': selectedGender!,
                            'DOB': dobController.text,
                            'POB': placeController.text,
                            'TOB': timeController.text,
                          };
                        }
                        checkButtonState();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: MyMateThemes.primaryColor,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                        horizontal: screenWidth * 0.1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Text('Confirm'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
  void showGlobalSearchPopup(bool isLeft) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController dobController = TextEditingController();
        TextEditingController placeController = TextEditingController();
        TextEditingController timeController = TextEditingController();
        TextEditingController searchController = TextEditingController();

        String? selectedGender;

        return AlertDialog(
          backgroundColor: Colors.white,
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              double screenWidth = MediaQuery.of(context).size.width;
              double screenHeight = MediaQuery.of(context).size.height;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyMateThemes.textColor.withOpacity(0.1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                      child: TextField(
                        controller: searchController,
                        cursorColor: MyMateThemes.textColor,
                        style: TextStyle(fontSize: screenWidth * 0.04, color: MyMateThemes.textColor),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: MyMateThemes.textColor,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.8,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            child: SvgPicture.asset(
                              'assets/images/search.svg',
                              height: screenHeight*0.01,
                              width: screenWidth*0.01,
                              colorFilter: ColorFilter.mode(
                                MyMateThemes.textColor.withOpacity(0.3),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenWidth*0.02),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        if (isLeft) {
                          leftDetails = {
                            'Name': nameController.text,
                            'Gender': selectedGender!,
                            'DOB': dobController.text,
                            'POB': placeController.text,
                            'TOB': timeController.text,
                          };
                        } else {
                          rightDetails = {
                            'Name': nameController.text,
                            'Gender': selectedGender!,
                            'DOB': dobController.text,
                            'POB': placeController.text,
                            'TOB': timeController.text,
                          };
                        }
                        checkButtonState();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: MyMateThemes.primaryColor,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                        horizontal: screenWidth * 0.1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Text('Confirm'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget buildDropdown(bool isLeft) {
    List<String> dropdownItems = isLeft
        ? ['@ My username', 'Add New', 'Global Search']
        : ['Select', 'Add New', 'Add Friends', 'Global Search'];

    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      height: MediaQuery.of(context).size.height * 0.06,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: MyMateThemes.containerColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: isLeft
              ? (dropdownItems.contains(leftDropdownValue) ? leftDropdownValue : dropdownItems.first)
              : (dropdownItems.contains(rightDropdownValue) ? rightDropdownValue : dropdownItems.first),
          items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              if (isLeft) {
                leftDropdownValue = newValue!;
                if (newValue == 'Add New') {
                  showAddNewPopup(true);
                } else if (newValue == 'Global Search') {
                  showGlobalSearchPopup(true);
                }
              } else {
                rightDropdownValue = newValue!;
                if (newValue == 'Add New') {
                  showAddNewPopup(false);
                } else if (newValue == 'Add Friends') {
                  showAddFriendPopup(false);
                } else {
                  showGlobalSearchPopup(false);
                }
              }
            });
          },
          icon:  Icon(Icons.arrow_drop_down, color: Colors.black54),
        ),
      ),
    );
  }
  Widget buildLeftDetailContainer(Map<String, String> details) {

    return Column(
      children: details.entries.map((entry) =>
          Container(
            width: MediaQuery.of(context).size.width * 0.43,
            height: MediaQuery.of(context).size.height * 0.055,

            padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            margin:  EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height * 0.01),
            decoration: BoxDecoration(
              border: Border.all(color: MyMateThemes.textColor.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                ' ${entry.value}',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.normal,
                  color: MyMateThemes.textColor,
                ),

              ),
            ),
          ),
      ).toList(),
    );
  }
  Widget buildRightDetailContainer(Map<String, String> details) {
    return Column(
      children: details.entries.map((entry) =>
          Container(
            width: MediaQuery.of(context).size.width * 0.43,
            height: MediaQuery.of(context).size.height * 0.055,

            padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            margin:  EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height * 0.01),
            decoration: BoxDecoration(
              border: Border.all(color: MyMateThemes.textColor.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                ' ${entry.value}',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.normal,
                  color: MyMateThemes.textColor,
                ),
              ),
            ),
          ),
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing when the keyboard appears

      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.04), // Responsive spacing
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscribedhomescreenStructuredPage(docId: ''),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/images/chevron-left.svg',
                    height: screenWidth * 0.04,
                    width: screenWidth * 0.04,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03), // Responsive spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDropdown(true),
                buildDropdown(false),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: buildLeftDetailContainer(leftDetails)),
                SizedBox(width: screenWidth * 0.06),
                Expanded(child: buildRightDetailContainer(rightDetails)),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),

            Container(
              height: screenHeight * 0.09,
              width: screenWidth * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.01),
              ),
              child: ElevatedButton(
                onPressed: isButtonActive
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckmatchPage(clientDocId: '', soulDocId: ''),
                    ),
                  );
                }
                    : null, // Disabled when isButtonActive is false
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    isButtonActive ? Colors.white : MyMateThemes.textColor, // Change color based on state
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    isButtonActive ? MyMateThemes.primaryColor : MyMateThemes.secondaryColor, // Change color based on state
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.01),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.1,
                    ),
                  ),
                ),
                child: Text('Check Match'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
