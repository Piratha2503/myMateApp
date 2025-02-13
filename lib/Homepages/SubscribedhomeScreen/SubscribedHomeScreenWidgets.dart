import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  return
    Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center everything horizontally
        children: [
          Stack(
            alignment: Alignment.center, // Ensure all elements stay centered
            clipBehavior: Clip.none, // Allow elements to overflow if needed
            children: [
              // Background Container
              Container(
                width: 300.w,
                height: 210.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
              ),

              // SVG Positioned at Center
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/Frame.svg',
                    // height: 202.h,
                    // width: 202.w,
                    fit: BoxFit.contain, // Ensures it scales proportionally
                  ),
                ),
              ),

              // First Text (Centered on SVG)
              Positioned(
                top: 58.h, // Adjusted using proportional height
                left: 0,
                right: 0, // Centering the text horizontally
                child: Center(
                  child: CommonTextStyleForPage(
                    '137',
                    Colors.white,
                    FontWeight.w700,
                    28.sp, // Ensures text scales with screen
                  ),
                ),
              ),

              // Second Text (Below First Text)
              Positioned(
                top: 98.h, // Adjusted using proportional height
                left: 0,
                right: 0, // Centering the text horizontally
                child: Center(
                  child: CommonTextStyleForPage(
                    'Matches Found',
                    Colors.white,
                    FontWeight.w500,
                    12.sp, // Ensures text scales with screen
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );


}
Widget SubscribedhomescreenStructuredPageTokenContainers(BuildContext context,String docId){

  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: 220.w,
              height: 130.h,
              decoration: BoxDecoration(
                color: MyMateThemes.secondaryColor,
                borderRadius: BorderRadius.circular(8.0.r),
              ),
            ),
            Positioned(
                top: 75.h,
                right: 160.w,
                child: SvgPicture.asset('assets/images/tokens.svg')),
            Positioned(
              top: 8.h,
              right: 16.w,
              child: CommonTextStyleForPage('10',MyMateThemes.textColor,FontWeight.w500,18.sp, ),
            ),
            Positioned(
              top: 16.h,
              right: 3.w,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Summarypage(docId: docId,)));
                },
                child: CommonTextStyleForPage('+Add Tokens',MyMateThemes.primaryColor,FontWeight.w500,10.sp),
              ),
            ),
          ],
        ),
        SizedBox(width: 10.w),
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Summarypage(docId: docId,)));
              },
              child:
                  Stack(
                    children: [
                      Container(
                        width: 110.w,
                        height: 130.h,
                        decoration: BoxDecoration(
                          color: MyMateThemes.primaryColor,
                          borderRadius: BorderRadius.circular(8.0.r),
                        ),

                      ),
                      Positioned(
                          top: 100.h,
                          right: 40.w,
                          child: Text('My Mates',style:TextStyle(color: Colors.white,fontSize: 12.sp))),
                    ],
                  ),


            ),
            Positioned(
                top: 85.h,
                right: 80.w,
                child: SvgPicture.asset('assets/images/heart .svg',color: Colors.white,)),
          ],
        ),

      ],
    ),

  );
}

Widget SubscribedhomescreenStructuredPagePopupDialogWidget(BuildContext context){
  return Expanded(
    child: Stack(
      children: [
        Positioned(
          top: 450.h, // Adjust the top position as needed
          left: 0.005.w, // Adjust the left position as needed
          right: 0.005.w, // Adjust the right position as needed
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child:Expanded (
              child: Container(
                width: 40.w, // Set your desired width
                height: 250.h, // Set your desired height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,

                ),
                padding: EdgeInsets.all(20.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    PopupDialogTextStyle( "Congratulations! You have received ", MyMateThemes.textColor, ),
                    Row(
                      children: [
                        PopupDialogTextStyle( '10 free ', MyMateThemes.primaryColor, ),
                        PopupDialogTextStyle('Tokens. You can spend free',  MyMateThemes.textColor, ),
                      ],
                    ),
                    PopupDialogTextStyle("tokens to access Following",  MyMateThemes.textColor, ),
                    PopupDialogTextStyle("features only",  MyMateThemes.textColor, ),
                    SizedBox(height: 20.h),
                    SvgPicture.asset('assets/images/Group 2216.svg'),
                    SizedBox(height: 20.h),
                SizedBox(
                  height: 45.h,
                  width: 100.w,
                  child:
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(MyMateThemes.primaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),


                        )),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 12.0.h), // Adjust values as needed
                        ),
                      ),
                      child: Text('Continue',style: TextStyle(color: Colors.white),),
                    ),
                ),
                  ],
                ),
              ),
            ),
          ),

        ),
      ],
    ),

  );
}

Widget CommonTextStyleForPage(String text,Color color, FontWeight fontWeight, double fontSize, ){
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,

    ),
  );
}

Widget PopupDialogTextStyle(String text, Color color){
  return Text(
    text,
    style: TextStyle(
      color: color,
      letterSpacing:
      1.1.r, // Adjust letter spacing as needed
      wordSpacing: 0.8.r,
      fontSize: 11.3.sp// Adjust word spacing as needed
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

    return Expanded(
      child: clientDataList.isEmpty
          ? CircularProgressIndicator() // Show a loader while fetching data
          : CarouselSlider(
        options: CarouselOptions(
          height: 200.0.h,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 21 / 10,
          viewportFraction: 0.8.h,
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
          return SubscribedhomescreenStructuredPageCarouselSliderContainers(client);
        }).toList(),
      ),
    );
  }
  Widget SubscribedhomescreenStructuredPageCarouselSliderContainers(Client clientData){
    return Expanded(
      child:      GestureDetector(
        onTap: (){

          Navigator.push(context, MaterialPageRoute(builder: (context)=>OtherProfilePage(SoulId: clientData.docId.toString())));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: MyMateThemes.textColor.withOpacity(0.1),
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: ProfileColumns(clientData),
        ),
      ),

    );

  }

  Widget ProfileColumns(Client clientData){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
            children: [
              SizedBox(width: 20.w),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all( color: MyMateThemes.premiumAccent, width: 4.0.w,),),
                child: ClipOval(
                  child: Image.network(
                    clientData.profileImg.toString(),
                    fit: BoxFit.cover,
                    height: 65.h,
                    width: 65.w,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, size: 60.w);
                    },
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                )
              ),
              SizedBox(width: 25.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only( bottom: 5.0.h),
                    child: CommonTextStyleForPage( clientData.lastName.toString(), MyMateThemes.textColor, FontWeight.w700, 15.sp,),
                  ),
                  Padding(
                    padding: EdgeInsets.only( bottom: 5.0.h ),
                    child: Row(
                      children: [
                        CommonTextStyleForPage(clientData.age.toString(), MyMateThemes.textColor, FontWeight.w400,12.sp, ),
                        CommonTextStyleForPage( " Status" ,MyMateThemes.textColor, FontWeight.w500, 12.sp, ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( bottom: 5.0.h), // Add bottom padding for spacing
                    child: CommonTextStyleForPage(clientData.occupationType.toString(),MyMateThemes.textColor,FontWeight.w500,12.sp,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0.h),
                    child: CommonTextStyleForPage(clientData.city.toString(),MyMateThemes.textColor,FontWeight.w500,12.sp,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0.h),
                    child:
                    Container(
                      width: 70.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: MyMateThemes.secondaryColor,
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10.w),
                          SvgPicture.asset(
                              'assets/images/heart .svg'),
                          SizedBox(width: 5.w),

                          CommonTextStyleForPage('66%',MyMateThemes.primaryColor,FontWeight.w500,12.sp),
                        ],
                      ),
                    ),

                  ),
                ],
              ),
            ]),
      ],
    );
  }

}

Widget SubscribedhomescreenStructuredPageCarouselSlider(BuildContext,context){

  Firebase firebase = Firebase();
  final Future<List<ClientProfile>> profiles = firebase.getClientList();
  final Stream<List<ClientProfile>> streamProfiles = firebase.getClientsStream();
  return Center(
      child: StreamBuilder<List<ClientProfile>>(

        stream: streamProfiles,
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No profiles found.'));
          }
          else{
            final profileList = snapshot.data!;
            return CarouselSlider(
              options: CarouselOptions(
                height: 120.0.h,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 21/10,
                viewportFraction: 0.8,
              ),
              items: profileList.map((profile) {
                return SubscribedhomescreenStructuredPageCarouselSliderContainer(profile: profile);
              }).toList(),
            );
          }
        },

      )
  );

}

class SubscribedhomescreenStructuredPageCarouselSliderContainer extends StatelessWidget{

  ClientProfile profile;
  SubscribedhomescreenStructuredPageCarouselSliderContainer({super.key,required this.profile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtherProfilePage(SoulId: profile.docId)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0.5.r),
            bottom:  BorderSide(width: 0.5.r),
          ),
          borderRadius: BorderRadius.circular(8.0.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0.r,
              spreadRadius: 2.0.r,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ProfileColumn(profile),
      ),
    );
  }

}

Widget ProfileColumn(ClientProfile profile){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
          children: [
            SizedBox(width: 20.w),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all( color: MyMateThemes.premiumAccent, width: 5.0.w,),),
              child: CircleAvatar( radius: 50, backgroundImage: NetworkImage(profile.imageUrl),),),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only( bottom: 3.0.h),
                  child: CommonTextStyleForPage( profile.name, MyMateThemes.textColor, FontWeight.w700, 13.sp,),
                ),
                Padding(
                  padding: EdgeInsets.only( bottom: 3.0.h ),
                  child: Row(
                    children: [
                      CommonTextStyleForPage(' ${profile.age}, ', MyMateThemes.textColor, FontWeight.w400,12.sp, ),
                      CommonTextStyleForPage( profile.status, MyMateThemes.textColor, FontWeight.w500, 12.sp, ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only( bottom: 3.0.h), // Add bottom padding for spacing
                  child: CommonTextStyleForPage(' ${profile.occupation}',MyMateThemes.textColor,FontWeight.w500,12.sp,),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.0.h),
                  child: CommonTextStyleForPage(' ${profile.district}',MyMateThemes.textColor,FontWeight.w500,12.sp,),
                ),
                Container(
                  width: 90.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: MyMateThemes.secondaryColor,
                    borderRadius: BorderRadius.circular(4.0.r),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                          'assets/images/heart .svg'),
                      CommonTextStyleForPage(' ${profile.matchPercentage}',MyMateThemes.primaryColor,FontWeight.w500,12.sp),
                    ],
                  ),
                ),
              ],
            ),
          ]),
    ],
  );
}