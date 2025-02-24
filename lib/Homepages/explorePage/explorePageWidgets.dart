import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateThemes.dart';
import 'package:http/http.dart' as http;

import '../Profiles/OthersProfile.dart';
import 'explorePageMain.dart';


Map<String, String>? appliedFilters;
Map<String, String>? appliedSearch;


// Fetch data from API
// Future<void> fetchSearchResults(String query) async {
//   final url = Uri.parse('https://example.com/search?query=$query'); // Replace with your API endpoint
//   {
//     _isLoading = true;
//   }
//
//   try {
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       {
//         _searchResults = json.decode(response.body); // Parse response
//         _isLoading = false;
//       }
//     } else {
//       throw Exception("Failed to load results");
//     }
//   } catch (error) {
//
//       _isLoading = false;
//     }
//   }
Future<List<Map<String, dynamic>>> getProfiles() async {
  try {
    final data = await fetchAllUsers();
    return data.isNotEmpty ? data : [];
  } catch (e) {
    print('Error fetching profiles: $e');
    return [];
  }
}
Future<List<Map<String, dynamic>>> getFilteredProfiles() async {

  try {
    if (appliedFilters != null && appliedFilters!.isNotEmpty) {
      print('Applying Filters: $appliedFilters');

      // Construct API URL with query parameters
      Uri uri = Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/clientFilter');
      if (appliedFilters != null && appliedFilters!.isNotEmpty) {
        uri = uri.replace(queryParameters: appliedFilters);
      }

      print('Constructed API Request URL: $uri');

      // Send API request
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
      });

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Parse response if successful
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('Filtered API Response: $data');
        return List<Map<String, dynamic>>.from(data);
      } else {
        print('Failed to fetch filtered profiles: ${response.body}');
        return [];
      }
    } else {
      print('No filters applied. Fetching all profiles.');
      return await fetchAllUsers();
    }
  } catch (e) {
    print('Error fetching filtered profiles: $e');
    return [];
  }
}

Widget ExploreAllGrid(BuildContext context, Future<List<Map<String, dynamic>>> profilesFuture) {
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
        LayoutBuilder(
          builder: (context, constraints) {

            return GridView.count(
              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.04),
              crossAxisSpacing: constraints.maxWidth * 0.005,
              mainAxisSpacing: constraints.maxHeight * 0.005,
              childAspectRatio:  2.6,
              crossAxisCount: 1,
              children: data.map((profile) => buildViewItem(profile)).toList(),
            );
          },
        );
    },
  );
}

Widget ViewMatchesGrid(BuildContext context, Future<List<Map<String, dynamic>>> future) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: getFilteredProfiles(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No matches found'));
      }

      final data = snapshot.data!;
      return  GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        crossAxisCount: 2,
        crossAxisSpacing:3.w,
        mainAxisSpacing: 3.h,

        childAspectRatio: 0.48.h,
        // Fixed width-to-height ratio
        children: data.map((profile) => buildViewItem(profile)).toList(),
      );
    },
  );
}
Widget FilterGrid(BuildContext context, List<Map<String, dynamic>> filteredResults) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: getFilteredProfiles(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (filteredResults.isEmpty) {
        return const Center(child: Text('No filtered profiles found'));
      }


      final data = List<Map<String, dynamic>>.from(filteredResults);
      print('Filtered Profiles in UI: $data'); // Log filtered profiles in UI

      return
        GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          crossAxisCount: 2,
          crossAxisSpacing:3.w,
          mainAxisSpacing: 3.h,

          childAspectRatio: 0.58.h,
          // Fixed width-to-height ratio
          children: data.map((profile) => buildViewItem(profile)).toList(),
        );
    },
  );
}


Widget buildGridItem(Map<String, dynamic> profile) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtherProfilePage(SoulId: profile['id']),
            ),
          );
        },
        child: Container(
          height: constraints.maxHeight * 0.75,  // Responsive height
          width: constraints.maxWidth * 0.45,   // Responsive width
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: MyMateThemes.textColor.withOpacity(0.8),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(constraints.maxWidth * 0.02),
          ),
          margin: EdgeInsets.all(constraints.maxWidth * 0.02),
          child:
          Expanded(
              child:
          Stack(
            children: [
              // Profile Image
              Container(
                width: constraints.maxWidth * 0.2, // Ensure it has width & height
                height: constraints.maxWidth * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MyMateThemes.premiumAccent,
                    width: constraints.maxWidth * 0.01,
                  ),
                  image: (profile['images'] != null && profile['images'].isNotEmpty)
                      ? DecorationImage(
                    image: Image.network(profile['images']).image, // Ensures proper fetching
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: (profile['images'] == null || profile['images'].isEmpty)
                    ? ClipOval(
                  child: Icon(
                    Icons.person,
                    size: constraints.maxWidth * 0.1,
                    color: Colors.grey[400],
                  ),
                )
                    : null,
              ),              // Profile Details

              Positioned(
                top: constraints.maxHeight * 0.5,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(constraints.maxWidth * 0.02),
                      bottomRight: Radius.circular(constraints.maxWidth * 0.02),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        profile['full_name'] ?? 'N/A',
                        style: TextStyle(
                          color: MyMateThemes.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: constraints.maxWidth * 0.075,
                        ),
                      ),
                      Text(
                        '${profile['age'] ?? 'N/A'}, ${profile['marital_status'] ?? 'N/A'}',
                        style: TextStyle(
                          color: MyMateThemes.textColor,
                          fontSize: constraints.maxWidth * 0.06,
                        ),
                      ),
                      Text(
                        profile['occupation'] ?? 'N/A',
                        style: TextStyle(
                          color: MyMateThemes.textColor,
                          fontSize: constraints.maxWidth * 0.06,
                        ),
                      ),
                      Text(
                        profile['city'] ?? 'N/A',
                        style: TextStyle(
                          color: MyMateThemes.textColor,
                          fontSize: constraints.maxWidth * 0.06,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.015),
                      Container(
                        width: constraints.maxWidth * 0.4,
                        height: constraints.maxHeight * 0.2,
                        decoration: BoxDecoration(
                          color: MyMateThemes.secondaryColor,
                          borderRadius: BorderRadius.circular(constraints.maxWidth * 0.02),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/heart .svg',

                              width: constraints.maxWidth * 0.07,
                            ),
                            SizedBox(width: constraints.maxWidth * 0.02),
                            Text(
                              '80%',
                              style: TextStyle(
                                color: MyMateThemes.primaryColor,
                                fontSize: constraints.maxWidth * 0.06,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
          ),
        ),
      );
    },
  );
}


Widget buildViewItem(Map<String, dynamic> profile) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtherProfilePage(SoulId: profile['id']),
            ),
          );
        },
        child: Container(
          height: constraints.maxHeight * 0.2,  // Responsive height
          width: constraints.maxWidth * 0.8,   // Responsive width
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              //color: MyMateThemes.textColor.withOpacity(0.8),
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(constraints.maxWidth * 0.02),
          ),
          margin: EdgeInsets.all(constraints.maxWidth * 0.02),
          child:
          Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.1), // Use constraints

                Row(
                  children: [
                    SizedBox(width: constraints.maxWidth * 0.05), // Use constraints
                    Container(
                      width: constraints.maxWidth * 0.3,
                      height: constraints.maxWidth * 0.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MyMateThemes.premiumAccent,
                          width: constraints.maxWidth * 0.01,
                        ),
                        image: (profile['images'] != null && profile['images'].isNotEmpty)
                            ? DecorationImage(
                          image: NetworkImage(profile['images']),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: (profile['images'] == null || profile['images'].isEmpty)
                          ? ClipOval(
                        child: Icon(
                          Icons.person,
                          size: constraints.maxWidth * 0.1,
                          color: Colors.grey[400],
                        ),
                      )
                          : null,
                    ),

                    SizedBox(width: constraints.maxWidth * 0.06),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:  constraints.maxHeight * 0.06),
                        Padding(
                          padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02), // Use constraints
                          child:
                          Text(
                            profile['full_name'] ?? 'N/A',
                            style: TextStyle(
                              color: MyMateThemes.textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: constraints.maxWidth * 0.04,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02), // Use constraints
                          child: Row(
                            children: [
                              Text(
                                '${profile['age'] ?? 'N/A'}, ${profile['marital_status'] ?? 'N/A'}',
                                style: TextStyle(
                                  color: MyMateThemes.textColor,
                                  fontSize: constraints.maxWidth * 0.03,
                                ),
                              ),

                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.04), // Use constraints
                          child:
                          Text(
                            profile['city'] ?? 'N/A',
                            style: TextStyle(
                              color: MyMateThemes.textColor,
                              fontSize: constraints.maxWidth * 0.03,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02), // Use constraints
                          child: Container(
                            width: constraints.maxWidth * 0.25, // Use constraints
                            height: constraints.maxHeight * 0.18, // Use constraints
                            decoration: BoxDecoration(
                              color: MyMateThemes.secondaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/heart .svg',

                                  width: constraints.maxWidth * 0.03,
                                ),
                                SizedBox(width: constraints.maxWidth * 0.02),
                                Text(
                                  '80 - 100%',
                                  style: TextStyle(
                                    color: MyMateThemes.primaryColor,
                                    fontSize: constraints.maxWidth * 0.03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],



                    ),
                  ],
                ),

              ],
          ),
        ),
      );
    },
  );
}