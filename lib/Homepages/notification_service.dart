import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart' as auth;

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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        _showLocalNotification(
          message.notification!.title ?? "New Request",
          message.notification!.body ?? "Someone sent you a request.",
        );
        print(" Message body: ${message.notification?.body}");

      }
      if ( message.data.containsKey('senderId')) {
        String messageId = message.data['messageId'];
        String senderId = message.data['senderId'];
        String receiverId = FirebaseAuth.instance.currentUser!.uid;

        await FirebaseFirestore.instance
            .collection('clients')
            .doc(receiverId)
            .collection('messages')
            .doc(senderId)
            .collection('chats')
            .doc(messageId)
            .update({'status': 'delivered'});
        print("onMessage triggered: ${message.data}");

        print("Message $messageId marked as delivered.");
      }
    });



    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification clicked!");
    });
  }



  static Future<void> _showLocalNotification(String title, String body) async {
    int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000);

    final BigPictureStyleInformation bigPictureStyle = BigPictureStyleInformation(
      const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
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

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      details,
    );
  }

  static Future<void> sendPushNotification(String fcmToken, String senderName, String actionType) async {
    final String firebaseProjectId = "mymate-62700";
    final String accessToken = await getAccessToken();

    String notificationMessage = actionType == "Request_Sent"
        ? "$senderName wants to connect with you !"
        : "$senderName accepted your request !";

    try {
      final response = await http.post(
        Uri.parse("https://fcm.googleapis.com/v1/projects/$firebaseProjectId/messages:send"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "message": {
            "token": fcmToken,
            "notification": {
              "title": "New Notification",
              "body": notificationMessage,
            },
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "type": actionType,
              "sender": senderName
            }
          }
        }),
      );

      if (response.statusCode == 200) {
        print("Push notification sent successfully!");
      } else {
        print("Failed to send push notification: ${response.body}");
      }
    } catch (e) {
      print("Error sending push notification: $e");
    }
  }

  static Future<void> sendMessageNotification(String fcmToken, String SenderName, String message, String messageId) async {
    final String firebaseProjectId = "mymate-62700";
    final String accessToken = await getAccessToken();

    try {
      final response = await http.post(
        Uri.parse("https://fcm.googleapis.com/v1/projects/$firebaseProjectId/messages:send"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "message": {
            "token": fcmToken,
            "notification": {
              "title": "New Message",
              "body": "$SenderName: $message",
            },
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "type": "message",
              "senderId": SenderName,
              "message": message,
              "messageId" : messageId
            }
          }
        }),
      );

      if (response.statusCode == 200) {
        print(" Message notification sent successfully!");
      } else {
        print(" Failed to send message notification: ${response.body}");
      }
    } catch (e) {
      print(" Error sending message notification: $e");
    }
  }

  static Future<String> getAccessToken() async {
    String jsonString = await rootBundle.loadString('assets/mymate-62700-firebase-adminsdk-lh9km-3f583c87c4.json');
    final serviceAccount = json.decode(jsonString);
    final credentials = auth.ServiceAccountCredentials.fromJson(serviceAccount);
    final client = await auth.clientViaServiceAccount(
        credentials, ['https://www.googleapis.com/auth/firebase.messaging']);

    return client.credentials.accessToken.data;
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
    List<Map<String, dynamic>> allNotifications = [];

    try {
      List<String> receivedDocIds = await _fetchReceivedRequestDocIds(docId);

      final response = await http.get(
          Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/getClientDataList')
      );

      if (response.statusCode == 200) {
        List<dynamic> users = jsonDecode(response.body);

        List<Map<String, dynamic>> matchingUsers = users.where((user) {
          return receivedDocIds.contains(user['docId']);
        }).map((user) {
          return {
            'docId': user['docId'],
            'fullName': user['personalDetails']?['full_name'] ?? 'Unknown User',
            'profileImage': user['profileImages']?['profile_pic_url'] ?? '',
            'type': 'request'
          };
        }).toList();

        List<Map<String, dynamic>> acceptedUsers = users.where((user) {
          List<dynamic>? acceptedList = user['matchings']?['acceptDocIdList'];
          return acceptedList != null && acceptedList.contains(docId);
        }).map((user) {
          return {
            'docId': user['docId'],
            'fullName': user['personalDetails']?['full_name'] ?? 'Unknown User',
            'profileImage': user['profileImages']?['profile_pic_url'] ?? '',
            'type': 'accept'
          };
        }).toList();

        allNotifications.addAll(matchingUsers);
        allNotifications.addAll(acceptedUsers);
      } else {
        print("Failed to fetch user data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching requests: $e");
    }

    return allNotifications;
  }

//
//
//   static void startRealTimeListener(String docId) {
//     Future.delayed(Duration(seconds: 5), () async {
//       await fetchRequests(docId);
//       startRealTimeListener(docId);
//     });
//   }
}