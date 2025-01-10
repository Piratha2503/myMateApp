import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateThemes.dart';
import 'package:http/http.dart' as http;


Map<String, String>? appliedFilters;

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
Widget ExploreAllGrid(BuildContext context) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: getProfiles(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No profiles found'));
      }

      final data = snapshot.data!;
      return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 1.0,
        childAspectRatio: 152 / 200,
        children: data.map((profile) => buildGridItem(profile)).toList(),
      );
    },
  );
}

Widget ViewMatchesGrid(BuildContext context) {
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
      return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 152 / 200,
        children: data.map((profile) => buildGridItem(profile)).toList(),
      );
    },
  );
}

Widget FilterGrid(BuildContext context,filteredResults) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: getFilteredProfiles(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No filtered profiles found'));
      }

      final data = List<Map<String, dynamic>>.from(filteredResults);
      print('Filtered Profiles in UI: $data'); // Log filtered profiles in UI

      return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 152 / 200,
        children: data.map((profile) => buildGridItem(profile)).toList(),
      );
    },
  );
}

Widget buildGridItem(Map<String, dynamic> profile) {
  return Container(
    height: 265,
    width: 152,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(3.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4.0,
          spreadRadius: 2.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    margin: const EdgeInsets.all(12.0),
    child: Stack(
      children: [
        Container(
          height: 145,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            image: (profile['images'] != null && profile['images'].isNotEmpty)
                ? DecorationImage(
              image: NetworkImage(profile['images'][0]),
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: (profile['images'] == null || profile['images'].isEmpty)
              ? Icon(Icons.person, size: 80, color: Colors.grey[400])
              : null,
        ),
        Positioned(
          top: 120.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            height: 126,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(3.0),
                bottomRight: Radius.circular(3.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(profile['full_name'] ?? 'N/A',
                    style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
                Text('${profile['age'] ?? 'N/A'}, ${profile['marital_status'] ?? 'N/A'}',
                    style: TextStyle(
                        color: MyMateThemes.textColor, fontSize: 11)),
                Text(profile['occupation'] ?? 'N/A',
                    style: TextStyle(
                        color: MyMateThemes.textColor, fontSize: 11)),
                Text(profile['city'] ?? 'N/A',
                    style: TextStyle(
                        color: MyMateThemes.textColor, fontSize: 11)),
                const SizedBox(height: 5),
                Container(
                  width: 108.43,
                  height: 20.85,
                  decoration: BoxDecoration(
                    color: MyMateThemes.secondaryColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/heart .svg'),
                      Text('80%',
                          style: TextStyle(
                              color: MyMateThemes.primaryColor,
                              fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

final search = TextField(
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
);
