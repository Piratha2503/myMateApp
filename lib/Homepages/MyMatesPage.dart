import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../MyMateThemes.dart';
import 'FilterPage.dart';
import 'explorePage/explorePageWidgets.dart';

class MyMatesPage extends StatefulWidget {
  final int initialTabIndex;
  final List<Map<String, dynamic>> results;


  const MyMatesPage({
    Key? key,
    this.initialTabIndex = 0,
    required this.results,
    required List search,
    required String docId,
    filters,
  }) : super(key: key);

  @override
  _MyMatesPageState createState() => _MyMatesPageState();
}

class _MyMatesPageState extends State<MyMatesPage> with SingleTickerProviderStateMixin {
  // late Timer _debounce;
  int _selectedIndex = 1;


  late TabController _tabController;
  Future<List<Map<String, dynamic>>>? myMatesFuture;
  final TextEditingController searchController = TextEditingController();
  late List<Map<String, dynamic>> filteredResults;
  late List<Map<String, dynamic>> allResults;
  Timer? _debounce;

  ScrollController _scrollController = ScrollController();
  bool _showHeader = true;  // Variable to track header visibility
  bool isFilterApplied = false; // State variable to track filter status




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
    filteredResults = List.from(widget.results);
    myMatesFuture = getProfiles();

    // Add listener to perform real-time search
    searchController.addListener(_performSearch);

  }

  void _openFilterPage() async {
    final Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FilterPage()),
    );

    if (data != null && data['filters'] != null && data['results'] != null) {
      setState(() {
        appliedFilters = Map<String, String>.from(data['filters']); // ✅ Store filters
        filteredResults = List<Map<String, dynamic>>.from(data['results']); // ✅ Store results
        isFilterApplied = true; // ✅ Update button state

        // ✅ Preserve additional data
        _tabController.animateTo(data['initialTabIndex'] ?? 1);
        // searchParameter = data['search'] ?? [];
        //docId = data['docId'] ?? '';
      });
    }
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
        } else {
          myMatesFuture = searchAllUsers(searchCriteria);
        }

      }



      );
    }
    );
  }



  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }



  void _clearFilter() {
    setState(() {
      appliedFilters?.clear();
      isFilterApplied = false;
      filteredResults.clear();
    });
  }


  void fetchFilteredProfiles() async {
    try {
      final results = await getFilteredProfiles();
      setState(() {
        filteredResults = results;
      });
    } catch (e) {
      print('Error fetching filtered profiles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      ScreenUtilInit(
        designSize: const Size(390,844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
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
                          title: myMatesPageAppBar(context, _openFilterPage),
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(50.h), // Adjust height to accommodate additional widgets
                            child: Column(
                              children: [

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
        },
      );
  }

}

PreferredSizeWidget myMatesPageAppBar(BuildContext context, VoidCallback onFilterTap) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: Text('My Mates',style: TextStyle(fontSize: 16,color: MyMateThemes.textColor,fontWeight: FontWeight.w500),),
    actions: [
      IconButton(
        icon: SvgPicture.asset('assets/images/filter1.svg', width: 24.w, height: 24.h),
        onPressed: onFilterTap,
      ),
      SizedBox(width: 10.w),
    ],
  );
}

Widget MyMatesGrid(BuildContext context, Future<List<Map<String, dynamic>>> profilesFuture) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: profilesFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No profiles found'));
      }

      final data = snapshot.data!;
      return

        GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          crossAxisCount: 2,
          crossAxisSpacing:0.4.w,
          mainAxisSpacing: 0.4.h,

          childAspectRatio: 0.58.h,
          // Fixed width-to-height ratio
          children: data.map((profile) => buildGridItem(profile)).toList(),
        );
    },
  );
}
