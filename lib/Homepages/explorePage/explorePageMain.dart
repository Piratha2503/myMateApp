import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../MyMateThemes.dart';
import '../FilterPage.dart';
import 'explorePageWidgets.dart';

class ExplorePage extends StatefulWidget {
  final int initialTabIndex;
  final List<Map<String, dynamic>> results;


  const ExplorePage({Key? key, this.initialTabIndex = 0, required this.results, required List search, required String docId}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Future<List<Map<String, dynamic>>>? exploreAllFuture;
  Future<List<Map<String, dynamic>>>? viewMatchesFuture;
  final TextEditingController searchController = TextEditingController();
  late List<Map<String, dynamic>> filteredResults;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTabIndex);

    // Initialize all grids to fetch all profiles initially
    filteredResults = widget.results; // Initialize with passed results
    exploreAllFuture = getProfiles();
    viewMatchesFuture = getProfiles(); // You can replace this with a method to fetch matches
    //filterFuture = getFilteredProfiles(); // You can replace this with a method to fetch filtered results
  }

  Future<void> _applySearch() async {
    final searchCriteria = {
      'full_name': searchController.text.trim(),
    };

    setState(() {
      if (searchCriteria['full_name']!.isEmpty) {
        // Reset to show all profiles
        exploreAllFuture = getProfiles();
       // viewMatchesFuture = getProfiles();
      }


      else {
        // Fetch searched profiles
        exploreAllFuture = searchAllUsers(searchCriteria);
        viewMatchesFuture = searchAllUsers(searchCriteria);
     //   filterFuture = searchAllUsers(searchCriteria);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  /// Opens the FilterPage and retrieves the selected filters
  void _openFilterPage() async {
    final filters = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => FilterPage()),
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
            child:
            TextField(
              controller: searchController,
              style: const TextStyle(fontSize: 14.0, color: MyMateThemes.textColor),
            decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(Icons.search),
         fillColor: MyMateThemes.containerColor,
         hintText: 'Search',
         border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(59),
           borderSide: BorderSide.none,
            ),
           ),
              onSubmitted: (value) => _applySearch(),

            ),

          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Explore All Grid
                ExploreAllGrid(context, exploreAllFuture!),
                // View Matches Grid
                ViewMatchesGrid(context, viewMatchesFuture!),
                // Filter Grid
                FilterGrid(context,filteredResults),
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
        }, docId: '',
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
