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
          content:
          StatefulBuilder(  // Add StatefulBuilder to manage state inside the dialog
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Name Input
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyMateThemes.textColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:IntrinsicHeight(
                      child:
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(

                          color: MyMateThemes.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    ),
                  ),
                  SizedBox(height: 15),

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
                          const Text('Male',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      SizedBox(width: 40),
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
                          const Text('Female',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  // Date Picker
                  Container(
                    width: 300,
                    height: 70,
                    padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyMateThemes.textColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Expanded(
                          child:
                          TextField(
                            controller: dobController,
                            readOnly: true,
                            onTap: () => _selectDate(context, setDialogState),
                            decoration: InputDecoration(
                              labelText: "Date Of Birth",
                              hintText: 'DD/MM/YY',
                              hintStyle: TextStyle(
                                color: MyMateThemes.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                              labelStyle: TextStyle(
                                color: MyMateThemes.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.calendar_today),
                              contentPadding: EdgeInsets.only(top: 5), // Adjust field padding
                            ),
                          ),
                        ),
                        // Text(
                        //   'DD/MM/YY',  // Custom helper text
                        //   style: TextStyle(
                        //     color: MyMateThemes.textColor.withOpacity(0.5),
                        //     fontWeight: FontWeight.w400,
                        //     fontSize: 14,  // Adjust size if needed
                        //   ),
                        // ),
                        SizedBox(height: 6),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  // Place of Birth Input
                  Container(
                    width: 300,

                    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyMateThemes.textColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IntrinsicHeight( // Allows height to adjust based on content
                      child: GooglePlaceAutoCompleteTextField(
                        countries: ["LK"],
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: MyMateThemes.textColor
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
                            fontSize: 15,
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
                              TextPosition(offset: prediction.description?.length ?? 0));
                        },
                        seperatedBuilder: Divider(),
                        containerHorizontalPadding: 10,
                        itemBuilder: (context, index, Prediction prediction) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(width: 7),
                                Expanded(
                                    child: Text(
                                      prediction.description ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          );
                        },
                        isCrossBtnShown: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Time Picker
                  Container(
                    width: 300,
                    height: 70,
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                          color:MyMateThemes.textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.access_time),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

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

        String? selectedGender; // Local state for gender inside dialog

        return AlertDialog(
          backgroundColor: Colors.white,
          content:
          StatefulBuilder(  // Add StatefulBuilder to manage state inside the dialog
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height:20),
                  Container(
                      height: 40,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyMateThemes.textColor.withOpacity(0.1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 1),
                        child:TextField(
                          controller: searchController,
                          cursorColor: MyMateThemes.textColor,
                          style: TextStyle(fontSize: 14, color: MyMateThemes.textColor),
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: MyMateThemes.textColor,fontSize: 15,fontWeight:FontWeight.w300,letterSpacing: 0.8),
                            prefixIcon: Padding(
                              //  padding:EdgeInsets.symmetric(horizontal: 25.w), // Adjust padding if needed
                              padding: EdgeInsets.all(8), // Adjust padding if needed

                              child: SvgPicture.asset(
                                'assets/images/search.svg', // Update with your SVG path
                                colorFilter: ColorFilter.mode(
                                  MyMateThemes.textColor.withOpacity(0.3),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 3), // Centers text vertically
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                      )
                  ),
                  SizedBox(height: 15),

                  // Confirm Button
                  ElevatedButton(
                    onPressed: () {
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

        String? selectedGender; // Local state for gender inside dialog

        return AlertDialog(
          backgroundColor: Colors.white,
          content:
          StatefulBuilder(  // Add StatefulBuilder to manage state inside the dialog
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height:20),
                  Container(
                      height: 40,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyMateThemes.textColor.withOpacity(0.1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 1),
                        child:TextField(
                          controller: searchController,
                          cursorColor: MyMateThemes.textColor,
                          style: TextStyle(fontSize: 14, color: MyMateThemes.textColor),
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: MyMateThemes.textColor,fontSize: 15,fontWeight:FontWeight.w300,letterSpacing: 0.8),
                            prefixIcon: Padding(
                              //  padding:EdgeInsets.symmetric(horizontal: 25.w), // Adjust padding if needed
                              padding: EdgeInsets.all(8), // Adjust padding if needed

                              child: SvgPicture.asset(
                                'assets/images/search.svg', // Update with your SVG path
                                colorFilter: ColorFilter.mode(
                                  MyMateThemes.textColor.withOpacity(0.3),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 3), // Centers text vertically
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                      )
                  ),
                  SizedBox(height: 15),

                  // Confirm Button
                  ElevatedButton(
                    onPressed: () {
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
              );
            },
          ),
        );
      },
    );
  }

  Widget buildDropdown(bool isLeft) {
    List<String> dropdownItems = isLeft
        ? ['@ My username', 'Add New', 'Global Search'] // Left dropdown (without "Add New")
        : ['Select', 'Add New', 'Add Friends', 'Global Search']; // Right dropdown (with "Add New")


    return Container(
      width: 165,
      height: 45,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:MyMateThemes.containerColor,
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
                  color:MyMateThemes.textColor,
                  fontSize: 15,
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
                }
                else if (newValue == 'Global Search') {
                  showGlobalSearchPopup(true);

                }
              } else {
                rightDropdownValue = newValue!;
                if (newValue == 'Add New') {
                  showAddNewPopup(false);
                }
                else if (newValue == 'Add Friends') {
                  showAddFriendPopup(false);
                }
                else{
                showGlobalSearchPopup(false);
                }
              }
            });
          },
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
        ),
      ),
    );
  }
  Widget buildLeftDetailContainer(Map<String, String> details) {
    return Column(
      children: details.entries.map((entry) =>
          Container(
            width: 165,
            height: 40,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: MyMateThemes.textColor.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                ' ${entry.value}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: MyMateThemes.textColor.withOpacity(0.8),
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
            width: 165,
            height: 40,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: MyMateThemes.textColor.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                ' ${entry.value}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: MyMateThemes.textColor.withOpacity(0.8),
                ),
              ),
            ),
          ),
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height:30),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubscribedhomescreenStructuredPage(docId: '',)));
                  },
                  child: SvgPicture.asset('assets/images/chevron-left.svg',
                    height: 14,
                    width:14,),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDropdown(true),
                buildDropdown(false),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: buildLeftDetailContainer(leftDetails)),
                SizedBox(width: 20),
                Expanded(child: buildRightDetailContainer(rightDetails)),
              ],
            ),
            SizedBox(height: 40),

            Container(
                height: 70,
                width: 325,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child:
                ElevatedButton(
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
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                    ),
                  ),
                  child: Text('Check Match'),
                )

            ),

          ],
        ),
      ),
    );
  }
}
