import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:mymateapp/MyMateCommonBodies/MyMateApis.dart';
import 'package:mymateapp/dbConnection/Clients.dart';
import 'package:mymateapp/dbConnection/TempClass.dart';
import '../../ManagePages/SummaryPage.dart';
import '../../MyMateThemes.dart';
import '../../dbConnection/Firebase.dart';
import '../BadgeWidget.dart';
import '../Profiles/OthersProfile.dart';


Widget SubscribedhomescreenStructuredPageTotalMatchColumn(BuildContext context, String docId) {
  return Expanded(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/Frame.svg',
                    height: constraints.maxHeight * 1.39,
                    width:  constraints.maxWidth * 1,

                    fit: BoxFit.cover,
                  ),

                ),
                Positioned(
                  top: constraints.maxHeight * 0.28, // Adjust top position
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CommonTextStyleForPage(
                      '137',
                      Colors.white,
                      FontWeight.w700,
                      constraints.maxWidth * 0.08, // Adjust font size
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.56, // Adjust top position
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CommonTextStyleForPage(
                      'Matches Found',
                      Colors.white,
                      FontWeight.w500,
                      constraints.maxWidth * 0.042, // Adjust font size
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}



Widget SubscribedhomescreenStructuredPageTokenContainers(BuildContext context, String docId) {
  return Expanded(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.6, // Adjust width
                    height: constraints.maxHeight * 0.8, // Adjust height
                    decoration: BoxDecoration(
                      color: MyMateThemes.secondaryColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.54, // Adjust top
                    right: constraints.maxWidth * 0.55, // Adjust right
                    child: SvgPicture.asset('assets/images/fire.svg',

                      color: MyMateThemes.textColor,
                      width: constraints.maxWidth * 0.25, // Adjust width
                      height: constraints.maxHeight * 0.09 , // Adjust height
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.64, // Adjust top
                    right: constraints.maxWidth * 0.48, // Adjust right
                    child: Text('Tokens',style: TextStyle(fontSize: constraints.maxWidth * 0.031,color: MyMateThemes.textColor),),


                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.09, // Adjust top
                    right: constraints.maxWidth * 0.05, // Adjust right
                    child: CommonTextStyleForPage('10', MyMateThemes.textColor, FontWeight.w500, constraints.maxWidth * 0.045),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.11, // Adjust top
                    right: constraints.maxWidth * 0.01, // Adjust right
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Summarypage(docId: docId)),
                        );
                      },
                      child: CommonTextStyleForPage('+Add Tokens', MyMateThemes.primaryColor, FontWeight.w500, constraints.maxWidth * 0.033),
                    ),
                  ),
                ],
              ),
              SizedBox(width: constraints.maxWidth * 0.02), // Use constraints for spacing
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Summarypage(docId: docId)));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.27, // Adjust width
                          height: constraints.maxHeight * 0.8, // Adjust height
                          decoration: BoxDecoration(
                            color: MyMateThemes.primaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        Positioned(
                          top: constraints.maxHeight * 0.63, // Adjust top
                          right: constraints.maxWidth * 0.11, // Adjust right
                          child: Text('My Mates',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: constraints.maxWidth * 0.031)),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.55, // Adjust top
                    right: constraints.maxWidth * 0.22, // Adjust right
                    child: SvgPicture.asset('assets/images/heart .svg',
                        width: constraints.maxWidth * 0.24, // Adjust width
                        height: constraints.maxHeight * 0.08,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}



Widget SubscribedhomescreenStructuredPagePopupDialogWidget(BuildContext context) {
  return Expanded(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Positioned(
              top: constraints.maxHeight * 0.5, // Adjust top position
              left: constraints.maxWidth * 0.01, // Adjust left position
              right: constraints.maxWidth * 0.01, // Adjust right position
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: constraints.maxWidth * 0.8,
                  height: constraints.maxHeight * 0.38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      PopupDialogTextStyle("Congratulations! You have received ",
                        MyMateThemes.textColor,constraints.maxWidth * 0.035, // Use constraints
                      ),
                      Row(
                        children: [
                          PopupDialogTextStyle('10 free ', MyMateThemes.primaryColor,constraints.maxWidth * 0.035, // Use constraints
                          ),
                          PopupDialogTextStyle('Tokens. You can spend free',
                            MyMateThemes.textColor,  constraints.maxWidth * 0.035, // Use constraints
                          ),
                        ],
                      ),
                      PopupDialogTextStyle(
                        "tokens to access Following", MyMateThemes.textColor, constraints.maxWidth * 0.035, // Use constraints
                      ),
                      PopupDialogTextStyle("features only", MyMateThemes.textColor,constraints.maxWidth * 0.035, // Use constraints
                      ),
                      SizedBox(height: constraints.maxHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/fire.svg',

                            color: MyMateThemes.primaryColor,
                            width: constraints.maxWidth * 0.018, // Adjust width
                            height: constraints.maxHeight * 0.018 , // Adjust height
                          ),
                          SizedBox( width: constraints.maxWidth * 0.01,),
                          Text('* 1 Send / Accept interest',
                              style: TextStyle(
                                  color: MyMateThemes.textColor.withOpacity(0.6),
                                  fontSize: constraints.maxWidth * 0.032)),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/fire.svg',

                            color: MyMateThemes.primaryColor,
                            width: constraints.maxWidth * 0.018, // Adjust width
                            height: constraints.maxHeight * 0.018 , // Adjust height
                          ),
                          SizedBox( width: constraints.maxWidth * 0.01,),
                          Text('* 2 Check Accurate Match',
                              style: TextStyle(
                                  color: MyMateThemes.textColor.withOpacity(0.6),
                                  fontSize: constraints.maxWidth * 0.032)),
                        ],
                      ),


                      SizedBox(height: constraints.maxHeight * 0.05),
                      SizedBox(
                        height: constraints.maxHeight * 0.07,
                        width: constraints.maxWidth * 0.3,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(MyMateThemes.primaryColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: constraints.maxHeight * 0.005),
                            ),
                          ),
                          child: Text('Continue',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}



Widget CommonTextStyleForPage(
    String text, Color color, FontWeight fontWeight, double fontSize) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget PopupDialogTextStyle(String text, Color color,double fontSize) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      letterSpacing: 1.1, // Removed .r
      wordSpacing: 0.8,   // Removed .r
      //fontSize: 11.3,     // Removed .sp
    ),
  );
}
class SubscribeHomeScreenStructuredPageCarouselSliders extends StatefulWidget {
  String docId;
  SubscribeHomeScreenStructuredPageCarouselSliders({super.key,required this.docId});

  @override
  State<SubscribeHomeScreenStructuredPageCarouselSliders> createState() => _SubscribeHomeScreenStructuredPageCarouselSlidersState();
}

class _SubscribeHomeScreenStructuredPageCarouselSlidersState extends State<SubscribeHomeScreenStructuredPageCarouselSliders> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClients();
  }

  List<dynamic> soulList =[];
  Map<int, dynamic> clientList = {};
  List<dynamic> clientDataList = [];
  Future<void> getClients() async {
    Uri url = Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/matchListForDocId').replace(queryParameters: {"docId":widget.docId},);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          soulList = jsonDecode(response.body);
          clientList = Map<int, dynamic>.from(soulList.asMap());
          clientDataList = clientList.values.toList();
          print(clientDataList);
        });
      } else {
        print('Failed to load clients: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching client data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return     Padding(
      padding: EdgeInsets.zero,
      child:Expanded(
        child: clientDataList.isEmpty
            ? const CircularProgressIndicator()
            : LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return CarouselSlider(
              options: CarouselOptions(
                height: constraints.maxHeight * 1.5,
                autoPlay: true,
                enlargeCenterPage: false, // Disable automatic enlargement
                aspectRatio: 16 / 9,
                viewportFraction: 0.9, // Slightly less than full to show next/prev
                padEnds: true, // Remove padding at ends
              ),
              items: clientDataList.map((clientData) {
                Client client = Client();
                client.lastName = clientData['last_name'];
                client.fullName = clientData['full_name'];
                client.profileImg = clientData['profile_img_url'];
                client.age = clientData['age'];
                client.occupationType = clientData['occupation_type'];
                client.maritalStatus = clientData['marital_status'];
                client.docId = clientData['docId'];
                client.city = clientData['city'];

                return
                  SubscribedhomescreenStructuredPageCarouselSliderContainers(client);
              }).toList(),
            );
          },
        ),
      ),
    );
  }


  Widget SubscribedhomescreenStructuredPageCarouselSliderContainers(Client clientData) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OtherProfilePage(SoulId: clientData.docId.toString())));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.01), // Use constraints
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyMateThemes.textColor.withOpacity(0.1),
                  width: constraints.maxWidth * 0.002, // Use constraints
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ProfileColumns(clientData,constraints), // Pass constraints
            ),
          );
        },
      ),
    );
  }

  Widget ProfileColumns(Client clientData, BoxConstraints constraints) { // Add constraints parameter
    return
      Padding(
      padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: constraints.maxWidth * 0.05), // Use constraints
              Container(
                width: constraints.maxWidth * 0.25,
                height: constraints.maxWidth * 0.25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MyMateThemes.premiumAccent,
                    width: constraints.maxWidth * 0.01,
                  ),
                  image: (clientData.profileImg != null && clientData.profileImg!.isNotEmpty)
                      ? DecorationImage(
                    image: NetworkImage( clientData.profileImg.toString()),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: (clientData.profileImg == null || clientData.profileImg!.isEmpty)
                    ? ClipOval(
                  child: Icon(
                    Icons.person,
                    size: constraints.maxWidth * 0.1,
                    color: Colors.grey[400],
                  ),
                )
                    : null,
              ),
              SizedBox(width: constraints.maxWidth * 0.06), // Use constraints
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02), // Use constraints
                    child: CommonTextStyleForPage(
                      clientData.lastName.toString(),
                      MyMateThemes.textColor,
                      FontWeight.w700,
                      constraints.maxWidth * 0.05, // Use constraints
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02), // Use constraints
                    child: Row(
                      children: [
                        CommonTextStyleForPage(
                          clientData.age.toString(),
                          MyMateThemes.textColor,
                          FontWeight.w400,
                          constraints.maxWidth * 0.035, // Use constraints
                        ),
                        CommonTextStyleForPage(
                          " Status",
                          MyMateThemes.textColor,
                          FontWeight.w500,
                          constraints.maxWidth * 0.035, // Use constraints
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02), // Use constraints
                    child: CommonTextStyleForPage(
                      clientData.occupationType.toString(),
                      MyMateThemes.textColor,
                      FontWeight.w500,
                      constraints.maxWidth * 0.035, // Use constraints
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.03), // Use constraints
                    child: CommonTextStyleForPage(
                      clientData.city.toString(),
                      MyMateThemes.textColor,
                      FontWeight.w500,
                      constraints.maxWidth * 0.035, // Use constraints
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02), // Use constraints
                    child: Container(
                      width: constraints.maxWidth * 0.25, // Use constraints
                      height: constraints.maxHeight * 0.18, // Use constraints
                      decoration: BoxDecoration(
                        color: MyMateThemes.secondaryColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: constraints.maxWidth * 0.02), // Use constraints
                          SvgPicture.asset('assets/images/heart .svg', width: constraints.maxWidth * 0.04), // Use constraints
                          SizedBox(width: constraints.maxWidth * 0.01), // Use constraints
                          CommonTextStyleForPage(
                            '60 - 80%',
                            MyMateThemes.primaryColor,
                            FontWeight.w500,
                            constraints.maxWidth * 0.04, // Use constraints
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget SubscribedhomescreenStructuredPageCarouselSlider(BuildContext context) { // Remove unused BuildContext
  Firebase firebase = Firebase();
  final Stream<List<ClientProfile>> streamProfiles = firebase.getClientsStream(); // No need for Future here

  return Center(
    child: StreamBuilder<List<ClientProfile>>(
      stream: streamProfiles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Add const for efficiency
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No profiles found.')); // Add const
        } else {
          final profileList = snapshot.data!;
          return LayoutBuilder( // Add LayoutBuilder
            builder: (BuildContext context, BoxConstraints constraints) { // Constraints available here
              return CarouselSlider(
                options: CarouselOptions(
                  height: constraints.maxHeight * 0.5, // Use constraints for height, adjust 0.5 as needed
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 21 / 10,
                  viewportFraction: 1,
                ),
                items: profileList.map((profile) {
                  return SubscribedhomescreenStructuredPageCarouselSliderContainer(profile: profile, ); // Pass constraints
                }).toList(),
              );
            },
          );
        }
      },
    ),
  );
}

class SubscribedhomescreenStructuredPageCarouselSliderContainer extends StatelessWidget {
  final ClientProfile profile;

  const SubscribedhomescreenStructuredPageCarouselSliderContainer({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OtherProfilePage(SoulId: profile.docId)));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.01), // Use constraints
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: constraints.maxWidth * 0.002), // Use constraints
                bottom: BorderSide(width: constraints.maxWidth * 0.002), // Use constraints
              ),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ProfileColumn(profile,constraints), // Pass constraints
          ),
        );
      },
    );
  }
}

Widget ProfileColumn(ClientProfile profile, BoxConstraints constraints) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        children: [
          SizedBox(width: constraints.maxWidth * 0.05), // Use constraints
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: MyMateThemes.premiumAccent,
                width: constraints.maxWidth * 0.01, // Use constraints
              ),
            ),
            child: CircleAvatar(
              radius: constraints.maxWidth * 0.1, // Use constraints
              backgroundImage: NetworkImage(profile.imageUrl),
            ),
          ),
          SizedBox(width: constraints.maxWidth * 0.06), // Use constraints
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02), // Use constraints
                child: CommonTextStyleForPage(
                  profile.name,
                  MyMateThemes.textColor,
                  FontWeight.w700,
                  constraints.maxWidth * 0.04, // Use constraints
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02), // Use constraints
                child: Row(
                  children: [
                    CommonTextStyleForPage(
                      ' ${profile.age}, ',
                      MyMateThemes.textColor,
                      FontWeight.w400,
                      constraints.maxWidth * 0.03, // Use constraints
                    ),
                    CommonTextStyleForPage(
                      profile.status,
                      MyMateThemes.textColor,
                      FontWeight.w500,
                      constraints.maxWidth * 0.03, // Use constraints
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02), // Use constraints
                child: CommonTextStyleForPage(
                  profile.occupation,
                  MyMateThemes.textColor,
                  FontWeight.w500,
                  constraints.maxWidth * 0.03, // Use constraints
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02), // Use constraints
                child: CommonTextStyleForPage(
                  profile.district,
                  MyMateThemes.textColor,
                  FontWeight.w500,
                  constraints.maxWidth * 0.03, // Use constraints
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.2, // Use constraints
                height: constraints.maxHeight * 0.1, // Use constraints
                decoration: BoxDecoration(
                  color: MyMateThemes.secondaryColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('assets/images/heart .svg', width: constraints.maxWidth * 0.04), // Use constraints
                    CommonTextStyleForPage(
                      ' ${profile.matchPercentage}',
                      MyMateThemes.primaryColor,
                      FontWeight.w500,
                      constraints.maxWidth * 0.03, // Use constraints
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}