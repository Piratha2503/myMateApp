import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/Profiles/EditGalleryScreen.dart';
import 'package:mymateapp/Homepages/Profiles/OthersProfile.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../ManagePages/ManagePage.dart';
import '../ProfilePageScreen/MyProfileMain.dart';



class MenuPage extends StatefulWidget {
  final String docId;
  const MenuPage({super.key,required this.docId});

  @override
  State<MenuPage> createState() => _MenuPageState();
}



class _MenuPageState extends State<MenuPage> {

  void _showBlockDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {


        return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.06),
                ),
          contentPadding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.055,vertical: MediaQuery.of(context).size.height*0.04),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(
                        "Block  ",
                        style: TextStyle(
                          fontSize:MediaQuery.of(context).size.width * 0.05,
                          color: MyMateThemes.textColor,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                        Text(
                          "@user240676  ",
                          style: TextStyle(
                            fontSize:MediaQuery.of(context).size.width * 0.05,
                            color: MyMateThemes.textColor,
                              fontWeight: FontWeight.w500

                          ),
                        ),
                        Text(
                          "?",
                          style: TextStyle(
                            fontSize:MediaQuery.of(context).size.width * 0.05,
                            color: MyMateThemes.textColor,
                              fontWeight: FontWeight.w500

                          ),
                        ),
                    ],),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    Text('@user name will no longer profile',  style: TextStyle(
                        fontSize:MediaQuery.of(context).size.width * 0.04,
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.normal

                    ),),

                    Text('be able to :',
                      style: TextStyle(
                        fontSize:MediaQuery.of(context).size.width * 0.04,
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.normal

                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.circle,size:MediaQuery.of(context).size.height * 0.01,
                          color: MyMateThemes.textColor,),
                        SizedBox(  width: MediaQuery.of(context).size.width  * 0.03,
                        ),

                        Text('See your Profile.',  style: TextStyle(
                               fontSize:MediaQuery.of(context).size.width * 0.04,
                               color: MyMateThemes.textColor,
                               fontWeight: FontWeight.normal

                           ),
                         ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.circle,size:MediaQuery.of(context).size.height * 0.01,
                        color: MyMateThemes.textColor,),
                       SizedBox( width: MediaQuery.of(context).size.width  * 0.03,
                       ),
                       Text('Start a conversation with you.',  style: TextStyle(
                              fontSize:MediaQuery.of(context).size.width * 0.04,
                              color: MyMateThemes.textColor,
                              fontWeight: FontWeight.normal

                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.circle,size:MediaQuery.of(context).size.height * 0.01,
                          color: MyMateThemes.textColor,),
                       SizedBox(  width: MediaQuery.of(context).size.width  * 0.03,
                       ),
                       Text('Add you as a mate',  style: TextStyle(
                              fontSize:MediaQuery.of(context).size.width * 0.04,
                              color: MyMateThemes.textColor,
                              fontWeight: FontWeight.normal

                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    Text('If they connect with you . blocking',  style: TextStyle(
                        fontSize:MediaQuery.of(context).size.width * 0.04,
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.normal

                    ),),
                    Text('@username will remove them as a',  style: TextStyle(
                        fontSize:MediaQuery.of(context).size.width * 0.04,
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.normal

                    ),),

                    Text('follower.',
                      style: TextStyle(
                          fontSize:MediaQuery.of(context).size.width * 0.04,
                          color: MyMateThemes.textColor,
                          fontWeight: FontWeight.normal

                      ),),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width  * 0.3,
                          height: MediaQuery.of(context).size.height  * 0.07,
                          child: ElevatedButton(
                            onPressed: () {

                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(MyMateThemes.containerColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: MyMateThemes.primaryColor),
                            ),
                          ),
                        ),
                        SizedBox(  width: MediaQuery.of(context).size.width  * 0.03,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width  * 0.3,
                          height: MediaQuery.of(context).size.height  * 0.07,
                          child: ElevatedButton(
                            onPressed: () {

                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(MyMateThemes.primaryColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Block',
                              style: TextStyle(color:Colors.white),
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              );

      },
    );
  }
  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {


        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.06),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.05,vertical: MediaQuery.of(context).size.height*0.04),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Why are you reporting  ",
                    style: TextStyle(
                        fontSize:MediaQuery.of(context).size.width * 0.045,
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.w500,
                      letterSpacing: 1
                    ),
                  ),

                ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "this profile ?  ",
                    style: TextStyle(
                        fontSize:MediaQuery.of(context).size.width * 0.045,
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1

                    ),
                  ),

                ],),


              SizedBox(height: MediaQuery.of(context).size.height * 0.04),

              GestureDetector(
                onTap: (){
                  print('Reason 1');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.circle,size:MediaQuery.of(context).size.height * 0.01,
                      color: MyMateThemes.textColor,),
                    SizedBox(  width: MediaQuery.of(context).size.width  * 0.03,
                    ),

                    Text('Reason 1',  style: TextStyle(
                        fontSize:MediaQuery.of(context).size.width * 0.04,
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.normal

                    ),
                    ),
                  ],
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: (){
                  print('Reason 2');
                },                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.circle,size:MediaQuery.of(context).size.height * 0.01,
                      color: MyMateThemes.textColor,),
                    SizedBox( width: MediaQuery.of(context).size.width  * 0.03,
                    ),
                    Text('Reason 2',  style: TextStyle(
                        fontSize:MediaQuery.of(context).size.width * 0.04,
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.normal

                    ),
                    ),
                  ],
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: (){
                  print('Reason 3');

                },                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.circle,size:MediaQuery.of(context).size.height * 0.01,
                      color: MyMateThemes.textColor,),
                    SizedBox(  width: MediaQuery.of(context).size.width  * 0.03,
                    ),
                    Text('Reason 3',  style: TextStyle(
                        fontSize:MediaQuery.of(context).size.width * 0.04,
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.normal

                    ),
                    ),
                  ],
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: (){
                  print('Reason 4');
                },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.circle,size:MediaQuery.of(context).size.height * 0.01,
                        color: MyMateThemes.textColor,),
                      SizedBox(  width: MediaQuery.of(context).size.width  * 0.03,
                      ),
                      Text('Something else',
                        style: TextStyle(
                            fontSize:MediaQuery.of(context).size.width * 0.04,
                            color: MyMateThemes.textColor,
                            fontWeight: FontWeight.normal

                        ),
                      ),
                    ],
                  ),

              ),


              SizedBox(height: MediaQuery.of(context).size.height * 0.04),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width  * 0.3,
                    height: MediaQuery.of(context).size.height  * 0.07,
                    child: ElevatedButton(
                      onPressed: () {

                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(MyMateThemes.containerColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: MyMateThemes.primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(  width: MediaQuery.of(context).size.width  * 0.03,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width  * 0.3,
                    height: MediaQuery.of(context).size.height  * 0.07,
                    child: ElevatedButton(
                      onPressed: () {

                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(MyMateThemes.primaryColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Report',
                        style: TextStyle(color:Colors.white),
                      ),
                    ),
                  ),

                ],
              ),

            ],
          ),
        );

      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            return SafeArea(

              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(width * 0.04),
                    child: Row(
                      children: [
                        SizedBox(width: width*0.02),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtherProfilePage(SoulId: '',)));
                          },
                          child: SvgPicture.asset('assets/images/chevron-left.svg',height:height*0.02 ,),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height:height*0.05),

                  Row(
                    children: [
                      SizedBox(width:width*0.1),

                      IconButton(onPressed: (){
                        _showReportDialog();
                      },
                          icon:Icon(Icons.report,color: MyMateThemes.textColor) ),
                      TextButton(
                        onPressed: (){_showReportDialog();},
                        child: Text('Report Profile',style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.0435,fontWeight: FontWeight.w500),),
                      )
                    ],
                  ),
                  SizedBox(height:height*0.01),

                  Row(
                    children: [
                      SizedBox(width:width*0.1),

                            IconButton(
                                onPressed: (){
                              _showBlockDialog();
                            },
                             icon:Icon(Icons.block,color: MyMateThemes.textColor) ),
                          TextButton(
                            onPressed: (){_showBlockDialog();},
                            child: Text('Block',style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.0435,fontWeight: FontWeight.w500),),
                          )

                    ],
                  ),
                  SizedBox(height:height*0.01),

                  Row(
                    children: [
                      SizedBox(width:width*0.15),
                      GestureDetector(
                        onTap: (){},
                        child: SvgPicture.asset('assets/images/Glyph.svg'),
                      ),
                      SizedBox(width:width*0.04),

                      TextButton(
                        onPressed: (){_showBlockDialog();},
                        child: Text('Share Profile',style: TextStyle(color: MyMateThemes.textColor,fontSize: width*0.0435,fontWeight: FontWeight.w500),),
                      )
                    ],
                  ),                ],
              ),
            );
          }
      ),
    );
  }
}


