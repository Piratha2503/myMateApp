import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/Profiles/MoreAboutMe.dart';
import 'package:mymateapp/MyMateThemes.dart';

class boostprofile extends StatefulWidget {
  @override
  State<boostprofile> createState() => _boostprofileState();
}

class _boostprofileState extends State<boostprofile> {
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: MyMateThemes.backgroundColor,
      title: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MoreAboutMePage()));
              },
              child: SvgPicture.asset('assets/images/chevron-left.svg'),
            ),
            SizedBox(width: 70.0),
            Center(
              child: Text(
                "Boost Profile",
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildBoostContainer(context,
                title: 'Boost',
                description:
                'Your profile will be boosted. It helps you that your profile will be prioritized suggestions to others every searches. It takes 1 token per day.',
                tokensPerDay: '× 1 Token per day',
                backgroundColor: MyMateThemes.containerColor,
                textColor: MyMateThemes.textGray,
                titlecolor: MyMateThemes.textGray),
            const SizedBox(height: 16),
            buildBoostContainer(context,
                title: 'Super Boost',
                description:
                'Your profile will be boosted. It helps you that your profile will be highly prioritized suggestions to others every searches. It takes 2 tokens per day.',
                tokensPerDay: '× 2 Tokens per Day',
                backgroundColor: MyMateThemes.primaryColor,
                textColor: Colors.white,
                titlecolor: MyMateThemes.premiumAccent),
            const SizedBox(height: 16),
            _builtBoostCount()
          ],
        ),
      ),
    );
  }
}

Widget buildBoostContainer(
    BuildContext context, {
      required String title,
      required Color titlecolor,
      required String description,
      required String tokensPerDay,
      required Color backgroundColor,
      required Color textColor,
    }) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/firenew.svg',
                      height: 16.0,
                      width: 16.0,
                      color: textColor,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      tokensPerDay,
                      style: TextStyle(
                        color: textColor.withOpacity(0.8),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  title,
                  style: TextStyle(
                    color: titlecolor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/lightning-bolt.svg',
                  height: 24.0,
                  width: 24.0,
                  color: title == 'Super Boost' ? MyMateThemes.premiumAccent : textColor,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Text(
          description,
          style: TextStyle(
            color: textColor.withOpacity(0.7),
            fontSize: 14.0,
          ),
        ),
      ],
    ),
  );
}

Widget _builtBoostCount() {
  int _noOfDays = 1;
  int _noOfTokens = 1;

  return DefaultTabController(
    length: 2,
    child: Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: MyMateThemes.backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: MyMateThemes.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: MyMateThemes.primaryColor,
                labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                tabs: [
                  _buildTabButton('Boost'),
                  _buildTabButton('Super Boost'),
                ],
                onTap: (index) {
                  _noOfTokens = (index == 0) ? 1 : 2;
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              children: [
                // Boost Tab
                _buildBoostContent(
                  noOfDays: _noOfDays,
                  noOfTokens: _noOfTokens,
                  onDaysChanged: (value) {
                    _noOfDays = value;
                  },
                ),
                _buildBoostContent(
                  noOfDays: _noOfDays,
                  noOfTokens: _noOfTokens * 2,
                  onDaysChanged: (value) {
                    _noOfDays = value;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _noOfDays = 1;
                    _noOfTokens = 1;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Clear', style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyMateThemes.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Complete'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Tab _buildTabButton(String title) {
  return Tab(
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title),
    ),
  );
}

Widget _buildBoostContent({
  required int noOfDays,
  required int noOfTokens,
  required Function(int) onDaysChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCounterRow(
          label: "No of Days",
          value: noOfDays,
          onIncrement: () => onDaysChanged(noOfDays + 1),
          onDecrement: () => onDaysChanged(noOfDays > 1 ? noOfDays - 1 : 1),
          showLightningBolt: false,
          showControls: true,
        ),
        const SizedBox(height: 16),
        _buildCounterRow(
          label: "No of Tokens",
          value: noOfTokens,
          showLightningBolt: true,
          showControls: false,
        ),
      ],
    ),
  );
}

Widget _buildCounterRow({
  required String label,
  required int value,
  required bool showLightningBolt,
  required bool showControls,
  Function()? onIncrement,
  Function()? onDecrement,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16.0),
      ),
      Row(
        children: [
          if (showControls)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: onDecrement,
                color: Colors.grey,
                splashRadius: 20.0,
              ),
            ),
          Container(
            width: 56,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showLightningBolt)
                  SvgPicture.asset(
                    'assets/images/firenew.svg',
                    height: 16.0,
                    width: 16.0,
                    color: MyMateThemes.primaryColor,
                  ),
                if (showLightningBolt) const SizedBox(width: 4.0),
                Text(
                  value.toString().padLeft(2, '0'),
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          if (showControls)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: onIncrement,
                color: MyMateThemes.primaryColor,
                splashRadius: 20.0,
              ),
            ),
        ],
      ),
    ],
  );
}
