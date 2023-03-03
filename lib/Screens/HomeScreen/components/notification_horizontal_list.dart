import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/Screens/SingleNotificationScreen/single_notification_screen.dart';
import 'package:wellfare_party_app/api/notification_api.dart';
import 'package:wellfare_party_app/providers/notificationprovider.dart';

import '../../../MainConst/main_const.dart';

class NotificationHorizontalList extends StatefulWidget {
  const NotificationHorizontalList({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationHorizontalList> createState() =>
      _NotificationHorizontalListState();
}

class _NotificationHorizontalListState
    extends State<NotificationHorizontalList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, notificationProvider, child) => notificationProvider
              .unreadNotifications.isEmpty
          ? Container()
          : SizedBox(
              height: 160,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Notifications",
                      style: TextStyle(color: primaryGreyColor, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var notification
                            in notificationProvider.unreadNotifications)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                readNotificationAPI(notification.id);
                                notificationProvider.getNotification();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        SingleNotificationScreen(
                                          notification: notification,
                                        )),
                                  ),
                                );
                              },
                              child: Container(
                                height: 140,
                                width: 260,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xff3C7252),
                                        Color(0xff44C576),
                                      ]),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        color: Colors.grey.shade300),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // ignore: sized_box_for_whitespace
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.7,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            notification.heading,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // ignore: sized_box_for_whitespace
                                        Container(
                                          height: 60,
                                          child: Text(
                                            notification.text,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
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
}
