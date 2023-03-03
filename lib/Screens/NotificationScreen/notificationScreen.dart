import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/Screens/SingleNotificationScreen/single_notification_screen.dart';
import 'package:wellfare_party_app/commonComponents/myLoader.dart';
import 'package:wellfare_party_app/providers/notificationprovider.dart';

class NotificationListScreen extends StatefulWidget {
  static const String id = "notificationListScreen";
  NotificationListScreen({Key? key}) : super(key: key);

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() {
    Provider.of<NotificationProvider>(context, listen: false)
        .getInboxNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryGreen),
        backgroundColor: Colors.white,
        title: const Text(
          "Notifications & Informations",
          style: TextStyle(
            color: primaryGreen,
            fontSize: 16,
          ),
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) => notificationProvider
                    .loading ==
                true
            ? MyLoader()
            : ListView(
                children: [
                  for (var notification
                      in notificationProvider.allnotifications)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => SingleNotificationScreen(
                                  notification: notification,
                                )),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    notification.type,
                                    style: TextStyle(color: primaryRed),
                                  ),
                                  Text(notification.date.toString())
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.7,
                                child: Text(
                                  notification.heading,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1,
                                child: Text(
                                  notification.text,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
      ),
    );
  }
}
