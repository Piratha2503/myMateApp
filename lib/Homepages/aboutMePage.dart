import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../MyMateThemes.dart';
import 'MyProfileWidgets.dart';
import 'expectationPage.dart';
import 'MyProfileMain.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height; // Screen height from MediaQuery

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            // Section Title
            SectionTitle('About me'),
            SizedBox(height: 5),

            // Decorative Line
            Row(
              children: [
                SizedBox(width: 40),
                SvgPicture.asset('assets/images/Line 11.svg'),
              ],
            ),
            SizedBox(height: 10),

            // Info Rows
            InfoRow('Education', 'Bsc Computer Science'),
            InfoRow('Height', '165 CM'),
            InfoRow('Religion', 'Hinduism'),
            InfoRow('Language', 'Tamil, English'),
            InfoRow('Caste', 'Optional'),
            InfoRow('Father\'s Name', 'Bsc Computer Science'),
            InfoRow('Mother\'s Name', 'Bsc Computer Science'),
            InfoRow('Siblings', '6'),
            SizedBox(height: 20),

            // Expectations Section
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 40),
                Text(
                  'Expectations',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Expectations Widget
            Expectations(),
          ],
        ),
      ),
    );
  }
}
