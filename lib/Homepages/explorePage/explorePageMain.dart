import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../MyMateThemes.dart';
import '../FilterPage.dart';
import 'explorePageWidgets.dart';

class ExplorePage extends StatefulWidget {
  final int initialTabIndex;
  final List<Map<String, dynamic>> results;


  const ExplorePage({
    Key? key,
    this.initialTabIndex = 0,
    required this.results,
    required List search,
    required String docId,
    filters,
  }) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}


class _ExplorePageState extends State<ExplorePage> with SingleTickerProviderStateMixin {
  // late Timer _debounce;
  int _selectedIndex = 1;


  late TabController _tabController;
  Future<List<Map<String, dynamic>>>? exploreAllFuture;
  Future<List<Map<String, dynamic>>>? viewMatchesFuture;
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
    exploreAllFuture = getProfiles();
    viewMatchesFuture = getProfiles();

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
          exploreAllFuture = getProfiles();
        } else {
          exploreAllFuture = searchAllUsers(searchCriteria);
          viewMatchesFuture = searchAllUsers(searchCriteria);
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
        exploreAllFuture = getProfiles();
      } else {
        exploreAllFuture = searchAllUsers(searchCriteria);
        viewMatchesFuture = searchAllUsers(searchCriteria);
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
        _tabController.animateTo(data['initialTabIndex'] ?? 2);
        // searchParameter = data['search'] ?? [];
        //docId = data['docId'] ?? '';
      });
    }
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
    return FutureBuilder<String?>(
      future: getSavedDocId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error loading docId')),
          );
        } else {
          final docId = snapshot.data ?? '';

          return LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              double height = constraints.maxWidth;


              return Scaffold(
                backgroundColor: Colors.white,
                body: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        floating: true,
                        snap: true,
                        pinned: false,
                        automaticallyImplyLeading: false,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight( height*0.2),
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
                                indicatorColor:  Colors.transparent,
                                indicatorPadding: EdgeInsets.only(bottom:width*0.01),
                                // indicator: UnderlineTabIndicator(
                                //   borderSide:  BorderSide(
                                //     width: 3,
                                //     color: MyMateThemes.textColor,
                                //   ),
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                               // labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                                tabs:  [
                                  Tab(text: 'Explore All'),
                                  Tab(text: 'View Matches'),
                                  Tab(text: 'Filter'),
                                ],
                              ),
                              //SizedBox(height: height*0.01),
                              if (_tabController.index == 2)
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.04),
                                  child: ElevatedButton(
                                    style: CommonButtonStyle.commonButtonStyle(),
                                    onPressed: () {
                                      if (isFilterApplied) {
                                        _clearFilter();
                                      } else {
                                        _openFilterPage();
                                      }
                                    },
                                    child: Text(isFilterApplied ? 'Clear Filter' : 'Apply Filter'),
                                  ),
                                ),
                              if (_tabController.index != 2)
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.035,vertical: height*0.02),
                                  child: Container(
                                    height: height*0.1,
                                    width:  width * 0.88 ,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyMateThemes.textColor.withOpacity(0.1),
                                        width: width*0.004,
                                      ),
                                      borderRadius: BorderRadius.circular(width*0.01),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal:width*0.01,vertical: height*0.001 ),
                                      child: TextField(
                                        controller: searchController,
                                        cursorColor: MyMateThemes.textColor,
                                        style: TextStyle(
                                          fontSize: width*0.05 ,
                                          color: MyMateThemes.textColor,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding:  EdgeInsets.all(height*0.02),
                                            child: SvgPicture.asset(
                                              'assets/images/search.svg',
                                              colorFilter: ColorFilter.mode(
                                                MyMateThemes.textColor.withOpacity(0.6),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ),
                                          contentPadding:  EdgeInsets.symmetric(vertical:height*0.01),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                      ExploreAllGrid(context, exploreAllFuture!),
                      ViewMatchesGrid(context, Future.value(filteredResults)),
                      FilterGrid(context, filteredResults),
                    ],
                  ),
                ),
                bottomNavigationBar: CustomBottomNavigationBar(
                  selectedIndex: _selectedIndex,
                  onItemTapped: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  docId: docId,
                ),
              );
            },
          );
        }
      },
    );
  }


}

LayoutBuilder ExplorePageAppBar(BuildContext context, VoidCallback onFilterTap) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;

      return AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/filter1.svg',
              width:  width*0.15,
              height:  height*0.15 ,
            ),
            onPressed: onFilterTap,
          ),
          SizedBox(width: width*0.1 ),
        ],
      );
    },
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

