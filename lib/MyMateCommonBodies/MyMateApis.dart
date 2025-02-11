import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Homepages/explorePage/explorePageWidgets.dart';
import '../dbConnection/ClientDatabase.dart';

class MyMateAPIs{

  static String commonEndPoint = "/mymate/api/v1";
  static String vpsApi = "https://backend.graycorp.io:9000";
  static String localApi = "http://192.168.1.10:9000";

  static String mobile_number_registration_API = "$vpsApi$commonEndPoint/saveClientMobile";

  static String get_clientList_API = "$vpsApi$commonEndPoint/getClientDataList";

  static String get_client_byDocId_API = "$vpsApi$commonEndPoint/getClientDataByDocId";

  static String get_client_by_mobile = "$vpsApi$commonEndPoint/getClientDataByMobile";

  static String update_client_API = "$vpsApi$commonEndPoint/updateClient";

  static String save_client_API = "$vpsApi$commonEndPoint/saveClientData";

  static String filter_Clients_API = "$vpsApi+$commonEndPoint/clientFilter";

  static String send_request_API = "https://backend.graycorp.io:9000/mymate/api/v1/RequestSent";




}
Future<Map<String, dynamic>> fetchUserById(String docId,) async {
  final String apiUrl = MyMateAPIs.get_client_byDocId_API;


  try {
    if (docId.isEmpty) {
      print('Error: userId is empty');
      return {};
    }
    final Uri url = Uri.parse('$apiUrl?docId=$docId');
    print('Fetching details from: $url');
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
          profileImages?['gallery_image_urls'] ?? [];
      final userImages = (imageGallery as List).take(3).toList();


      // if (mobileNumber.isNotEmpty && !mobileNumber.startsWith(countryCode)) {
      //   mobileNumber = '$countryCode$mobileNumber';
      // }
      final isProfileComplete = data['isProfileComplete'] ?? false;
      final completeProfilePending = data['completeProfilePending'] ?? {};


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
        'isProfileComplete': isProfileComplete,
        'completeProfilePending':completeProfilePending,
        'full_name': personalDetails['full_name'] ?? 'N/A',
        'first_name': personalDetails['first_name'] ?? 'N/A',
        'age': personalDetails['age'] ?? 'N/A',
        'dob': astrology['dob'] ?? 'N/A',
        'dot': astrology['dot'] ?? 'N/A',
        'occupation': careerStudies['occupation'] ?? 'N/A',
        'occupation_type' : data['careerStudies']?['occupation_type'] ?? 'N/A',
        'address': formattedAddress,
        //'address' : contactInfo['address'] ?? 'N/A',

        'city' : address['city'] ?? 'N/A',
        'education': careerStudies['higher_studies'] ?? 'N/A',
        'height': personalDetails['height'] ?? 0.0,
        'language': personalDetails['language'] ?? 'N/A',
        'religion': personalDetails['religion'] ?? 'N/A',
        'caste': personalDetails['caste'] ?? 'N/A',
        'mother_name': personalDetails['mother_name'] ?? 'N/A',
        'contact': mobileNumber,
        'num_of_siblings': personalDetails['num_of_siblings'] ?? 0,
        'hobbies': lifestyle['hobbies'] ?? 'N/A',
        'favorites': lifestyle['personal_interest'] ?? 'N/A',
        'alcohol': lifestyle['habits'] ?? 'N/A',
        'sports': data['sports'] ?? 'N/A',
        // 'cooking': data['cooking'] ?? 'N/A',
        'bio': personalDetails['bio'] ?? 'N/A',
        'images': userImages,
        'civil_status' : personalDetails['marital_status'] ?? 'N/A',
        'expectations' :lifestyle['expectations'] ?? 'N/A',
        'profile_pic_url': data['profileImages']?['profile_pic_url'] ?? 'https://piratha.com/images/profile.png',
        'gallery_image_urls': data['profileImages']?['gallery_image_urls'] ?? 'N/A',
        'country' : address['country'] ?? 'N/A',
        'rasi': astrology['rasi'] ?? 'N/A',
        'natchathiram': astrology['natchathiram'] ?? 'N/A',
        'alcoholIntake' :lifestyle['alcoholIntake'] ?? 'N/A',
        'cooking' :lifestyle['cooking'] ?? 'N/A',
        'eating_habit' :lifestyle['eating_habit'] ?? 'N/A',
        'smoking' :lifestyle['smoking'] ?? 'N/A',
        'personal_intrest': lifestyle['personal_intrest'] ?? 'N/A',


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
          'full_name': user['personalDetails']?['full_name'] ?? 'N/A',
          //'address': user['contactInfo']?['address']?['city'] ?? '',
          'marital_status': user['personalDetails']?['marital_status'] ?? 'N/A',
          'age': user['personalDetails']?['age'] ?? 'N/A',
          'occupation': user['careerStudies']?['occupation'] ?? 'N/A',
          'images': user['profileImages']?['profile_pic_url'] ?? '',

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
Future<List<Map<String, dynamic>>> filterAllUsers(Map<String, String> filters) async {
  try {
    // Construct the URL with query parameters
    final uri = Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/clientFilter')
        .replace(queryParameters: filters);

    print('Constructed API Request URL: $uri');


    // Make the GET request
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json', // Add additional headers if needed
        // 'Authorization': 'Bearer <your-auth-token>',
      },
    );

    // if (response.statusCode == 200) {
    //   // Decode and return the response as a list of maps
    //   return List<Map<String, dynamic>>.from(json.decode(response.body));
    // } else {
    //   print('Failed to fetch filtered profiles. Status: ${response.statusCode}, Body: ${response.body}');
    //   throw Exception('Failed to fetch filtered profiles');
    // }

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      return responseData.map((user) {
        return {
          'id': user['docId'] ?? '',
          //'city' : user['address']?['city'] ?? '',
          'full_name': user['personalDetails']?['full_name'] ?? 'N/A',
          //'address': user['contactInfo']?['address']?['city'] ?? '',
          'marital_status': user['personalDetails']?['marital_status'] ?? 'N/A',
          'age': user['personalDetails']?['age'] ?? '',
          'occupation': user['careerStudies']?['occupation'] ?? 'N/A',
          // 'images': user['profileImages']?['gallery_image_urls'] ?? [],
          'images': user['profileImages']?['profile_pic_url'] ?? '',

          'city' : user['city'] ?? 'N/A',
        };
      }).toList();
    } else {
      print('Failed to fetch all users. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
Future<Map<String, dynamic>> showMatchingResults(String clientDocId, String soulDocId) async {
  final apiUrl =
      "https://backend.graycorp.io:9000/mymate/api/v1/CheckMatch?clientDocId=$clientDocId&soulDocId=$soulDocId";

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Failed to fetch match data: ${response.body}");
      throw Exception("Failed to fetch match data");
    }
  } catch (e) {
    print("Error in fetchMatchData: $e");
    throw e;
  }
}
Future<List<Map<String, dynamic>>> searchAllUsers(Map<String, String> searchParams) async {
  try {
    // Construct the URL with query parameters for search
    final uri = Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/clientFilter')
        .replace(queryParameters: searchParams);

    print('Constructed API Request URL for search: $uri');

    // Make the GET request
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        // Add additional headers if needed, e.g., authentication
        // 'Authorization': 'Bearer <your-auth-token>',
      },
    );

    if (response.statusCode == 200) {
      // Decode the JSON response
      final List<dynamic> responseData = jsonDecode(response.body);

      // Map the response data to a list of maps with desired fields
      return responseData.map((user) {
        return {
          'id': user['docId'] ?? '',
          'full_name': user['personalDetails']?['full_name'] ?? 'N/A',
          'marital_status': user['personalDetails']?['marital_status'] ?? 'N/A',
          'age': user['personalDetails']?['age'] ?? '',
          'occupation': user['careerStudies']?['occupation'] ?? 'N/A',
          'images': user['profileImages']?['profile_pic_url'] ?? '',
          'city': user['city'] ?? 'N/A',
        };
      }).toList();
    } else {
      print('Search failed. Status code: ${response.statusCode}, Response: ${response.body}');
      return [];
    }
  } catch (e) {
    print('Error during search: $e');
    return [];
  }
}



Future<void> updateClientData(ClientData clientData) async {
  final url = Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/updateClient');

  try {
    final Map<String, dynamic> clientDataMap = clientData.toMap();
    print("📤 Sending JSON Data: ${jsonEncode(clientDataMap)}"); // Debugging

    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(clientDataMap),
    );

    print("🔹 Response Code: ${response.statusCode}");
    print("🔹 Response Body: ${response.body}");

    if (response.statusCode == 200) {
      // final clientData = jsonDecode(response.body);
      // final astrology = clientData['astrology'] ?? {};
      //

      print("✅ Client data updated successfully.");
    } else {
      print("❌ Error updating client data: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("❌ API error: $e");
  }
}