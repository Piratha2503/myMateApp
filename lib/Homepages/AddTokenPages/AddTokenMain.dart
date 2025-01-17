import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../../ManagePages/ManagePage.dart';
import 'AddTokenWidgets.dart';


class AddTokenMainPage extends StatefulWidget {
  final String docId;
  const AddTokenMainPage({super.key,required this.docId});

  @override
  State<AddTokenMainPage> createState() => _AddTokenMainPageState();
}

class _AddTokenMainPageState extends State<AddTokenMainPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child:
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManagePage(docId: widget.docId,)));
                        },
                        child: SvgPicture.asset('assets/images/chevron-left.svg'),
                      ),
                      SizedBox(width: 50.0),
                      Text(
                        "Package Plan ",
                        style: TextStyle(
                            color: MyMateThemes.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing:0.8
                        ),
                      ),
                    ],
                  ),
                ),
                //SizedBox(height: 10),
                Center(
                  child: CarouselSlider(
                    items: packageSliders,
                    options: CarouselOptions(

                      enlargeCenterPage: true,
                      aspectRatio: 14/11,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.76,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    print('play video');
                  },
                  child: Container(
                    height: 65,
                    width: 301,
                    decoration: BoxDecoration(
                      color:MyMateThemes.premiumAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                      Stack(
                        children: [
                          Positioned(
                            top: 19,
                            left: 25,
                            child: SvgPicture.asset('assets/images/Play.svg'),),
                          Positioned(
                            top: 14,
                            right: 45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [
                                    Text('Watch 5 videos to get 2 ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  ],
                                ),

                                Row(

                                  children: [
                                    Text('tokens ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),

                                  ],
                                ),
                              ],
                            ),

                      ),
                    ],
                      ),

                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: CarouselSlider(
                    items: offerSliders,
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      aspectRatio: 13/9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.76,
                    ),
                  ),
                ),

              ],
            ),
          ),
        )
    );

  }
}
