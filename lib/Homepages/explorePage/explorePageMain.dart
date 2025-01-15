import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../MyMateThemes.dart';
import '../FilterPage.dart';
import 'explorePageWidgets.dart';

class ExplorePage extends StatefulWidget {
  final int initialTabIndex;
  final List<Map<String, dynamic>> results;
  final String docId;
  const ExplorePage({Key? key,required this.docId, this.initialTabIndex = 0, required this.results})
      : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  late List<Map<String, dynamic>> filteredResults;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    filteredResults = widget.results; // Initialize with passed results
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Opens the FilterPage and retrieves the selected filters
  void _openFilterPage() async {
    final filters = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => FilterPage(docId: widget.docId,)),
    );

    if (filters != null) {
      setState(() {
        appliedFilters = filters; // Update global filters
        _tabController.animateTo(2); // Switch to the Filter tab
        fetchFilteredProfiles(); // Fetch new filtered results
      });
    }
  }

  /// Fetch profiles based on applied filters
  void fetchFilteredProfiles() async {
    try {
      final results = await getFilteredProfiles();
      setState(() {
        filteredResults = results; // Update the filtered results
      });
    } catch (e) {
      print('Error fetching filtered profiles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ExplorePageAppBar(context, _openFilterPage),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyMateThemes.textColor,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: MyMateThemes.textColor.withOpacity(0.8),
            ),
            indicatorColor: MyMateThemes.textColor,
            labelPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            tabs: const [
              Tab(text: 'Explore All'),
              Tab(text: 'View Matches'),
              Tab(text: 'Filter'),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: search, // Search bar widget from ExplorePageWidgets.dart
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
                FilterGrid(context,filteredResults), // Pass filtered results
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _tabController.index,
        onItemTapped: (index) {
          setState(() {
            _tabController.index = index;
          });
        }, docId: widget.docId,
      ),
    );
  }
}

PreferredSizeWidget ExplorePageAppBar(BuildContext context, VoidCallback onFilterTap) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false, // Prevents the default back arrow

    title: const Text(
      'Explore',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
        icon: SvgPicture.asset('assets/images/filter1.svg'),
        onPressed: onFilterTap,
      ),
      const SizedBox(width: 10),
    ],
  );
}
