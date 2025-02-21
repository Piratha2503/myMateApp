import 'dart:async';
import 'package:flutter/material.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import 'explorePageWidgets.dart'; // Ensure API methods are available

class ExploreProvider extends ChangeNotifier {
  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  void changeTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredResults = [];
  List<Map<String, dynamic>> _allResults = [];
  List<Map<String, dynamic>>  _searchResults = [];

  List<Map<String, dynamic>>  get filteredResults => _filteredResults;
  List<Map<String, dynamic>>  get searchResults => _searchResults;

  bool isFilterApplied = false;
  Timer? _debounce;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void initializeResults(List<Map<String, dynamic>> results) {
    _allResults = results;
    _filteredResults = List.from(_allResults);  // Initialize filtered results if needed
    notifyListeners();
  }

  // ✅ Fetch all profiles from API
  Future<List<Map<String, dynamic>>> getProfiles() async {
    try {
      final data = await fetchAllUsers();
      return data.isNotEmpty ? data : [];
    } catch (e) {
      print('Error fetching profiles: $e');
      return [];
    }
  }



  // ✅ Perform Search (calls API when input is not empty)
  void performSearch() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 100), () async {
      final searchQuery = searchController.text.trim();
      print("Searching for: $searchQuery");  // Debug print

      if (searchQuery.isEmpty) {
        _searchResults = List.from(_allResults);
        print("Search query is empty, showing all results.");  // Debug print
      } else {
        try {
          _searchResults = await searchAllUsers({'full_name': searchQuery}); // API call
          print("Search results: ${_searchResults.length}");  // Debug print
        } catch (e) {
          print("Error searching profiles: $e");  // Error print
        }
      }
      notifyListeners();  // Ensure this is called to update the UI
    });
  }
  void applyFilter(List<Map<String, dynamic>> results) {
    _filteredResults = results;
    isFilterApplied = true;
    print("Filters applied, number of results: ${_filteredResults.length}");
    notifyListeners();
  }

  void clearFilter() {
    isFilterApplied = false;
    _filteredResults = List.from(_allResults);
    print("Filter cleared, showing all results");
    notifyListeners();
  }


  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
