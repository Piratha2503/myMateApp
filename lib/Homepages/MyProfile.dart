import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'bottom_navigation_bar.dart';
import 'package:badges/badges.dart' as badges;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundWhite,
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                SafeArea(
                  child: Text("@user240676",
                      style: TextStyle(
                        color: MyMateThemes.textGreen,
                        fontSize: MyMateThemes.subHeadFontSize,
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
