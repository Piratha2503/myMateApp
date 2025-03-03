import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/myMatePage/myMatePageWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../MyMateThemes.dart';

class MyMatePage extends StatefulWidget {
  final int initialTabIndex;
  final List<Map<String, dynamic>> results;


  const MyMatePage({
    Key? key,
    this.initialTabIndex = 0,
    required this.results,
    required List search,
    required String docId,
  }) : super(key: key);

  @override
  _MyMatePageState createState() => _MyMatePageState();
}

class _MyMatePageState extends State<MyMatePage> with SingleTickerProviderStateMixin {
  // late Timer _debounce;
  int _selectedIndex = 2;


  late TabController _tabController;
  Future<List<Map<String, dynamic>>>? myMatesFuture;
  Future<List<Map<String, dynamic>>>? receiveRequestFuture;
  Future<List<Map<String, dynamic>>>? sendRequestFuture;

  final TextEditingController searchController = TextEditingController();
  late List<Map<String, dynamic>> allResults;
  Timer? _debounce;

  ScrollController _scrollController = ScrollController();
  bool _showHeader = true;  // Variable to track header visibility




  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTabIndex);
    // Add listener to trigger re-build when tab changes
    _tabController.addListener(() {
      setState(() {}); // Triggers rebuild when tab changes
    });

    // Initialize with all available profiles
    allResults = widget.results;
    myMatesFuture = getProfiles();
    receiveRequestFuture = getProfiles();
    sendRequestFuture = getProfiles();

    // Add listener to perform real-time search
    searchController.addListener(_performSearch);

  }



  Future<String?> getSavedDocId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('docId');
  }

  void _performSearch() {

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      // String query = searchController.text.toLowerCase().trim();


      final searchCriteria = {
        'full_name': searchController.text.trim(),
      };
      setState(() {

        if (searchCriteria['full_name']!.isEmpty) {
          myMatesFuture = getProfiles();
          sendRequestFuture = searchAllUsers(searchCriteria);
          receiveRequestFuture = searchAllUsers(searchCriteria);

        } else {
          myMatesFuture = searchAllUsers(searchCriteria);
          sendRequestFuture = searchAllUsers(searchCriteria);
          receiveRequestFuture = searchAllUsers(searchCriteria);

        }

      }



      );
    }
    );
  }


  Future<void> _applySearch() async {
    final searchCriteria = {
      'full_name': searchController.text.trim(),
    };

    setState(() {
      if (searchCriteria['full_name']!.isEmpty) {
        myMatesFuture = getProfiles();
      } else {
        myMatesFuture = searchAllUsers(searchCriteria);
        sendRequestFuture = searchAllUsers(searchCriteria);
        receiveRequestFuture = searchAllUsers(searchCriteria);

      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<String?>(
      future: getSavedDocId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error loading docId')),
          );
        } else {
          final docId = snapshot.data ?? '';

          return Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
              controller: _scrollController, // Use ScrollController for advanced control
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    floating: true, // Ensures the header reappears when scrolling up
                    snap: true, // Snaps the header into view when scrolling up
                    pinned: false, // Allows the entire header to scroll out of view
                    automaticallyImplyLeading: false,
                    //title: myMatesPageAppBar(context),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(50.h), // Adjust height to accommodate additional widgets
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: MyMateThemes.textColor,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 11.sp,
                              color: MyMateThemes.textColor.withOpacity(0.8),
                            ),
                            dividerColor: Colors.transparent,
                            indicatorPadding: EdgeInsets.only(bottom: 6), // Adjust this for spacing
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 3, // Thickness of the line
                                color: MyMateThemes.textColor, // Line color
                              ),
                              borderRadius: BorderRadius.circular(10), // Rounded corners for the line
                            ),
                            labelPadding: EdgeInsets.symmetric(horizontal: 2.w),
                            tabs: [
                              Tab(text: 'My Mates'),
                              Tab(text: 'Receive Request'),
                              Tab(text: 'Send Request'),
                            ],
                          ),
                          SizedBox(height: 2.h), // Add spacing below the TabBar
                            Container(
                                height: 35.h,
                                width: 353.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyMateThemes.textColor.withOpacity(0.1),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:
                                Padding(
                                  padding:EdgeInsets.symmetric(horizontal: 1.w),
                                  child:TextField(

                                    controller: searchController,
                                    cursorColor: MyMateThemes.textColor,
                                    style: TextStyle(fontSize: 14.sp, color: MyMateThemes.textColor),
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        //  padding:EdgeInsets.symmetric(horizontal: 25.w), // Adjust padding if needed
                                        padding: EdgeInsets.all(8.r), // Adjust padding if needed
                                        child: SvgPicture.asset(
                                          'assets/images/search.svg', // Update with your SVG path
                                          colorFilter: ColorFilter.mode(
                                            MyMateThemes.textColor.withOpacity(0.6),
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 3.h), // Centers text vertically
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.r),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),

                                )
                            ),
                        ],
                      ),
                    ),
                  ),

                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  MyMatesGrid(context, myMatesFuture!),
                  receiveRequestGrid(context, receiveRequestFuture!),
                  sendRequestGrid(context,sendRequestFuture!),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                // Handle navigation here based on the index
              },
              docId: docId,
            ),
          );
        }
      },
    );

  }

}

PreferredSizeWidget myMatesPageAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: Text(
      'My Mates',
      style: TextStyle(fontSize: 16, color: MyMateThemes.textColor, fontWeight: FontWeight.w500),
    ),

  );
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
