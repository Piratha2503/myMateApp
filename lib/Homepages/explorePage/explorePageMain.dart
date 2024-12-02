import 'package:flutter/material.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../MyMateThemes.dart';
import 'explorePageWidgets.dart';

class Explorepage extends StatefulWidget {
  const Explorepage({super.key});

  @override
  _ExplorepageState createState() => _ExplorepageState();
}

class _ExplorepageState extends State<Explorepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ExplorePageAppBar(),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelStyle: TextStyle(fontWeight: FontWeight.bold,color: MyMateThemes.textColor ),
            unselectedLabelStyle:TextStyle(fontWeight: FontWeight.w700,color: MyMateThemes.textColor.withOpacity(0.8) ) ,
            indicatorColor:  MyMateThemes.textColor,
            labelPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            tabs: [
              Tab(text: 'ExploreAll'),
              Tab(text: 'ViewMatches'),
              Tab(text: 'Filter'),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 10.0,left: 10.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: search,
                ),

              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ExploreAllGrid(context),
                ViewMatchesGrid(context),
                FilterGrid(context),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Handle navigation here based on the index
        },
      ),
    );
  }
}
