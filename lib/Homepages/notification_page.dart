import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/Profiles/OthersProfile.dart';
import 'package:mymateapp/MyMateThemes.dart';

import 'notification_service.dart';


class NotificationPage extends StatefulWidget {
  final int selectedBottomBarIconIndex;
  final String docId;

  const NotificationPage({Key? key, required this.selectedBottomBarIconIndex, required this.docId}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    NotificationService.initialize();
    // _fetchNotifications();
  }

  // Fetch notifications from API
  // Future<void> _fetchNotifications() async {
  //   try {
  //     List<Map<String, dynamic>> fetchedNotifications = await NotificationService.fetchRequests(widget.docId);
  //     setState(() {
  //       notifications = fetchedNotifications;
  //     });
  //   } catch (e) {
  //     print("Error fetching notifications: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            UserDetails(),
            Divider(),
            Expanded(
              child: notifications.isEmpty
                  ? Center(child: Text("No new notifications"))
                  : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {

                  String name = notifications[index]['fullName'];
                  String imageUrl = notifications[index]['profileImage'];
                  String type = notifications[index]['type']; // 'request' or 'accept'
                  String docId = notifications[index]['docId'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: NotificationContainer(name, imageUrl,type,docId,context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// User details widget
Padding UserDetails() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        SizedBox(width: 80.0),
        Text(
          'Notifications',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: MyMateThemes.textColor),
        ),
      ],
    ),
  );
}

Widget NotificationContainer(String name, String imageUrl, String type, String docId, BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Navigate to the user profile page when tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtherProfilePage(SoulId: docId,

          ),
        ),
      );
    },
    child: Container(
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: SingleChildScrollView(
        // Allows horizontal scrolling
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 20),
            CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 30),
            SizedBox(width: 20),
            Text(
              "$name ${type == 'request' ? 'sent you a request' : 'accepted your request'}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: MyMateThemes.textColor),
            ),
          ],
        ),
      ),
    ),
  );
}
