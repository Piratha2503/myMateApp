import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class MyMateAPIs {

  static String mobile_number_registration_API = "https://backend.graycorp.io:9000/mymate/api/v1/saveClientMobile";

  static String get_clientList_API = "https://backend.graycorp.io:9000/mymate/api/v1/getClientDataList";

  static String get_client_byDocId_API = "https://backend.graycorp.io:9000/mymate/api/v1/getClientDataByDocId";

  static String get_client_by_mobile = "http://backend.graycorp.io:9000/mymate/api/v1/getClientDataByMobile/+18741555555";

  static String update_client_API = "http://backend.graycorp.io:9000/mymate/api/v1/updateClient";

}

Future<Map<String, dynamic>> fetchUserById(String docId) async {
  final String apiUrl = MyMateAPIs.get_client_byDocId_API;

  try {
    if (docId.isEmpty) {
      print('Error: userId is empty');
      return {};
    }
    final Uri url = Uri.parse('$apiUrl?docId=$docId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final personalDetails = data['personalDetails'] ?? {};
      final careerStudies = data['careerStudies'] ?? {};
      final contactInfo = data['contactInfo'] ?? {};
      final astrology = data['astrology'] ?? {};
      final countryCode = contactInfo['mobile_country_code'] ?? '';
      var  mobileNumber = contactInfo['mobile'] ?? '';
      final address = contactInfo['address'] ?? {};
      final houseNumber = address['house_number'] ?? '';
      final home = address['home'] ?? '';
      final lane = address['lane'] ?? '';
      final city = address['city'] ?? '';
      final country = address['country'] ?? '';
      final lifestyle = data['lifestyle'] ?? {};
      final profileImages = data['proilfeImages'] ?? {};

      final imageGallery =
          profileImages['images']?['gallery_image_urls'] ?? [];
      final userImages = (imageGallery as List).take(3).toList();

      if (mobileNumber.isNotEmpty && !mobileNumber.startsWith(countryCode)) {
        mobileNumber = '$countryCode$mobileNumber';
      }

      final formattedAddress = houseNumber.isNotEmpty &&
          home.isNotEmpty &&
          lane.isNotEmpty &&
          city.isNotEmpty
          ? '$houseNumber, $home, $lane, $city, $country.'
          : 'N/A';

      return {
        'id': docId,

        'full_name': personalDetails['full_name'] ?? 'N/A',
        'age': personalDetails['age'] ?? 'N/A',
        'date_of_birth': astrology['dob'] ?? 'N/A',
        'occupation': careerStudies['occupation'] ?? 'N/A',
        'occupation_type' : careerStudies['occupation_type'] ?? 'N/A',
        'address': formattedAddress,
        'city' : address['city'] ?? 'N/A',
        'education': careerStudies['higher_studies'] ?? 'N/A',
        'height': personalDetails['height'] ?? 'N/A',
        'religion': personalDetails['religion'] ?? 'N/A',
        'caste': personalDetails['caste'] ?? 'N/A',
        'mothers_name': data['mothers_name'] ?? 'N/A',
        'contact': mobileNumber,
        'no_of_siblings': data['no_of_siblings'] ?? 0,
        'hobbies': lifestyle['hobbies'] ?? 'N/A',
        'favorites': lifestyle['personal_interest'] ?? 'N/A',
        'expectations' :lifestyle['expectations'] ?? 'N/A',
        'alcohol': lifestyle['habits'] ?? 'N/A',
        'sports': data['sports'] ?? 'N/A',
        'cooking': data['cooking'] ?? 'N/A',
        'bio': personalDetails['bio'] ?? 'N/A',
        'images': userImages,
        'religion': personalDetails['religion'] ?? 'N/A',
        'civil_status' : personalDetails['marital_status'] ?? 'N/A',

      };
    } else {
      print('Failed to fetch user details. Status code: ${response.statusCode}');
      return {};
    }
  } catch (e) {
    print('Error fetching user by ID: $e');
    return {};
  }
}