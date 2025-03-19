import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/Profiles/OthersProfile.dart';
import 'package:mymateapp/MyMateCommonBodies/MyMateBottomBar.dart';
import 'package:mymateapp/MyMateThemes.dart';

import 'notification_service.dart';

class NotificationPage extends StatefulWidget {
  final int selectedBottomBarIconIndex;
  final String docId;

  const NotificationPage(this.selectedBottomBarIconIndex,{super.key,required this.docId});


  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    NotificationService.initialize();
    _fetchNotifications();
    print("doc id passed here is :${widget.docId}");
    print (notifications);
  }


  Future<void> _fetchNotifications() async {
    try {
      List<Map<String, dynamic>> fetchedNotifications = await NotificationService.fetchRequests(widget.docId);

      setState(() {
        notifications = fetchedNotifications;
        print('Notifications fetched: $notifications');
      });
    } catch (e) {
      print("Error fetching notifications: $e");
    }
  }

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
                  String type = notifications[index]
                  ['type']; // 'request' or 'accept'
                  String docId = notifications[index]['docId'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: NotificationContainer(
                        name, imageUrl, type, docId, context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }
  Widget _buildNavigationBar() {
    return CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      docId: widget.docId,
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
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: MyMateThemes.textColor),
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
          builder: (context) => OtherProfilePage(SoulId: docId),
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.all(10), // Padding for better spacing
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 35,
            onBackgroundImageError: (_, __) => Icon(Icons.account_circle, size: 70), // Fallback icon
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name, // Full Name in First Line
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: MyMateThemes.textColor,
                  ),
                ),
                SizedBox(height: 5), // Small spacing
                Text(
                  type == 'request' ? 'Sent you a request' : 'Accepted your request', // Type in Second Line
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}