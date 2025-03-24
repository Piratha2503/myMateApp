import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateThemes.dart';
import 'package:http/http.dart' as http;

import '../Profiles/OthersProfile.dart';


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
// Future<List<Map<String, dynamic>>> getProfiles() async {
//   try {
//     final data = await fetchAllUsers();
//     return data.isNotEmpty ? data : [];
//   } catch (e) {
//     print('Error fetching profiles: $e');
//     return [];
//   }
// }
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
Widget receiveRequestGrid(BuildContext context, Future<List<Map<String, dynamic>>> profilesFuture) {
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
Widget sendRequestGrid(BuildContext context, Future<List<Map<String, dynamic>>> profilesFuture) {
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


Widget buildGridItem(Map<String, dynamic> profiles) {
  return Builder(
    builder: (context) {
      return
        Expanded(
          child:
          GestureDetector(
            onTap: () {
              if (profiles.containsKey('docId')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtherProfilePage(SoulId: profiles['docId']),
                  ),
                );
              } else {
                print("Error: docId not found for this profile");
              }
            },
            child: Container(
              height: 300.h,
              width: 152.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: MyMateThemes.textColor.withOpacity(0.1),
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              margin: EdgeInsets.all(8.w),
              child: Stack(
                children: [
                  // Profile Image
                  Container(
                    height: 150.h,

                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: MyMateThemes.textColor.withOpacity(0.1),
                      //   width: 1,
                      // ),
                      borderRadius: BorderRadius.circular(8),
                      image: (profiles['profileImages']?['profile_pic_url'] != null && profiles['profileImages']?['profile_pic_url'].isNotEmpty)
                          ? DecorationImage(
                        image: NetworkImage(profiles['profileImages']?['profile_pic_url']),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: (profiles['profileImages']?['profile_pic_url'] == null || profiles['profileImages']?['profile_pic_url'].isEmpty)
                        ? Icon(Icons.person, size: 80.r, color: Colors.grey[400])
                        : null,
                  ),
                  // Profile Details
                  Positioned(
                    top: 145.h,
                    left: 0,
                    right: 0,
                    child:

                    Container(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.r),
                          bottomRight: Radius.circular(8.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            profiles['personalDetails']?['full_name'] ?? 'N/A',
                            style: TextStyle(
                              color: MyMateThemes.textColor,
                              fontWeight: FontWeight.w700,
                              fontSize:  12.sp, // Scaled font size
                            ),
                          ),
                          Text(
                            '${profiles ['personalDetails']?['age'] ?? 'N/A'}, ${profiles ['personalDetails']?['marital_status'] ?? 'N/A'}',
                            style: TextStyle(
                              color: MyMateThemes.textColor,
                              fontSize:  11.sp,
                            ),
                          ),
                          Text(
                            profiles['careerStudies']?['occupation'] ?? 'N/A',
                            style: TextStyle(
                              color: MyMateThemes.textColor,
                              fontSize:  11.sp,
                            ),
                          ),
                          Text(profiles['contactInfo']?['address']?['city'] ?? 'N/A',
                              style: TextStyle(
                                  color: MyMateThemes.textColor, fontSize: 11.sp)),
                          SizedBox(height: 5.h),
                          Container(
                            width: 107.43.w,
                            height: 19.85.h,
                            decoration: BoxDecoration(
                              color: MyMateThemes.secondaryColor,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/heart .svg'),
                                Text('80%',
                                    style: TextStyle(
                                        color: MyMateThemes.primaryColor,
                                        fontSize: 14.sp)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),);

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