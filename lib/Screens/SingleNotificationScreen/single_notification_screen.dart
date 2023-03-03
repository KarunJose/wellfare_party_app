import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../MainConst/main_const.dart';
import '../../models/notification_modal.dart' as notification_model;
import '../../providers/notificationprovider.dart';

class SingleNotificationScreen extends StatefulWidget {
  static const String id = "notificationScreen";
  notification_model.Notification notification;

  SingleNotificationScreen({required this.notification, Key? key})
      : super(key: key);

  @override
  State<SingleNotificationScreen> createState() =>
      _SingleNotificationScreenState();
}

class _SingleNotificationScreenState extends State<SingleNotificationScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  // _getInitialDetails() {
  //   Provider.of<NotificationProvider>(context, listen: false).getNotification();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: primaryGreen),
        title: const Text(
          "Notifications & Informations",
          style: TextStyle(color: primaryGreen, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   widget.notification.date.toString(),
            //   style: const TextStyle(
            //       fontSize: 14,
            //       color: Colors.green,
            //       fontWeight: FontWeight.bold),
            // ),
            Text(
              widget.notification.type,
              style: TextStyle(color: primaryRed),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                widget.notification.heading,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                widget.notification.text,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
