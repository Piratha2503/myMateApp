import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MyMateCommonBodies/MyMateApis.dart';
import 'notification_service.dart';
import 'encryption_helper.dart';

class MessageService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    print('Retrieved Token: $token');
    return token;
  }

  static Future<void> sendMessage(String senderId, String receiverId, String message) async {
    final encryptedMessage = EncryptionHelper.encryptMessage(message);
    Map<String, dynamic> senderData = await fetchUserById(senderId);
    String senderName = senderData['full_name'] ?? "Unknown User";


    final String? receiverFcmToken ="e4njpC4BR6mQOrOo4npCh-:APA91bGrcKyCqpEiWaoHPDNrocmnZ9Blh0CsN5sL_v84jwf2trGkjhijEUTcm0rNkt_xgyVuuiDjLfW0JUUEXTZqvEdVGUvMXP9o1kFccqPcozcWiBaZMp8";
    //await getToken();
    print('Token is $receiverFcmToken');
    print('senderId is :$senderId');

    final messageRef = _firestore.collection('clients')
        .doc(senderId)
        .collection('messages')
        .doc(receiverId)
        .collection('chats')
        .doc();

    final messageData = {
      'message': encryptedMessage,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'sent',
    };

    await messageRef.set(messageData);
    await _firestore.collection('clients')
        .doc(receiverId)
        .collection('messages')
        .doc(senderId)
        .collection('chats')
        .doc(messageRef.id)
        .set(messageData);

    if (receiverFcmToken != null) {
      NotificationService.sendMessageNotification(receiverFcmToken, senderName, message, messageRef.id);
    }
  }


  static Stream<List<Map<String, dynamic>>> getMessages(String userId, String otherUserId) {
    return _firestore
        .collection('clients')
        .doc(userId)
        .collection('messages')
        .doc(otherUserId)
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data();
      data['message'] = EncryptionHelper.decryptMessage(data['message']);
      return data;
    }).toList());
  }
  static Future<void> updateMessageStatus(String senderId,String receiverId,String status) async {
    var messages = await _firestore.collection('clients')
        .doc(receiverId)
        .collection('messages')
        .doc(senderId)
        .collection('chats')
        .where('status',isEqualTo: 'seen')
        .get();

    for (var doc in messages.docs) {
      await doc.reference.update({'status':status});
    }
  }


}