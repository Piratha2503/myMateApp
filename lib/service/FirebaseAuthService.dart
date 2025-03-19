import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class FirebaseAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['https://www.googleapis.com/auth/cloud-platform'],
  );

  Future<String?> getOAuthToken() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication auth = await account!.authentication;
    return auth.accessToken;
  }

  Future<void> sendFCMNotification(String recipientToken, String title, String body) async {
    String? token = await getOAuthToken();
    if (token == null) return;

    final Uri url = Uri.parse("https://fcm.googleapis.com/v1/projects/YOUR_PROJECT_ID/messages:send");
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: '''
      {
        "message": {
          "token": "$recipientToken",
          "notification": {
            "title": "$title",
            "body": "$body"
          }
        }
      }
      ''',
    );

    print("Response: ${response.body}");
  }
}
