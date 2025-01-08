import 'dart:convert';
import 'package:http/http.dart' as http;

class MyMateAPIs{

  static String commonEndPoint = "/mymate/api/v1";
  static String vpsApi = "https://backend.graycorp.io:9000";
  static String localApi = "http://192.168.1.55:9000";

  static String mobile_number_registration_API = "$vpsApi$commonEndPoint/saveClientMobile";

  static String get_clientList_API = "$vpsApi$commonEndPoint/getClientDataList";

  static String get_client_byDocId_API = "$vpsApi$commonEndPoint/getClientDataByDocId";

  static String get_client_by_mobile = "$vpsApi$commonEndPoint/getClientDataByMobile";

  static String update_client_API = "$vpsApi$commonEndPoint/updateClient";

  static String save_client_API = "$vpsApi$commonEndPoint/saveClientData";

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
      final mobileNumber = contactInfo['mobile'] ?? '';
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


      // if (mobileNumber.isNotEmpty && !mobileNumber.startsWith(countryCode)) {
      //   mobileNumber = '$countryCode$mobileNumber';
      // }

      final formattedAddress =
      (houseNumber.isNotEmpty ||
          home.isNotEmpty ||
          lane.isNotEmpty ||
          city.isNotEmpty ||
          country.isNotEmpty)
          ? '$houseNumber $home $lane $city $country'.trim().replaceAll(RegExp(r'\s+'), ', ')
          : 'N/A';


      return {
        'id': docId,

        'full_name': personalDetails['full_name'] ?? 'N/A',
        'first_name': personalDetails['first_name'] ?? 'N/A',
        'age': personalDetails['age'] ?? 'N/A',
        'dob': astrology['dob'] ?? 'N/A',
        'dot': astrology['dot'] ?? 'N/A',
        'occupation': careerStudies['occupation'] ?? 'N/A',
        'occupation_type' : careerStudies['occupation_type'] ?? 'N/A',
        'address': formattedAddress,
        //'address' : contactInfo['address'] ?? 'N/A',

        'city' : address['city'] ?? 'N/A',
        'education': careerStudies['higher_studies'] ?? 'N/A',
        'height': personalDetails['height'] ?? 'N/A',
        'religion': personalDetails['religion'] ?? 'N/A',
        'caste': personalDetails['caste'] ?? 'N/A',
        'mother_name': personalDetails['mother_name'] ?? 'N/A',
        'contact': mobileNumber,
        'num_of_siblings': personalDetails['num_of_siblings'] ?? 0,
        'hobbies': lifestyle['hobbies'] ?? 'N/A',
        'favorites': lifestyle['personal_interest'] ?? 'N/A',
        'alcohol': lifestyle['habits'] ?? 'N/A',
        'sports': data['sports'] ?? 'N/A',
        'cooking': data['cooking'] ?? 'N/A',
        'bio': personalDetails['bio'] ?? 'N/A',
        'images': userImages,
        'civil_status' : personalDetails['marital_status'] ?? 'N/A',
        'expectations' :lifestyle['expectations'] ?? 'N/A',
        'profile_pic_url' : profileImages['profile_pic_url'] ?? 'N/A',
        'gallery_image_urls' : profileImages['gallery_image_urls'] ?? 'N/A',
        'country' : address['country'] ?? 'N/A',
        'rasi': astrology['rasi'] ?? 'N/A',
        'natchathiram': astrology['natchathiram'] ?? 'N/A',


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

Future<List<Map<String, dynamic>>> fetchAllUsers() async {
  final String apiUrl = 'https://backend.graycorp.io:9000/mymate/api/v1/getClientDataList';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      return responseData.map((user) {
        return {
          'id': user['docId'] ?? '',
          'city' : user['address']?['city'] ?? '',
          'full_name': user['personalDetails']?['full_name'] ?? '',
          //'address': user['contactInfo']?['address']?['city'] ?? '',
          'marital_status': user['personalDetails']?['marital_status'] ?? '',
          'age': user['personalDetails']?['age'] ?? '',
          'occupation': user['careerStudies']?['occupation'] ?? '',
          'images': user['profileImages']?['gallery_image_urls'] ?? [],
          'city' : user['city'] ?? 'N/A',
        };
      }).toList();
    } else {
      print('Failed to fetch all users. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error fetching all users: $e');
    return [];
  }
}

