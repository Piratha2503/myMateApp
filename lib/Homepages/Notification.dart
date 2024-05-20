import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  int _notificationCount = 0;

  int get notificationCount => _notificationCount;

  void setNotificationCount(int count) {
    _notificationCount = count;
    notifyListeners();
  }

  // Mock fetching data from a database
  void fetchNotificationCount() {
    // Simulate a network call and update the count
    Future.delayed(Duration(seconds: 2), () {
      setNotificationCount(15); // Example count
    });
  }
}
