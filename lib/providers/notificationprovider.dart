import 'package:flutter/foundation.dart';
import 'package:wellfare_party_app/api/notification_api.dart';
import 'package:wellfare_party_app/models/notification_modal.dart';

class NotificationProvider extends ChangeNotifier {
  List<Notification> unreadNotifications = [];
  List<Notification> allnotifications = [];

  bool loading = false;

  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  getNotification() async {
    unreadNotifications = [];
    toggleloading(true);
    var response = await getNotificationAPI();
    var responseJson = response.data;
    for (var notificationJson in responseJson['notifications']) {
      Notification tempNotification = Notification.fromJson(notificationJson);
      unreadNotifications.add(tempNotification);
    }
    toggleloading(false);
  }

  getInboxNotification() async {
    allnotifications = [];
    toggleloading(true);
    var response = await getInboxNotificationAPI();
    var responseJson = response.data;
    for (var notificationJson in responseJson['notifications']) {
      Notification tempNotification = Notification.fromJson(notificationJson);
      allnotifications.add(tempNotification);
    }
    toggleloading(false);
  }
}
