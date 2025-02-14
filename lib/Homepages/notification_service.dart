import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static const String companyLogoUrl = "assets/images/thegraycorp_logo.png";

  static final Set<String> _notifiedRequestIds = {};

  static Future<void> initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('User denied notification permissions');
      return;
    }

    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initSettings =
    InitializationSettings(android: androidInit);
    await _flutterLocalNotificationsPlugin.initialize(initSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showLocalNotification(
          message.notification!.title ?? "New Request",
          message.notification!.body ?? "Someone sent you a request.",
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification clicked!");
    });
  }

  static Future<void> _showLocalNotification(String title, String body) async {
    final BigPictureStyleInformation bigPictureStyle = BigPictureStyleInformation(
      const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'), // Local app logo
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      contentTitle: title,
      summaryText: body,
    );

    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureStyle,
    );

    final NotificationDetails details = NotificationDetails(android: androidDetails);
    await _flutterLocalNotificationsPlugin.show(0, title, body, details);
  }

  static Future<List<String>> _fetchReceivedRequestDocIds(String docId) async {
    final response = await http.get(
      Uri.parse(
          'https://backend.graycorp.io:9000/mymate/api/v1/getClientDataByDocId?docId=$docId'),
    );

    print('Fetching requests for docId: $docId');

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = jsonDecode(response.body);

      if (data == null ||
          !data.containsKey('matchings') ||
          data['matchings']['requestReceivedDocIdList'] == null) {
        print(" No requestReceivedDocIdList found!");
        return [];
      }

      List<dynamic> receivedDocIds = data['matchings']['requestReceivedDocIdList'];
      return receivedDocIds.map((id) => id.toString()).toList();
    } else {
      print(" Failed to fetch received requests: ${response.statusCode}");
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> fetchRequests(String docId) async {
    List<Map<String, dynamic>> newNotifications = [];

    try {
      List<String> receivedDocIds = await _fetchReceivedRequestDocIds(docId);

      if (receivedDocIds.isEmpty) {
        print(" No new requests found.");
        _notifiedRequestIds.clear();
        return newNotifications;
      }

      _notifiedRequestIds.retainWhere((id) => receivedDocIds.contains(id));

      final response = await http.get(
          Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/getClientDataList'));

      if (response.statusCode == 200) {
        List<dynamic> users = jsonDecode(response.body);

        List<Map<String, dynamic>> matchingUsers = users.where((user) {
          return receivedDocIds.contains(user['docId']);
        }).map((user) {
          return {
            'docId': user['docId'],
            'fullName': user['personalDetails']?['full_name'] ?? 'Unknown User',
            'profileImage': user['profileImages']?['profile_pic_url'] ?? '',
          };
        }).toList();

        for (var user in matchingUsers) {
          String requestId = user['docId'];
          if (!_notifiedRequestIds.contains(requestId)) {
            _showLocalNotification("New Request", "${user['fullName']} sent you a request!");
            _notifiedRequestIds.add(requestId);
            newNotifications.add(user);
          }
        }
      } else {
        print(" Failed to fetch user data: ${response.statusCode}");
      }
    } catch (e) {
      print(" Error fetching requests: $e");
    }

    return newNotifications;
  }

  static void startRealTimeListener(String docId) {
    Future.delayed(Duration(seconds: 5), () async {
      await fetchRequests(docId);
      startRealTimeListener(docId);
    });
  }
}